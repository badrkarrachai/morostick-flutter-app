import 'package:morostick/core/networking/api_error_handler.dart';
import 'package:morostick/core/networking/api_result.dart';
import 'package:morostick/core/networking/api_service.dart';
import 'package:morostick/features/home/data/models/for_you_tab_response.dart';

class HomeRepo {
  final ApiService _apiService;

  HomeRepo(this._apiService);

  Future<ApiResult<ForYouResponse>> getForYouTab(int page,
      {int limit = 10}) async {
    try {
      final response = await _apiService.getMoreSuggested(page, limit);
      return ApiResult.success(response);
    } catch (errro) {
      return ApiResult.failure(ErrorHandler.handle(errro));
    }
  }
}
