import 'package:morostick/core/networking/api_error_handler.dart';
import 'package:morostick/core/networking/api_result.dart';
import 'package:morostick/core/networking/api_service.dart';
import 'package:morostick/features/auth/forget_password/verify_code/data/models/verify_code_response.dart';

class VerifyCodeRepo {
  final ApiService _apiService;

  VerifyCodeRepo(this._apiService);

  Future<ApiResult<VerifyCodeResponse>> verifyCode(
      verifyCodeRequestBody) async {
    try {
      final response = await _apiService.verifyCode(verifyCodeRequestBody);
      return ApiResult.success(response);
    } catch (errro) {
      return ApiResult.failure(ErrorHandler.handle(errro));
    }
  }
}
