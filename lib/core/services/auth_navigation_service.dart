import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:morostick/core/services/facebook_auth_service.dart';
import 'package:morostick/core/services/google_auth_service.dart';
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
  StreamSubscription<List<ConnectivityResult>>? _connectivitySubscription;

  bool get isAuthenticated => _isAuthenticated;
  bool get isFirstTime => _isFirstTime;
  bool get isOffline => _isOffline;

  AuthNavigationService({
    required GoogleAuthService googleAuthService,
    required FacebookAuthService facebookAuthService,
  })  : _googleAuthService = googleAuthService,
        _facebookAuthService = facebookAuthService {
    _initConnectivityListener();
  }

  void setIsOffline(bool value) {
    _isOffline = value;
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

  Future<bool> refreshTokenMethod() async {
    try {
      final hasConnection = await _checkConnectivity();
      if (!hasConnection) {
        _isOffline = true;
        notifyListeners();
        return false;
      }

      final refreshToken =
          await SharedPrefHelper.getSecuredString(SharedPrefKeys.refreshToken);
      if (refreshToken.isEmpty || _isRefreshTokenExpired(refreshToken)) {
        await logout();
        return false;
      }

      final dio = Dio();
      final response = await dio.post(
        '${ApiConstants.apiBaseUrl}auth/refresh-token',
        options: Options(headers: {'X-Refresh-Token': refreshToken}),
      );

      if (response.statusCode == 200 && response.data['data'] != null) {
        final newAccessToken = response.data['data']['accessToken'];
        await SharedPrefHelper.setSecuredString(
            SharedPrefKeys.userToken, newAccessToken);
        DioFactory.setTokenIntoHeaderAfterLogin(newAccessToken);
        _isOffline = false;
        return true;
      }

      await logout();
      return false;
    } catch (e) {
      debugPrint('Token refresh failed: $e');
      if (await _checkConnectivity()) {
        await logout();
      } else {
        _isOffline = true;
        notifyListeners();
      }
      return false;
    }
  }

  Future<void> checkInitialStatus() async {
    final hasSeenOnboarding =
        await SharedPrefHelper.getBool('has_seen_onboarding') ?? false;
    _isFirstTime = !hasSeenOnboarding;

    String accessToken =
        await SharedPrefHelper.getSecuredString(SharedPrefKeys.userToken);
    String refreshToken =
        await SharedPrefHelper.getSecuredString(SharedPrefKeys.refreshToken);

    if (accessToken.isNotEmpty) {
      if (await _checkConnectivity()) {
        // Online flow
        if (_shouldRefreshToken(accessToken)) {
          final refreshSuccessful = await refreshTokenMethod();
          setAuthStatus(refreshSuccessful);
        } else {
          setAuthStatus(true);
        }
      } else {
        // Offline flow
        if (refreshToken.isEmpty || _isRefreshTokenExpired(refreshToken)) {
          await logout();
          setAuthStatus(false);
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
