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
import 'package:retrofit/retrofit.dart';

part 'api_service.g.dart';

@RestApi()
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

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
}
