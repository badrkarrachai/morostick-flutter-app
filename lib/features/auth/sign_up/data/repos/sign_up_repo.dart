import 'package:dio/dio.dart';
import 'package:morostick/core/networking/api_error_handler.dart';
import 'package:morostick/core/networking/api_result.dart';
import 'package:morostick/core/networking/api_service.dart';
import 'package:morostick/features/auth/sign_up/data/models/sign_up_request_body.dart';
import 'package:morostick/features/auth/sign_up/data/models/sign_up_response.dart';
import 'package:morostick/features/auth/sign_up/data/models/sign_up_with_facebook_model.dart';
import 'package:morostick/features/auth/sign_up/data/models/sign_up_with_google_model.dart';

class SignupRepo {
  final ApiService _apiService;

  SignupRepo(this._apiService);

  Future<ApiResult<SignUpResponse>> signup(
      SignupRequestBody signupRequestBody) async {
    try {
      final response = await _apiService.signup(signupRequestBody);
      return ApiResult.success(response);
    } on DioException catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    } catch (error) {
      // Handle other types of exceptions here
      rethrow;
    }
  }

  Future<ApiResult<SignUpResponse>> signUpWithGoogle(
      GoogleSignUpRequestBody googleSignUpRequestBody) async {
    try {
      final response =
          await _apiService.signupWithGoogle(googleSignUpRequestBody);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }

  Future<ApiResult<SignUpResponse>> signUpWithFacebook(
      FacebookSignUpRequestBody facebookSignInRequestBody) async {
    try {
      final response =
          await _apiService.signupWithFacebook(facebookSignInRequestBody);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }
}
