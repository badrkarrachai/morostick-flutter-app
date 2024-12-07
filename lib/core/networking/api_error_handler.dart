import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:morostick/core/data/models/general_response_model.dart';
import 'package:morostick/core/helpers/extensions.dart';
import 'package:morostick/core/widgets/app_snackbar.dart';

import 'api_constants.dart';

enum DataSource {
  noContent,
  badRequest,
  forbidden,
  unauthorized,
  notFound,
  internalServerError,
  connectTimeout,
  cancel,
  receiveTimeout,
  sendTimeout,
  cacheError,
  noInternetConnection,
  defaultStatus
}

class ResponseCode {
  static const int success = 200;
  static const int noContent = 201;
  static const int badRequest = 400;
  static const int unauthorized = 401;
  static const int forbidden = 403;
  static const int notFound = 404;
  static const int apiLogicError = 422;
  static const int internalServerError = 500;

  // Local status codes
  static const int connectTimeout = -1;
  static const int cancel = -2;
  static const int receiveTimeout = -3;
  static const int sendTimeout = -4;
  static const int cacheError = -5;
  static const int noInternetConnection = -6;
  static const int defaultError = -7;
}

class ResponseMessage {
  static const ErrorConstantData noContent = ApiErrors.noContent;
  static const ErrorConstantData badRequest = ApiErrors.badRequestError;
  static const ErrorConstantData unauthorized = ApiErrors.unauthorizedError;
  static const ErrorConstantData forbidden = ApiErrors.forbiddenError;
  static const ErrorConstantData internalServerError =
      ApiErrors.internalServerError;
  static const ErrorConstantData notFound = ApiErrors.notFoundError;
  static const ErrorConstantData connectTimeout = ApiErrors.timeoutError;
  static const ErrorConstantData cancel = ApiErrors.defaultError;
  static const ErrorConstantData receiveTimeout = ApiErrors.timeoutError;
  static const ErrorConstantData sendTimeout = ApiErrors.timeoutError;
  static const ErrorConstantData cacheError = ApiErrors.cacheError;
  static const ErrorConstantData noInternetConnection =
      ApiErrors.noInternetError;
  static const ErrorConstantData defaultStatus = ApiErrors.defaultError;
}

extension DataSourceExtension on DataSource {
  GeneralResponse getFailure() {
    switch (this) {
      case DataSource.noContent:
        return GeneralResponse(
            success: false,
            status: ResponseCode.noContent,
            message: ResponseMessage.noContent.title,
            error: ResponseMessage.noContent.message);
      case DataSource.badRequest:
        return GeneralResponse(
            success: false,
            status: ResponseCode.badRequest,
            message: ResponseMessage.badRequest.title,
            error: ResponseMessage.badRequest.message);
      case DataSource.forbidden:
        return GeneralResponse(
            success: false,
            status: ResponseCode.forbidden,
            message: ResponseMessage.forbidden.title,
            error: ResponseMessage.forbidden.message);
      case DataSource.unauthorized:
        return GeneralResponse(
            success: false,
            status: ResponseCode.unauthorized,
            message: ResponseMessage.unauthorized.title,
            error: ResponseMessage.unauthorized.message);
      case DataSource.notFound:
        return GeneralResponse(
            success: false,
            status: ResponseCode.notFound,
            message: ResponseMessage.notFound.title,
            error: ResponseMessage.notFound.message);
      case DataSource.internalServerError:
        return GeneralResponse(
            success: false,
            status: ResponseCode.internalServerError,
            message: ResponseMessage.internalServerError.title,
            error: ResponseMessage.internalServerError.message);
      case DataSource.connectTimeout:
        return GeneralResponse(
            success: false,
            status: ResponseCode.connectTimeout,
            message: ResponseMessage.connectTimeout.title,
            error: ResponseMessage.connectTimeout.message);
      case DataSource.cancel:
        return GeneralResponse(
            success: false,
            status: ResponseCode.cancel,
            message: ResponseMessage.cancel.title,
            error: ResponseMessage.cancel.message);
      case DataSource.receiveTimeout:
        return GeneralResponse(
            success: false,
            status: ResponseCode.receiveTimeout,
            message: ResponseMessage.receiveTimeout.title,
            error: ResponseMessage.receiveTimeout.message);
      case DataSource.sendTimeout:
        return GeneralResponse(
            success: false,
            status: ResponseCode.sendTimeout,
            message: ResponseMessage.sendTimeout.title,
            error: ResponseMessage.sendTimeout.message);
      case DataSource.cacheError:
        return GeneralResponse(
            success: false,
            status: ResponseCode.cacheError,
            message: ResponseMessage.cacheError.title,
            error: ResponseMessage.cacheError.message);
      case DataSource.noInternetConnection:
        return GeneralResponse(
            success: false,
            status: ResponseCode.noInternetConnection,
            message: ResponseMessage.noInternetConnection.title,
            error: ResponseMessage.noInternetConnection.message);
      case DataSource.defaultStatus:
        return GeneralResponse(
            success: false,
            status: ResponseCode.defaultError,
            message: ResponseMessage.defaultStatus.title,
            error: ResponseMessage.defaultStatus.message);
    }
  }
}

