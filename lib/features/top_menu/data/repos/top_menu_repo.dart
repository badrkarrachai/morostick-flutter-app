import 'package:morostick/core/networking/api_error_handler.dart';
import 'package:morostick/core/networking/api_result.dart';
import 'package:morostick/core/networking/api_service.dart';
import 'package:morostick/features/top_menu/data/models/update_user_pref_request_body.dart';
import 'package:morostick/features/top_menu/data/models/update_user_pref_response.dart';

class TopMenuRepo {
  final ApiService _apiService;

  TopMenuRepo(this._apiService);

  Future<ApiResult<UpdateUserPrefResponse>> updateUserPreferences(
    bool isGoogleAuthEnabled,
    bool isFacebookAuthEnabled,
  ) async {
    try {
      final response = await _apiService.updateUserPreferences(
        UpdateUserPrefRequestBody(
          isGoogleAuthEnabled: isGoogleAuthEnabled,
          isFacebookAuthEnabled: isFacebookAuthEnabled,
        ),
      );
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }
}
