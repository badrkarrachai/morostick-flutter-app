import 'dart:io';
import 'package:morostick/core/networking/api_constants.dart';
import 'package:morostick/core/networking/api_error_handler.dart';
import 'package:morostick/core/networking/api_result.dart';
import 'package:morostick/core/networking/api_service.dart';
import 'package:morostick/features/profile/data/models/update_avatar_response.dart';
import 'package:morostick/features/profile/data/models/update_coverimage_response.dart';
import 'package:morostick/features/profile/data/models/update_name_request_body.dart';
import 'package:morostick/features/profile/data/models/update_name_response.dart';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';

class ProfileRepo {
  final ApiService _apiService;
  final Dio _dio; // Add Dio instance if not already injected

  ProfileRepo(this._apiService, this._dio);

  Future<ApiResult<UpdateNameResponse>> updateUserName(
    String name,
    String email,
  ) async {
    try {
      final response = await _apiService.updateUserName(
        UpdateNameRequestBody(
          name: name,
          email: email,
        ),
      );
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }

  Future<ApiResult<UpdateAvatarResponse>> updateUserAvatar(
    File avatarImage,
  ) async {
    try {
      // Get file extension
      String fileName = avatarImage.path.split('/').last;
      String extension = fileName.split('.').last.toLowerCase();

      // Create MultipartFile manually with correct mime type
      final formData = FormData.fromMap({
        'avatarImage': await MultipartFile.fromFile(
          avatarImage.path,
          filename: fileName,
          contentType: MediaType('image', extension),
        ),
      });

      // Make a direct request instead of using the generated API service
      final response = await _dio.put(
        '${_dio.options.baseUrl}${ApiConstants.updateUserAvatar}',
        data: formData,
        options: Options(
          headers: {
            'Authorization': _dio.options.headers['Authorization'],
            'Content-Type': 'multipart/form-data',
          },
        ),
      );

      return ApiResult.success(UpdateAvatarResponse.fromJson(response.data));
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }

  Future<ApiResult<UpdateCoverimageResponse>> updateUserCoverImage(
    File avatarImage,
  ) async {
    try {
      // Get file extension
      String fileName = avatarImage.path.split('/').last;
      String extension = fileName.split('.').last.toLowerCase();

      // Create MultipartFile manually with correct mime type
      final formData = FormData.fromMap({
        'coverImage': await MultipartFile.fromFile(
          avatarImage.path,
          filename: fileName,
          contentType: MediaType('image', extension),
        ),
      });

      // Make a direct request instead of using the generated API service
      final response = await _dio.put(
        '${_dio.options.baseUrl}${ApiConstants.updateUserCoverImage}',
        data: formData,
        options: Options(
          headers: {
            'Authorization': _dio.options.headers['Authorization'],
            'Content-Type': 'multipart/form-data',
          },
        ),
      );

      return ApiResult.success(
          UpdateCoverimageResponse.fromJson(response.data));
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }

  Future<ApiResult<void>> deleteUserAvatar() async {
    try {
      final response = await _apiService.deleteUserAvatar();
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }

  Future<ApiResult<void>> deleteUserCoverImage() async {
    try {
      final response = await _apiService.deleteUserCoverImage();
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }
}
