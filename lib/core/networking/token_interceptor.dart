import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:synchronized/synchronized.dart';
import '../services/auth_navigation_service.dart';

class TokenInterceptor extends Interceptor {
  final AuthNavigationService _authService;
  final Dio _dio;
  final _lock = Lock();
  final List<_RequestQueueItem> _queue = [];
  bool _isRefreshing = false;

  TokenInterceptor(this._authService, this._dio);

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    // Don't add token for refresh token requests
    if (options.path.contains('refresh-token')) {
      return handler.next(options);
    }

    final token = await _authService.getAccessToken();
    if (token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    return handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (_shouldRefreshToken(err)) {
      final completer = Completer<Response>();

      // Queue the failed request
      _queue.add(_RequestQueueItem(
        options: err.requestOptions,
        completer: completer,
      ));

      // Start token refresh if not already in progress
      if (!_isRefreshing) {
        _isRefreshing = true;
        try {
          final newToken = await _lock.synchronized(() async {
            final success = await _authService.refreshTokenMethod();
            if (success) {
              return await _authService.getAccessToken();
            }
            return null;
          });

          if (newToken != null) {
            // Process queued requests with new token
            await _processQueue(newToken);
          } else {
            // Token refresh failed, reject all queued requests
            _rejectQueue(err);
          }
        } catch (e) {
          debugPrint('Error during token refresh: $e');
          _rejectQueue(err);
        } finally {
          _isRefreshing = false;
          _queue.clear();
        }
      }

      try {
        // Wait for this request's completion
        final response = await completer.future;
        return handler.resolve(response);
      } catch (e) {
        return handler.next(DioException(
          requestOptions: err.requestOptions,
          error: e.toString(),
        ));
      }
    }

    // For other errors, continue with error handling
    return handler.next(err);
  }

  bool _shouldRefreshToken(DioException err) {
    final isAuthError = err.response?.statusCode == 401;
    final isSessionTimeout =
        err.response?.data?['error']?['code'] == 'SESSION_TIMEOUT';
    final isNotRefreshRequest =
        !err.requestOptions.path.contains('refresh-token');

    return (isAuthError || isSessionTimeout) && isNotRefreshRequest;
  }

  Future<void> _processQueue(String newToken) async {
    final requests = List<_RequestQueueItem>.from(_queue);

    for (var request in requests) {
      try {
        final response = await _retryRequest(request.options, newToken);
        request.completer.complete(response);
      } catch (e) {
        request.completer.completeError(e);
      }
    }
  }

  void _rejectQueue(DioException err) {
    for (var request in _queue) {
      request.completer.completeError(err);
    }
  }

  Future<Response> _retryRequest(
      RequestOptions options, String newToken) async {
    final retryOptions = Options(
      method: options.method,
      headers: {
        ...options.headers,
        'Authorization': 'Bearer $newToken',
      },
      contentType: options.contentType,
      followRedirects: options.followRedirects,
      validateStatus: options.validateStatus,
    );

    return await _dio.request(
      options.path,
      data: options.data,
      queryParameters: options.queryParameters,
      options: retryOptions,
    );
  }
}

class _RequestQueueItem {
  final RequestOptions options;
  final Completer<Response> completer;

  _RequestQueueItem({
    required this.options,
    required this.completer,
  });
}