class ErrorHandler implements Exception {
  late GeneralResponse apiErrorModel;

  static void setupErrorState(BuildContext context, GeneralResponse error) {
    context.pop();
    if (error.message == "Timeout Error") return;

    showAppSnackbar(
      title: error.message,
      duration: 3,
      description: error.error?.details ??
          "Something went wrong. Please try again later.",
    );
  }

  ErrorHandler.handle(dynamic error) {
    if (error is DioException) {
      apiErrorModel = _handleDioError(error);
      _printDetailedError(error);
    } else {
      apiErrorModel = DataSource.defaultStatus.getFailure();
      print('Non-Dio Error: $error');
    }
  }

  void _printDetailedError(DioException error) {
    print('\n=== API Error Details ===');
    print('Type: ${error.type}');
    print('Error Message: ${error.message}');

    if (error.response != null) {
      print('Status Code: ${error.response?.statusCode}');
      print('Status Message: ${error.response?.statusMessage}');
      print('Data: ${error.response?.data}');
      print('Headers: ${error.response?.headers}');
    }

    if (error.error != null) {
      print('Error: ${error.error}');
    }
    print('=====================\n');
  }

  GeneralResponse _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return DataSource.connectTimeout.getFailure();
      case DioExceptionType.sendTimeout:
        return DataSource.sendTimeout.getFailure();
      case DioExceptionType.receiveTimeout:
        return DataSource.receiveTimeout.getFailure();
      case DioExceptionType.badResponse:
        if (error.response != null) {
          try {
            return GeneralResponse.fromJson(error.response!.data);
          } catch (e) {
            print('Error parsing API error response: $e');
            return GeneralResponse(
              success: false,
              status: error.response?.statusCode ??
                  ResponseCode.internalServerError,
              message:
                  error.response?.statusMessage ?? 'Unknown error occurred',
            );
          }
        }
        return DataSource.defaultStatus.getFailure();
      case DioExceptionType.cancel:
        return DataSource.cancel.getFailure();
      case DioExceptionType.connectionError:
        return DataSource.noInternetConnection.getFailure();
      case DioExceptionType.badCertificate:
        return const GeneralResponse(
          success: false,
          status: 495,
          message: 'SSL Certificate error',
          error: ErrorDetails(
            code: 'ERR_SSL',
            details:
                'Invalid SSL certificate. Please check your connection security.',
          ),
        );
      case DioExceptionType.unknown:
        return error.error != null
            ? GeneralResponse(
                success: false,
                status: ResponseCode.internalServerError,
                message: error.error.toString(),
                error: ErrorDetails(
                  code: 'ERR_UNKNOWN',
                  details: error.error.toString(),
                ),
              )
            : DataSource.defaultStatus.getFailure();
    }
  }
}

class ApiInternalStatus {
  static const int success = 0;
  static const int failure = 1;
}
