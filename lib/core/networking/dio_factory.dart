import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:morostick/core/networking/token_interceptor.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import '../services/auth_navigation_service.dart';
import '../widgets/app_offline_banner.dart'; // Import for OfflineReason enum

class DioFactory {
  DioFactory._();

  static Dio? dio;
  static AuthNavigationService? _authService;
  static const Duration _connectTimeout = Duration(seconds: 5);
  static const Duration _receiveTimeout = Duration(seconds: 30);
  static const Duration _sendTimeout = Duration(seconds: 30);

  static void init(AuthNavigationService authService) {
    _authService = authService;
    getDio();
  }

  static Dio getDio() {
    if (dio == null) {
      dio = Dio();
      dio!.options = BaseOptions(
        connectTimeout: _connectTimeout,
        receiveTimeout: _receiveTimeout,
        sendTimeout: _sendTimeout,
      );

      addDioHeaders();
      addDioInterceptors();

      return dio!;
    } else {
      return dio!;
    }
  }

  static void addDioHeaders() async {
    final token = await _authService?.getAccessToken();
    dio?.options.headers = {
      'Accept': 'application/json',
      if (token != null && token.isNotEmpty) 'Authorization': 'Bearer $token',
    };
  }

  static void addDioInterceptors() {
    if (dio != null && _authService != null) {
      dio!.interceptors.addAll([
        TokenInterceptor(_authService!),
        InterceptorsWrapper(
          onRequest: (options, handler) {
            // Reset offline state when starting a new request
            _authService?.setIsOffline(false);
            return handler.next(options);
          },
          onError: (DioException e, handler) {
            if (e.type == DioExceptionType.connectionTimeout ||
                e.type == DioExceptionType.receiveTimeout ||
                e.type == DioExceptionType.sendTimeout) {
              _authService?.setIsOffline(true,
                  reason: OfflineReason.serverTimeout);
            }
            return handler.next(e);
          },
          onResponse: (response, handler) {
            // Reset offline state on successful response
            _authService?.setIsOffline(false);
            return handler.next(response);
          },
        ),
        // For debugging purpose
        // if (kDebugMode)
        //   PrettyDioLogger(
        //     requestBody: true,
        //     requestHeader: true,
        //     responseHeader: true,
        //   ),
      ]);
    }
  }

  static void setTokenIntoHeaderAfterLogin(String token) {
    dio?.options.headers['Authorization'] = 'Bearer $token';
  }

  static void removeTokenFromHeader() {
    dio?.options.headers.remove('Authorization');
  }

  static bool isTimeoutError(DioException error) {
    return error.type == DioExceptionType.connectionTimeout ||
        error.type == DioExceptionType.receiveTimeout ||
        error.type == DioExceptionType.sendTimeout;
  }
}
