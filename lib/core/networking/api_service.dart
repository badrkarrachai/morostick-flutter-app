import 'dart:io';

import 'package:dio/dio.dart';
import 'package:morostick/core/networking/api_constants.dart';
import 'package:morostick/features/auth/forget_password/new_password/data/models/new_password_request_body.dart';
import 'package:morostick/features/auth/forget_password/new_password/data/models/new_password_response.dart';
import 'package:morostick/features/auth/forget_password/send_code/data/models/send_code_request_body.dart';
import 'package:morostick/features/auth/forget_password/send_code/data/models/send_code_response.dart';
import 'package:morostick/features/auth/forget_password/verify_code/data/models/verify_code_request_body.dart';
import 'package:morostick/features/auth/forget_password/verify_code/data/models/verify_code_response.dart';
import 'package:morostick/features/auth/login/data/models/login_request_body.dart';
import 'package:morostick/features/auth/login/data/models/login_response.dart';
import 'package:morostick/features/auth/login/data/models/login_with_facebook_model.dart';
import 'package:morostick/features/auth/login/data/models/login_with_google_model.dart';
import 'package:morostick/features/auth/sign_up/data/models/sign_up_request_body.dart';
import 'package:morostick/features/auth/sign_up/data/models/sign_up_response.dart';
import 'package:morostick/features/auth/sign_up/data/models/sign_up_with_facebook_model.dart';
import 'package:morostick/features/auth/sign_up/data/models/sign_up_with_google_model.dart';
import 'package:morostick/features/favorites/data/models/favorite_packs_response.dart';
import 'package:morostick/features/favorites/data/models/favorite_stickers_response.dart';
import 'package:morostick/features/home/data/models/category_tabs_requestbody.dart';
import 'package:morostick/features/home/data/models/category_tabs_response.dart';
import 'package:morostick/features/home/data/models/foryou_tab_response.dart';
import 'package:morostick/features/home/data/models/pack_list_tabs_response.dart';
import 'package:morostick/features/home/data/models/trending_tab_response.dart';
import 'package:morostick/features/pack/data/models/hide_pack_response.dart';
import 'package:morostick/features/pack/data/models/pack_by_id_response.dart';
import 'package:morostick/features/pack/data/models/report_pack_request_body.dart';
import 'package:morostick/features/pack/data/models/report_pack_response.dart';
import 'package:morostick/features/pack/data/models/toggle_pack_favorite_response.dart';
import 'package:morostick/features/pack/data/models/toggle_sticker_favorite_response.dart';
import 'package:morostick/features/profile/data/models/update_avatar_response.dart';
import 'package:morostick/features/profile/data/models/update_coverimage_response.dart';
import 'package:morostick/features/profile/data/models/update_name_request_body.dart';
import 'package:morostick/features/profile/data/models/update_name_response.dart';
import 'package:morostick/features/search/data/models/search_response.dart';
import 'package:morostick/features/search/data/models/trending_searches_response.dart';
import 'package:morostick/features/top_menu/data/models/update_user_pref_request_body.dart';
import 'package:morostick/features/top_menu/data/models/update_user_pref_response.dart';
import 'package:retrofit/retrofit.dart';

part 'api_service.g.dart';

