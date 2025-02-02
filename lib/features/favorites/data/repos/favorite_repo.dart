import 'package:morostick/core/networking/api_error_handler.dart';
import 'package:morostick/core/networking/api_result.dart';
import 'package:morostick/core/networking/api_service.dart';
import 'package:morostick/features/favorites/data/models/favorite_packs_response.dart';
import 'package:morostick/features/favorites/data/models/favorite_stickers_response.dart';
import 'package:morostick/features/pack/data/models/toggle_sticker_favorite_response.dart';

class FavoriteRepo {
  final ApiService _apiService;

  FavoriteRepo(this._apiService);

  Future<ApiResult<FavoritePacksResponse>> getFavoritePacks(
    int page, {
    int limit = 10,
    String? type,
  }) async {
    try {
      final response = await _apiService.getFavoritePacks(
        page,
        limit,
        type,
      );
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }

  Future<ApiResult<FavoriteStickersResponse>> getFavoriteStickers(
    int page, {
    int limit = 10,
    String? type,
  }) async {
    try {
      final response = await _apiService.getFavoriteStickers(
        page,
        limit,
        type,
      );
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }

  Future<ApiResult<ToggleStickerFavoriteResponse>> toggleStickerFavorite(
    String stickerId,
  ) async {
    try {
      final response = await _apiService.toggleStickerFavorite(stickerId);
      return ApiResult.success(response);
    } catch (errro) {
      return ApiResult.failure(ErrorHandler.handle(errro));
    }
  }
}
