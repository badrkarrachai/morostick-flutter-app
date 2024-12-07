import 'package:morostick/core/networking/api_error_handler.dart';
import 'package:morostick/core/networking/api_result.dart';
import 'package:morostick/core/networking/api_service.dart';
import 'package:morostick/features/auth/forget_password/new_password/data/models/new_password_request_body.dart';
import 'package:morostick/features/auth/forget_password/new_password/data/models/new_password_response.dart';

class NewPasswordRepo {
  final ApiService _apiService;

  NewPasswordRepo(this._apiService);

  Future<ApiResult<NewPasswordResponse>> resetPassword(
      NewPasswordRequestBody resetPasswordRequestBody) async {
    try {
      final response =
          await _apiService.resetPassword(resetPasswordRequestBody);
      return ApiResult.success(response);
    } catch (errro) {
      return ApiResult.failure(ErrorHandler.handle(errro));
    }
  }
}