@RestApi()
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  // Auth routes
  @POST(ApiConstants.login)
  Future<LoginResponse> login(
    @Body() LoginRequestBody loginRequestBody,
  );

  @POST(ApiConstants.signup)
  Future<SignUpResponse> signup(
    @Body() SignupRequestBody signupRequestBody,
  );

  @POST(ApiConstants.useAuthGoogle)
  Future<LoginResponse> loginWithGoogle(
    @Body() GoogleSignInRequestBody googleSignInRequestBody,
  );

  @POST(ApiConstants.useAuthFacebook)
  Future<LoginResponse> loginWithFacebbok(
    @Body() FacebookSignInRequestBody facebookSignInRequestBody,
  );

  @POST(ApiConstants.useAuthGoogle)
  Future<SignUpResponse> signupWithGoogle(
    @Body() GoogleSignUpRequestBody googleSignUpRequestBody,
  );

  @POST(ApiConstants.useAuthFacebook)
  Future<SignUpResponse> signupWithFacebook(
    @Body() FacebookSignUpRequestBody facebookSignUpRequestBody,
  );

  @POST(ApiConstants.forgetPasswordSendCode)
  Future<SendCodeResponse> sendCode(
    @Body() SendCodeRequestBody forgetPasswordSendCodeRequestBody,
  );

  @POST(ApiConstants.verifyOtp)
  Future<VerifyCodeResponse> verifyCode(
    @Body() VerifyCodeRequestBody verifyOtpRequestBody,
  );

  @POST(ApiConstants.resetPassword)
  Future<NewPasswordResponse> resetPassword(
    @Body() NewPasswordRequestBody resetPasswordRequestBody,
  );

  // Home routes
  @GET(ApiConstants.getCategories)
  Future<CategoryResponse> getCategories();

  @GET(ApiConstants.getForYouTab)
  Future<ForYouResponse> getMoreSuggested(
    @Query('page') int page,
    @Query('limit') int limit,
  );

  @GET(ApiConstants.getTrendingTab)
  Future<TrendingResponse> getTrendingTab(
    @Query('page') int page,
    @Query('limit') int limit,
  );

  @POST(ApiConstants.getPacksListTab)
  Future<PacksListResponse> getTabByCategoryName(
    @Body() CategoryTabsRequestBody categoryRequestBody,
    @Query('sortBy') String sortBy,
    @Query('page') int page,
    @Query('limit') int limit,
  );

  // Packs routes
  @GET(ApiConstants.getPackById)
  Future<PackByIdResponse> getPackById(
    @Query('id') String id,
  );

  @POST(ApiConstants.togglePackFavorite)
  Future<TogglePackFavoriteResponse> togglePackFavorite(
    @Query('packId') String packId,
  );

  @POST(ApiConstants.hidePack)
  Future<HidePackResponse> hidePack(
    @Query('packId') String packId,
  );

  @POST(ApiConstants.reportPack)
  Future<ReportPackResponse> reportPack(
    @Query('packId') String packId,
    @Body() ReportPackRequestBody reportPackRequestBody,
  );

  // Sticker routes
  @POST(ApiConstants.toggleStickerFavorite)
  Future<ToggleStickerFavoriteResponse> toggleStickerFavorite(
    @Query('stickerId') String stickerId,
  );

  // Search routes
  @GET(ApiConstants.getTrendingSearches)
  Future<TrendingSearchesResponse> getTrendingSearches();

  @GET(ApiConstants.getSearchResults)
  Future<SearchResponse> getSearchResults(
    @Query('query') String query,
    @Query('page') int page,
    @Query('limit') int limit,
    @Query('creatorName') String? creatorName,
    @Query('packType') String? packType,
    @Query('minStickers') int? minStickers,
    @Query('maxStickers') int? maxStickers,
    @Query('sortBy') String? sortBy,
  );

  // Favorites routes
  @GET(ApiConstants.getFavoritePacks)
  Future<FavoritePacksResponse> getFavoritePacks(
    @Query('page') int page,
    @Query('limit') int limit,
    @Query('type') String? type,
  );

  @GET(ApiConstants.getFavoriteStickers)
  Future<FavoriteStickersResponse> getFavoriteStickers(
    @Query('page') int page,
    @Query('limit') int limit,
    @Query('type') String? type,
  );

  // Top menu routes
  @PATCH(ApiConstants.updateUserPreferences)
  Future<UpdateUserPrefResponse> updateUserPreferences(
    @Body() UpdateUserPrefRequestBody updateUserPrefRequestBody,
  );

  // Profile routes
  @POST(ApiConstants.updateUserName)
  Future<UpdateNameResponse> updateUserName(
    @Body() UpdateNameRequestBody updateUserPrefRequestBody,
  );

  @MultiPart()
  @PUT(ApiConstants.updateUserAvatar)
  Future<UpdateAvatarResponse> updateUserAvatar(
    @Part(name: "avatarImage") File avatarImage,
  );

  @MultiPart()
  @PUT(ApiConstants.updateUserCoverImage)
  Future<UpdateCoverimageResponse> updateUserCoverImage(
    @Part() File coverImage,
  );
}
