import 'package:morostick/core/networking/api_error_handler.dart';
import 'package:morostick/core/networking/api_result.dart';
import 'package:morostick/core/networking/api_service.dart';
import 'package:morostick/features/auth/login/data/models/login_request_body.dart';
import 'package:morostick/features/auth/login/data/models/login_response.dart';
import 'package:morostick/features/auth/login/data/models/login_with_facebook_model.dart';
import 'package:morostick/features/auth/login/data/models/login_with_google_model.dart';

class LoginRepo {
  final ApiService _apiService;

  LoginRepo(this._apiService);

  Future<ApiResult<LoginResponse>> login(
      LoginRequestBody loginRequestBody) async {
    try {
      final response = await _apiService.login(loginRequestBody);
      return ApiResult.success(response);
    } catch (errro) {
      return ApiResult.failure(ErrorHandler.handle(errro));
    }
  }

  Future<ApiResult<LoginResponse>> loginWithGoogle(
      GoogleSignInRequestBody googleSignInRequestBody) async {
    try {
      final response =
          await _apiService.loginWithGoogle(googleSignInRequestBody);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }

  Future<ApiResult<LoginResponse>> loginWithFacebook(
      FacebookSignInRequestBody facebookSignInRequestBody) async {
    try {
      final response =
          await _apiService.loginWithFacebbok(facebookSignInRequestBody);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }
}
