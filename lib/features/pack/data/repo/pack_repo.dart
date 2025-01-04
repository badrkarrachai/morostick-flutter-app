import 'package:morostick/core/networking/api_error_handler.dart';
import 'package:morostick/core/networking/api_result.dart';
import 'package:morostick/core/networking/api_service.dart';
import 'package:morostick/features/pack/data/models/hide_pack_response.dart';
import 'package:morostick/features/pack/data/models/pack_by_id_response.dart';
import 'package:morostick/features/pack/data/models/report_pack_request_body.dart';
import 'package:morostick/features/pack/data/models/report_pack_response.dart';
import 'package:morostick/features/pack/data/models/toggle_pack_favorite_response.dart';

class PackRepo {
  final ApiService _apiService;

  PackRepo(this._apiService);

  Future<ApiResult<PackByIdResponse>> getPackById(String id) async {
    try {
      final response = await _apiService.getPackById(id);
      return ApiResult.success(response);
    } catch (errro) {
      return ApiResult.failure(ErrorHandler.handle(errro));
    }
  }

  Future<ApiResult<TogglePackFavoriteResponse>> toggleFavorite(
    String packId,
  ) async {
    try {
      final response = await _apiService.toggleFavorite(packId);
      return ApiResult.success(response);
    } catch (errro) {
      return ApiResult.failure(ErrorHandler.handle(errro));
    }
  }

  Future<ApiResult<HidePackResponse>> hidePack(String packId) async {
    try {
      final response = await _apiService.hidePack(packId);
      return ApiResult.success(response);
    } catch (errro) {
      return ApiResult.failure(ErrorHandler.handle(errro));
    }
  }

  Future<ApiResult<ReportPackResponse>> reportPack(
      String packId, ReportPackRequestBody reportPackRequestBody) async {
    try {
      final response =
          await _apiService.reportPack(packId, reportPackRequestBody);
      return ApiResult.success(response);
    } catch (errro) {
      return ApiResult.failure(ErrorHandler.handle(errro));
    }
  }
}
