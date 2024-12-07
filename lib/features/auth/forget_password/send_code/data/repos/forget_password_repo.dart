import 'package:morostick/core/networking/api_error_handler.dart';
import 'package:morostick/core/networking/api_result.dart';
import 'package:morostick/core/networking/api_service.dart';
import 'package:morostick/features/auth/forget_password/send_code/data/models/send_code_request_body.dart';
import 'package:morostick/features/auth/forget_password/send_code/data/models/send_code_response.dart';

class SendCodeRepo {
  final ApiService _apiService;

  SendCodeRepo(this._apiService);

  Future<ApiResult<SendCodeResponse>> sendCode(
      SendCodeRequestBody sendCodeRequestBody) async {
    try {
      final response = await _apiService.sendCode(sendCodeRequestBody);
      return ApiResult.success(response);
    } catch (errro) {
      return ApiResult.failure(ErrorHandler.handle(errro));
    }
  }
}
