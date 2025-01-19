import 'package:morostick/core/networking/api_error_handler.dart';
import 'package:morostick/core/networking/api_result.dart';
import 'package:morostick/core/networking/api_service.dart';
import 'package:morostick/features/search/data/models/search_response.dart';
import 'package:morostick/features/search/data/models/trending_searches_response.dart';

class SearchRepo {
  final ApiService _apiService;

  SearchRepo(this._apiService);

  Future<ApiResult<TrendingSearchesResponse>> getTrendingSearches() async {
    try {
      final response = await _apiService.getTrendingSearches();
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }

  Future<ApiResult<SearchResponse>> getSearchResults(
    String query, {
    int page = 1,
    int limit = 10,
  }) async {
    try {
      final response = await _apiService.getSearchResults(
        query,
        page,
        limit,
      );
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }
}
