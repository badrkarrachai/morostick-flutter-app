import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:morostick/core/networking/api_constants.dart';
import 'package:morostick/core/networking/token_interceptor.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import '../services/auth_navigation_service.dart';
import '../widgets/app_offline_messagebox.dart';

class DioFactory {
  DioFactory._();

  static Dio? _dio;
  static AuthNavigationService? _authService;
  static const Duration _connectTimeout = Duration(seconds: 5);
  static const Duration _receiveTimeout = Duration(seconds: 30);
  static const Duration _sendTimeout = Duration(seconds: 30);

  static void init(AuthNavigationService authService) {
    _authService = authService;
    _dio = _createDio();
    _addInterceptors();
  }

  static Dio _createDio() {
    return Dio(
      BaseOptions(
        baseUrl: ApiConstants.apiBaseUrl, // Make sure this is set
        connectTimeout: _connectTimeout,
        receiveTimeout: _receiveTimeout,
        sendTimeout: _sendTimeout,
        validateStatus: (status) {
          // Treat 401 and 403 as errors, along with 500+ status codes
          return status != null && status >= 200 && status < 300;
        },
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      ),
    );
  }

  static void _addInterceptors() {
    if (_dio != null && _authService != null) {
      _dio!.interceptors.clear();

      // Add token interceptor first
      _dio!.interceptors.add(
        TokenInterceptor(_authService!, _dio!),
      );

      // Add connectivity interceptor
      _dio!.interceptors.add(
        InterceptorsWrapper(
          onRequest: (options, handler) async {
            _authService?.setIsOffline(false);
            return handler.next(options);
          },
          onError: (DioException e, handler) {
            if (isTimeoutError(e)) {
              _authService?.setIsOffline(true,
                  reason: OfflineReason.serverTimeout);
            }
            return handler.next(e);
          },
          onResponse: (response, handler) {
            _authService?.setIsOffline(false);
            return handler.next(response);
          },
        ),
      );

      // Add logger in debug mode
      if (kDebugMode) {
        _dio!.interceptors.add(
          PrettyDioLogger(
            requestBody: true,
            requestHeader: true,
            responseHeader: true,
            responseBody: false,
            error: true,
            compact: true,
          ),
        );
      }
    }
  }

  static Dio getDio() {
    if (_dio == null) {
      throw Exception('DioFactory not initialized. Call init() first.');
    }
    return _dio!;
  }

  static void setTokenIntoHeaderAfterLogin(String token) {
    if (_dio != null) {
      _dio!.options.headers['Authorization'] = 'Bearer $token';
    }
  }

  static void removeTokenFromHeader() {
    if (_dio != null) {
      _dio!.options.headers.remove('Authorization');
    }
  }

  static bool isTimeoutError(DioException error) {
    return error.type == DioExceptionType.connectionTimeout ||
        error.type == DioExceptionType.receiveTimeout ||
        error.type == DioExceptionType.sendTimeout;
  }

  static void dispose() {
    _dio?.close(force: true);
    _dio = null;
    _authService = null;
  }
}
