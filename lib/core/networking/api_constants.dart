import 'package:morostick/core/config/app_config.dart';
import 'package:morostick/core/data/models/general_response_model.dart';

class ApiConstants {
  static String apiBaseUrl = AppConfig.apiBaseUrl;

  static const String login = "auth/login";
  static const String signup = "auth/register";
  static const String useAuthGoogle = "auth/google/mobile";
  static const String useAuthFacebook = "auth/facebook/mobile";
  static const String forgetPasswordSendCode = "auth/reset-password-request";
  static const String verifyOtp = "auth/verify-otp";
  static const String resetPassword = "auth/reset-password";
  static const String refreshToken = 'auth/refresh-token';
}

class ErrorConstantData {
  final String title;
  final ErrorDetails message;
  const ErrorConstantData(this.title, this.message);
}

class ApiErrors {
  static const ErrorConstantData badRequestError = ErrorConstantData(
    'Bad Request',
    ErrorDetails(
      code: 'ERR_400',
      details:
          'Sorry, something is missing in your request. Please try again or contact us.',
      errorFields: null,
    ),
  );

  static const ErrorConstantData noContent = ErrorConstantData(
    'No Content',
    ErrorDetails(
      code: 'ERR_204',
      details:
          'Sorry, there is no content to display. Please try again or contact us.',
      errorFields: null,
    ),
  );

  static const ErrorConstantData forbiddenError = ErrorConstantData(
    'Forbidden',
    ErrorDetails(
      code: 'ERR_403',
      details:
          'Sorry, you are not allowed to perform this action. Please try again or contact us.',
      errorFields: null,
    ),
  );

  static const ErrorConstantData unauthorizedError = ErrorConstantData(
    'Unauthorized',
    ErrorDetails(
      code: 'ERR_401',
      details:
          'Sorry, you are not authorized to perform this action. Please try again or contact us.',
      errorFields: null,
    ),
  );

  static const ErrorConstantData notFoundError = ErrorConstantData(
    'Not Found',
    ErrorDetails(
      code: 'ERR_404',
      details:
          'Sorry, this resource was not found. Please try again or contact us.',
      errorFields: null,
    ),
  );

  static const ErrorConstantData conflictError = ErrorConstantData(
    'Conflict',
    ErrorDetails(
      code: 'ERR_409',
      details:
          'Sorry, there is a conflict in your request. Please try again or contact us.',
      errorFields: null,
    ),
  );

  static const ErrorConstantData internalServerError = ErrorConstantData(
    'Internal Server Error',
    ErrorDetails(
      code: 'ERR_500',
      details:
          'Sorry, something went wrong on our server. Please try again later.',
      errorFields: null,
    ),
  );

  static const ErrorConstantData unknownError = ErrorConstantData(
    'Unknown Error',
    ErrorDetails(
      code: 'ERR_000',
      details: 'Sorry, an unknown error occurred. Please try again later.',
      errorFields: null,
    ),
  );

  static const ErrorConstantData timeoutError = ErrorConstantData(
    'Timeout Error',
    ErrorDetails(
      code: 'ERR_408',
      details: 'Sorry, your request timed out. Please try again later.',
      errorFields: null,
    ),
  );

  static const ErrorConstantData cacheError = ErrorConstantData(
    'Cache Error',
    ErrorDetails(
      code: 'ERR_CACHE',
      details:
          'Sorry, an error occurred while caching your request. Please try again later.',
      errorFields: null,
    ),
  );

  static const ErrorConstantData noInternetError = ErrorConstantData(
    'No Internet Connection',
    ErrorDetails(
      code: 'ERR_NETWORK',
      details:
          'Sorry, you are not connected to the internet. Please check your connection and try again.',
      errorFields: null,
    ),
  );

  static const ErrorConstantData loadingMessage = ErrorConstantData(
    'Loading...',
    ErrorDetails(
      code: 'INFO_LOADING',
      details: 'Please wait while we process your request.',
      errorFields: null,
    ),
  );

  static const ErrorConstantData retryAgainMessage = ErrorConstantData(
    'Retry Again',
    ErrorDetails(
      code: 'ERR_RETRY',
      details: 'Sorry, something went wrong. Please try again later.',
      errorFields: null,
    ),
  );

  static const ErrorConstantData defaultError = ErrorConstantData(
    'Error Occurred',
    ErrorDetails(
      code: 'ERR_DEFAULT',
      details: 'Sorry, an unexpected error occurred. Please try again later.',
      errorFields: null,
    ),
  );

  static const ErrorConstantData ok = ErrorConstantData(
    'Success',
    ErrorDetails(
      code: 'SUCCESS_200',
      details: 'Your request was successful!',
      errorFields: null,
    ),
  );
}
