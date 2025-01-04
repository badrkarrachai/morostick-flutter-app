import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:morostick/core/di/dependency_injection.dart';
import 'package:morostick/core/helpers/extensions.dart';
import 'package:morostick/core/networking/token_interceptor.dart';
import 'package:morostick/core/routing/routes.dart';
import 'package:morostick/core/services/facebook_auth_service.dart';
import 'package:morostick/core/services/google_auth_service.dart';
import 'package:morostick/core/widgets/app_message_box.dart';
import 'package:morostick/core/widgets/app_offline_messagebox.dart';
import 'package:synchronized/synchronized.dart';
import '../helpers/constants.dart';
import '../helpers/shared_pref_helper.dart';
import '../networking/api_constants.dart';
import '../networking/dio_factory.dart';
import 'dart:convert';

class AuthNavigationService extends ChangeNotifier {
  final GoogleAuthService _googleAuthService;
  final FacebookAuthService _facebookAuthService;
  bool _isAuthenticated = false;
  bool _isFirstTime = true;
  bool _isOffline = false;
  bool _isGuestMode = false;
  StreamSubscription<List<ConnectivityResult>>? _connectivitySubscription;

  bool get isAuthenticated => _isAuthenticated;
  bool get isFirstTime => _isFirstTime;
  bool get isOffline => _isOffline;
  bool get isGuestMode => _isGuestMode;

  OfflineReason? _offlineReason;
  OfflineReason? get offlineReason => _offlineReason;

  Future<void> enableGuestMode() async {
    _isGuestMode = true;
    await SharedPrefHelper.setBool('is_guest_mode', true);
    notifyListeners();
  }

  Future<void> disableGuestMode() async {
    _isGuestMode = false;
    await SharedPrefHelper.setBool('is_guest_mode', false);
    notifyListeners();
  }

  AuthNavigationService({
    required GoogleAuthService googleAuthService,
    required FacebookAuthService facebookAuthService,
  })  : _googleAuthService = googleAuthService,
        _facebookAuthService = facebookAuthService {
    _initConnectivityListener();
  }

  void setIsOffline(bool value, {OfflineReason? reason}) {
    _isOffline = value;
    _offlineReason = value ? (reason ?? OfflineReason.noConnection) : null;
    notifyListeners();
  }

  void _initConnectivityListener() {
    _connectivitySubscription = Connectivity()
        .onConnectivityChanged
        .listen((List<ConnectivityResult> results) {
      bool wasOffline = _isOffline;
      _isOffline = results.contains(ConnectivityResult.none) || results.isEmpty;

      // If coming back online, check token status
      if (wasOffline && !_isOffline && _isAuthenticated) {
        checkInitialStatus();
      }
      notifyListeners();
    });
  }

  Future<bool> _checkConnectivity() async {
    final connectivityResults = await Connectivity().checkConnectivity();
    _isOffline = connectivityResults.contains(ConnectivityResult.none) ||
        connectivityResults.isEmpty;
    notifyListeners();
    return !_isOffline;
  }

  @override
  void dispose() {
    _connectivitySubscription?.cancel();
    super.dispose();
  }

  void setAuthStatus(bool status) {
    _isAuthenticated = status;
    notifyListeners();
  }

  void setFirstTimeStatus(bool status) {
    _isFirstTime = status;
    notifyListeners();
  }

  bool _shouldRefreshToken(String token) {
    try {
      final parts = token.split('.');
      if (parts.length != 3) return true;

      final payload = json
          .decode(utf8.decode(base64Url.decode(base64Url.normalize(parts[1]))));

      final expiry = DateTime.fromMillisecondsSinceEpoch(payload['exp'] * 1000);
      final fiveMinutesFromNow = DateTime.now().add(const Duration(minutes: 5));

      return expiry.isBefore(fiveMinutesFromNow);
    } catch (e) {
      debugPrint('Error decoding token: $e');
      return true;
    }
  }

