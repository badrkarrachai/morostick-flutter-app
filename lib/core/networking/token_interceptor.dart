import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:morostick/core/services/auth_navigation_service.dart';

class TokenInterceptor extends Interceptor {
  final AuthNavigationService _authService;
  final int maxRetries;
  final Duration retryDelay;
  final Map<String, RetryQueue> _retryQueues = {};

  TokenInterceptor(
    this._authService, {
    this.maxRetries = 3,
    this.retryDelay = const Duration(seconds: 1),
  });

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    final requestKey = _getRequestKey(response.requestOptions);
    _retryQueues[requestKey]?.complete(response);
    _retryQueues.remove(requestKey);
    handler.next(response);
  }

  @override
  Future<void> onError(
      DioException err, ErrorInterceptorHandler handler) async {
    final requestKey = _getRequestKey(err.requestOptions);
    final retryQueue = _retryQueues[requestKey];

    if (err.error is SocketException ||
        err.type == DioExceptionType.connectionError) {
      if (retryQueue == null || retryQueue.attempts < maxRetries) {
        await _handleRetry(err, handler, requestKey);
        return;
      }
      _authService.setIsOffline(true);
    }

    if (err.response?.statusCode == 401) {
      final isRefreshed = await _authService.refreshToken();
      if (isRefreshed) {
        await _retryFailedRequests();
        final token = await _authService.getAccessToken();
        err.requestOptions.headers['Authorization'] = 'Bearer $token';
        try {
          final response = await Dio().fetch(err.requestOptions);
          handler.resolve(response);
          return;
        } catch (e) {
          if (retryQueue == null || retryQueue.attempts < maxRetries) {
            await _handleRetry(err, handler, requestKey);
            return;
          }
        }
      }
      await _authService.logout();
    }

    _retryQueues.remove(requestKey);
    handler.next(err);
  }

  Future<void> _handleRetry(
    DioException err,
    ErrorInterceptorHandler handler,
    String requestKey,
  ) async {
    final retryQueue = _retryQueues[requestKey] ??= RetryQueue();
    retryQueue.attempts++;

    await Future.delayed(retryDelay * retryQueue.attempts);
    try {
      final response = await Dio().fetch(err.requestOptions);
      handler.resolve(response);
    } catch (e) {
      handler.next(err);
    }
  }

  Future<void> _retryFailedRequests() async {
    final requests = Map<String, RetryQueue>.from(_retryQueues);
    for (final entry in requests.entries) {
      if (!entry.value.isCompleted) {
        try {
          final response = await Dio().fetch(entry.value.requestOptions);
          entry.value.complete(response);
        } catch (e) {
          rethrow;
        }
      }
    }
  }

  String _getRequestKey(RequestOptions options) {
    return '${options.method}:${options.path}:${options.data.hashCode}';
  }
}

class RetryQueue {
  int attempts = 0;
  bool isCompleted = false;
  late RequestOptions requestOptions;
  final _completer = Completer<Response>();

  void complete(Response response) {
    if (!_completer.isCompleted) {
      isCompleted = true;
      _completer.complete(response);
    }
  }

  Future<Response> get future => _completer.future;
}
