import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:morostick/core/data/models/general_response_model.dart';
import 'package:morostick/core/services/auth_navigation_service.dart';
import 'package:morostick/core/services/user_service.dart';
import 'package:morostick/core/widgets/app_offline_messagebox.dart';
import 'package:morostick/features/auth/login/data/models/login_request_body.dart';
import 'package:morostick/features/auth/login/data/models/login_with_facebook_model.dart';
import 'package:morostick/features/auth/login/data/models/login_with_google_model.dart';
import 'package:morostick/features/auth/login/data/repos/login_repo.dart';
import 'package:morostick/features/auth/login/logic/login_state.dart';
import 'package:morostick/core/services/facebook_auth_service.dart';
import 'package:morostick/core/services/google_auth_service.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginRepo _loginRepo;
  final AuthNavigationService _authService;
  final UserService _userService;

  LoginCubit(
    this._loginRepo,
    this._authService,
    this._userService,
  ) : super(const LoginState.initial());

  final GoogleAuthService _googleAuthService = GoogleAuthService();
  final FacebookAuthService _facebookAuthService = FacebookAuthService();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  void resetError() {
    emit(const LoginState.initial());
  }

  Future<void> _handleSuccessfulLogin(dynamic loginResponse) async {
    try {
      // Save tokens
      await _authService.login(
        loginResponse.loginData?.accessToken ?? '',
        refreshToken: loginResponse.loginData?.refreshToken,
      );

      // Save user data if available
      if (loginResponse.loginData?.user != null) {
        await _userService.saveUser(loginResponse.loginData!.user);
      }

      emit(LoginState.success(loginResponse));
    } catch (e) {
      debugPrint('Error handling successful login: $e');
      // If saving user data fails, still consider login successful but log the error
      emit(LoginState.success(loginResponse));
    }
  }

  void emitLoginStates() async {
    try {
      emit(const LoginState.loading());
      final response = await _loginRepo.login(
        LoginRequestBody(
          email: emailController.text,
          password: passwordController.text,
        ),
      );

      response.when(success: (loginResponse) async {
        await _handleSuccessfulLogin(loginResponse);
      }, failure: (error) {
        emit(LoginState.error(error: error.apiErrorModel));
      });
    } catch (e) {
      emit(LoginState.error(
        error: GeneralResponse(
          success: false,
          status: 500,
          message: e.toString(),
        ),
      ));
    }
  }

  Future<void> signInWithFacebook() async {
    try {
      emit(const LoginState.loading());

      final String? accessToken = await _facebookAuthService.getIdToken();

      if (accessToken != null) {
        final response = await _loginRepo.loginWithFacebook(
          FacebookSignInRequestBody(
            accessToken: accessToken,
          ),
        );

        response.when(
          success: (loginResponse) async {
            await _handleSuccessfulLogin(loginResponse);
          },
          failure: (error) {
            emit(LoginState.error(error: error.apiErrorModel));
          },
        );
      } else {
        emit(const LoginState.error(
          error: GeneralResponse(
            success: false,
            message: 'Failed to get Facebook access token',
            status: 400,
          ),
        ));
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.sendTimeout) {
        _authService.setIsOffline(true, reason: OfflineReason.serverTimeout);
      }
      emit(const LoginState.error(
        error: GeneralResponse(
          success: false,
          message: 'Failed to sign in with Facebook',
          status: 500,
        ),
      ));
    } catch (e) {
      emit(const LoginState.error(
        error: GeneralResponse(
          success: false,
          message: 'Failed to sign in with Facebook',
          status: 500,
        ),
      ));
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      emit(const LoginState.loading());

      final String? accessToken = await _googleAuthService.getAccessToken();

      if (accessToken != null) {
        final response = await _loginRepo.loginWithGoogle(
          GoogleSignInRequestBody(accessToken: accessToken),
        );

        response.when(
          success: (loginResponse) async {
            await _handleSuccessfulLogin(loginResponse);
          },
          failure: (error) {
            emit(LoginState.error(error: error.apiErrorModel));
          },
        );
      } else {
        emit(const LoginState.error(
          error: GeneralResponse(
            success: false,
            message: 'Failed to get Google access token',
            status: 400,
          ),
        ));
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.sendTimeout) {
        _authService.setIsOffline(true, reason: OfflineReason.serverTimeout);
      }
      emit(const LoginState.error(
        error: GeneralResponse(
          success: false,
          message: 'Failed to sign in with Google',
          status: 500,
        ),
      ));
    } catch (e) {
      emit(const LoginState.error(
        error: GeneralResponse(
          success: false,
          message: 'Failed to sign in with Google',
          status: 500,
        ),
      ));
    }
  }
}
