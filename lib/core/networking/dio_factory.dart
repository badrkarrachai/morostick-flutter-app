import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:morostick/core/networking/token_interceptor.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import '../services/auth_navigation_service.dart';

class DioFactory {
  DioFactory._();

  static Dio? dio;
  static AuthNavigationService? _authService;

  static void init(AuthNavigationService authService) {
    _authService = authService;
    getDio();
  }

  static Dio getDio() {
    Duration timeOut = const Duration(seconds: 30);

    if (dio == null) {
      dio = Dio();
      dio!
        ..options.connectTimeout = timeOut
        ..options.receiveTimeout = timeOut;

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
        if (kDebugMode)
          PrettyDioLogger(
            requestBody: true,
            requestHeader: true,
            responseHeader: true,
          ),
      ]);
    }
  }

  static void setTokenIntoHeaderAfterLogin(String token) {
    dio?.options.headers['Authorization'] = 'Bearer $token';
  }

  static void removeTokenFromHeader() {
    dio?.options.headers.remove('Authorization');
  }
}
