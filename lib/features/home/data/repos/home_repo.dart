import 'package:morostick/core/networking/api_error_handler.dart';
import 'package:morostick/core/networking/api_result.dart';
import 'package:morostick/core/networking/api_service.dart';
import 'package:morostick/features/home/data/models/category_tabs_requestbody.dart';
import 'package:morostick/features/home/data/models/category_tabs_response.dart';
import 'package:morostick/features/home/data/models/foryou_tab_response.dart';
import 'package:morostick/features/home/data/models/pack_list_tabs_response.dart';
import 'package:morostick/features/home/data/models/trending_tab_response.dart';

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

  Future<ApiResult<TrendingResponse>> getTrendingTab(int page,
      {int limit = 10}) async {
    try {
      final response = await _apiService.getTrendingTab(page, limit);
      return ApiResult.success(response);
    } catch (errro) {
      return ApiResult.failure(ErrorHandler.handle(errro));
    }
  }

  Future<ApiResult<CategoryResponse>> getCategories() async {
    try {
      final response = await _apiService.getCategories();
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }

  Future<ApiResult<PacksListResponse>> getTabByCategoryName(
      CategoryTabsRequestBody categoryTabsRequestBody, int page,
      {int limit = 10, String sortBy = "downloads"}) async {
    try {
      final response = await _apiService.getTabByCategoryName(
          categoryTabsRequestBody, sortBy, page, limit);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }
}