  bool _isRefreshTokenExpired(String refreshToken) {
    try {
      final parts = refreshToken.split('.');
      if (parts.length != 3) return true;

      final payload = json
          .decode(utf8.decode(base64Url.decode(base64Url.normalize(parts[1]))));
      final expiry = DateTime.fromMillisecondsSinceEpoch(payload['exp'] * 1000);

      return DateTime.now().isAfter(expiry);
    } catch (e) {
      debugPrint('Error checking refresh token expiry: $e');
      return true;
    }
  }

  Future<void> login(String accessToken, {String? refreshToken}) async {
    final hasConnection = await _checkConnectivity();
    if (!hasConnection) {
      _isOffline = true;
      notifyListeners();
      return;
    }
    await SharedPrefHelper.setSecuredString(
        SharedPrefKeys.userToken, accessToken);
    if (refreshToken != null) {
      await SharedPrefHelper.setSecuredString(
          SharedPrefKeys.refreshToken, refreshToken);
    }
    DioFactory.setTokenIntoHeaderAfterLogin(accessToken);
    setAuthStatus(true);
  }

  Future<bool> logout() async {
    try {
      await enableGuestMode();
      if (!await _checkConnectivity()) {
        // Allow logout even when offline
        await Future.wait<void>([
          SharedPrefHelper.removeSecuredString(SharedPrefKeys.userToken),
          SharedPrefHelper.removeSecuredString(SharedPrefKeys.refreshToken),
        ]);
        DioFactory.removeTokenFromHeader();
        setAuthStatus(false);
        _isOffline = true;
        notifyListeners();
        return true;
      }

      // Online logout flow
      await Future.wait<void>([
        _googleAuthService.signOut(),
        _facebookAuthService.signOut(),
        SharedPrefHelper.removeSecuredString(SharedPrefKeys.userToken),
        SharedPrefHelper.removeSecuredString(SharedPrefKeys.refreshToken),
      ]);

      DioFactory.removeTokenFromHeader();
      setAuthStatus(false);
      return true;
    } catch (e) {
      debugPrint('Logout error: $e');
      return false;
    }
  }

  Future<String> getAccessToken() async {
    final token =
        await SharedPrefHelper.getSecuredString(SharedPrefKeys.userToken);
    return token;
  }

  final _refreshLock = Lock();

  Future<bool> refreshTokenMethod() async {
    // Use a lock to prevent multiple simultaneous refresh attempts
    return await _refreshLock.synchronized(() async {
      try {
        final hasConnection = await _checkConnectivity();
        if (!hasConnection) {
          _isOffline = true;
          notifyListeners();
          return _isAuthenticated;
        }

        final refreshToken = await SharedPrefHelper.getSecuredString(
            SharedPrefKeys.refreshToken);
        if (refreshToken.isEmpty || _isRefreshTokenExpired(refreshToken)) {
          await logout();
          return false;
        }

        // Use the main DioFactory instance instead of creating a new one
        final dio = DioFactory.getDio();

        // Remove the token interceptor temporarily to prevent infinite loop
        final tokenInterceptor =
            dio.interceptors.whereType<TokenInterceptor>().firstOrNull;
        if (tokenInterceptor != null) {
          dio.interceptors.remove(tokenInterceptor);
        }

        try {
          final response = await dio.post(
            '${ApiConstants.apiBaseUrl}auth/refresh-token',
            options: Options(
              headers: {'X-Refresh-Token': refreshToken},
              // Don't follow redirects for refresh token requests
              followRedirects: false,
              validateStatus: (status) => status != null && status < 500,
            ),
          );

          // Add back the token interceptor
          if (tokenInterceptor != null) {
            dio.interceptors.add(tokenInterceptor);
          }

          if (response.statusCode == 200 && response.data['data'] != null) {
            final newAccessToken = response.data['data']['accessToken'];
            await SharedPrefHelper.setSecuredString(
                SharedPrefKeys.userToken, newAccessToken);
            DioFactory.setTokenIntoHeaderAfterLogin(newAccessToken);
            _isOffline = false;
            notifyListeners();
            return true;
          }

          await logout();
          return false;
        } finally {
          // Ensure token interceptor is added back even if there's an error
          if (tokenInterceptor != null &&
              !dio.interceptors.contains(tokenInterceptor)) {
            dio.interceptors.add(tokenInterceptor);
          }
        }
      } on DioException catch (e) {
        debugPrint('Token refresh DioError: $e');

        if (e.type == DioExceptionType.connectionTimeout ||
            e.type == DioExceptionType.receiveTimeout ||
            e.type == DioExceptionType.sendTimeout) {
          _isOffline = true;
          _offlineReason = OfflineReason.serverTimeout;
          notifyListeners();
          return _isAuthenticated;
        }

        if (await _checkConnectivity()) {
          await logout();
        } else {
          _isOffline = true;
          notifyListeners();
          return _isAuthenticated;
        }
        return false;
      } catch (e) {
        debugPrint('Token refresh failed: $e');
        if (await _checkConnectivity()) {
          await logout();
        } else {
          _isOffline = true;
          notifyListeners();
          return _isAuthenticated;
        }
        return false;
      }
    });
  }

