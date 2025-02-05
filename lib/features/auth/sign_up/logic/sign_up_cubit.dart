import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:morostick/core/data/models/general_response_model.dart';
import 'package:morostick/core/services/auth_navigation_service.dart';
import 'package:morostick/core/services/facebook_auth_service.dart';
import 'package:morostick/core/services/google_auth_service.dart';
import 'package:morostick/core/services/user_service.dart';
import 'package:morostick/features/auth/sign_up/data/models/sign_up_with_facebook_model.dart';
import 'package:morostick/features/auth/sign_up/data/models/sign_up_with_google_model.dart';
import 'package:morostick/features/auth/sign_up/data/repos/sign_up_repo.dart';
import 'package:morostick/features/auth/sign_up/logic/sign_up_state.dart';
import '../data/models/sign_up_request_body.dart';

// signup_cubit.dart
class SignupCubit extends Cubit<SignupState> {
  final SignupRepo _signupRepo;
  final AuthNavigationService _authService;
  final UserService _userService;

  SignupCubit(this._signupRepo, this._authService, this._userService)
      : super(const SignupState.initial());

  // Services
  final GoogleAuthService _googleAuthService = GoogleAuthService();
  final FacebookAuthService _facebookAuthService = FacebookAuthService();

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  Future<void> _handleSuccessfullSignup(dynamic signupResponse) async {
    try {
      // Save tokens
      await _authService.login(
        signupResponse.loginData?.accessToken ?? '',
        refreshToken: signupResponse.loginData?.refreshToken,
      );

      // Save user data if available
      if (signupResponse.loginData?.user != null) {
        await _userService.saveUser(signupResponse.loginData!.user);
      }

      emit(SignupState.signupSuccess(signupResponse));
    } catch (e) {
      debugPrint('Error handling successful signup: $e');
      // If saving user data fails, still consider login successful but log the error
      emit(SignupState.signupSuccess(signupResponse));
    }
  }

  void emitSignupStates() async {
    try {
      emit(const SignupState.signupLoading());
      final response = await _signupRepo.signup(
        SignupRequestBody(
          name: nameController.text,
          email: emailController.text,
          password: passwordController.text,
        ),
      );
      response.when(
        success: (signupResponse) async {
          _handleSuccessfullSignup(signupResponse);
        },
        failure: (error) {
          emit(SignupState.signupError(error: error.apiErrorModel));
        },
      );
    } catch (e) {
      emit(SignupState.signupError(
        error: GeneralResponse(
          success: false,
          status: 500,
          message: e.toString(),
        ),
      ));
    }
  }

  Future<void> signUpWithGoogle() async {
    try {
      emit(const SignupState.signupLoading());

      final String? accessToken = await _googleAuthService.getAccessToken();

      if (accessToken != null) {
        final response = await _signupRepo.signUpWithGoogle(
          GoogleSignUpRequestBody(accessToken: accessToken),
        );

        response.when(
          success: (signUpResponse) async {
            _handleSuccessfullSignup(signUpResponse);
          },
          failure: (error) {
            emit(SignupState.signupError(error: error.apiErrorModel));
          },
        );
      } else {
        emit(const SignupState.signupError(
          error: GeneralResponse(
            success: false,
            message: 'Failed to get Google access token',
            status: 400,
          ),
        ));
      }
    } on PlatformException catch (e) {
      emit(SignupState.signupError(
        error: GeneralResponse(
          success: false,
          message: 'Platform error during Google sign up: ${e.message}',
          status: 500,
        ),
      ));
    } catch (e) {
      emit(const SignupState.signupError(
        error: GeneralResponse(
          success: false,
          message: 'Failed to sign up with Google',
          status: 500,
        ),
      ));
    }
  }

  Future<void> signUpWithFacebook() async {
    try {
      emit(const SignupState.signupLoading());

      final String? accessToken = await _facebookAuthService.getIdToken();

      if (accessToken != null) {
        final response = await _signupRepo.signUpWithFacebook(
          FacebookSignUpRequestBody(
            accessToken: accessToken,
          ),
        );

        response.when(
          success: (signUpResponse) async {
            _handleSuccessfullSignup(signUpResponse);
          },
          failure: (error) {
            emit(SignupState.signupError(error: error.apiErrorModel));
          },
        );
      } else {
        emit(const SignupState.signupError(
          error: GeneralResponse(
            success: false,
            message: 'Failed to get Facebook access token',
            status: 400,
          ),
        ));
      }
    } on PlatformException catch (e) {
      emit(SignupState.signupError(
        error: GeneralResponse(
          success: false,
          message: 'Platform error during Facebook sign up: ${e.message}',
          status: 500,
        ),
      ));
    } catch (e) {
      emit(const SignupState.signupError(
        error: GeneralResponse(
          success: false,
          message: 'Failed to sign up with Facebook',
          status: 500,
        ),
      ));
    }
  }
}