  Future<void> checkInitialStatus() async {
    final hasSeenOnboarding =
        await SharedPrefHelper.getBool('has_seen_onboarding') ?? false;
    _isFirstTime = !hasSeenOnboarding;

    // Check guest mode first
    _isGuestMode = await SharedPrefHelper.getBool('is_guest_mode') ?? false;
    if (_isGuestMode) {
      setAuthStatus(false);
      return;
    }

    String accessToken =
        await SharedPrefHelper.getSecuredString(SharedPrefKeys.userToken);
    String refreshToken =
        await SharedPrefHelper.getSecuredString(SharedPrefKeys.refreshToken);

    if (accessToken.isNotEmpty) {
      if (await _checkConnectivity()) {
        // Online flow
        if (_shouldRefreshToken(accessToken)) {
          final refreshSuccessful = await refreshTokenMethod();
          // For server timeout, keep the tokens and stay logged in
          if (!refreshSuccessful &&
              _offlineReason != OfflineReason.serverTimeout) {
            setAuthStatus(false);
          } else {
            // Keep logged in for timeout or successful refresh
            setAuthStatus(true);
          }
        } else {
          setAuthStatus(true);
        }
      } else {
        // Offline flow
        if (refreshToken.isEmpty || _isRefreshTokenExpired(refreshToken)) {
          // Don't logout if it's a server timeout
          if (_offlineReason != OfflineReason.serverTimeout) {
            await logout();
            setAuthStatus(false);
          } else {
            setAuthStatus(true);
          }
        } else {
          // Refresh token is still valid, stay logged in
          setAuthStatus(true);
        }
      }

      if (isAuthenticated) {
        DioFactory.setTokenIntoHeaderAfterLogin(accessToken);
      }
    } else {
      setAuthStatus(false);
    }
  }

  Future<void> completeOnboarding() async {
    await SharedPrefHelper.setBool('has_seen_onboarding', true);
    setFirstTimeStatus(false);
  }
}

class GuestDialogService {
  static GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  static void init(GlobalKey<NavigatorState> key) {
    _navigatorKey = key;
  }

  static BuildContext? get _context => _navigatorKey.currentContext;

  static void showGuestRestriction({String? message}) {
    if (_context != null) {
      AppMessageBoxDialogServiceNonContext.showConfirm(
        title: 'Login Required',
        message: message ?? 'Sorry, Please login to access this feature',
        confirmText: 'Login',
        cancelText: 'Cancel',
        icon: HugeIcons.strokeRoundedUser,
        onConfirm: () async {
          await getIt<AuthNavigationService>().disableGuestMode();
          _context?.pushReplacementNamed(Routes.loginScreen);
        },
      );
    }
  }
}
