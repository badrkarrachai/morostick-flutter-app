import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:morostick/core/di/dependency_injection.dart';
import 'package:morostick/core/routing/routes.dart';
import 'package:morostick/core/services/auth_navigation_service.dart';
import 'package:morostick/features/auth/web_view/logic/web_view_cubit.dart';
import 'package:morostick/features/auth/web_view/ui/web_view_screen.dart';
import 'package:morostick/features/auth/forget_password/new_password/logic/new_password_cubit.dart';
import 'package:morostick/features/auth/forget_password/new_password/ui/new_password_screen.dart';
import 'package:morostick/features/auth/forget_password/send_code/logic/send_code_cubit.dart';
import 'package:morostick/features/auth/forget_password/send_code/ui/send_code_screen.dart';
import 'package:morostick/features/auth/forget_password/verify_code/logic/verify_code_cubit.dart';
import 'package:morostick/features/auth/forget_password/verify_code/ui/verify_code_screen.dart';
import 'package:morostick/features/auth/login/logic/login_cubit.dart';
import 'package:morostick/features/auth/login/ui/login_screen.dart';
import 'package:morostick/features/auth/sign_up/logic/sign_up_cubit.dart';
import 'package:morostick/features/auth/sign_up/ui/sign_up_screen.dart';
import 'package:morostick/features/home/ui/home_screen.dart';
import 'package:morostick/features/onboarding/onboarding_screen.dart';

class AppRouter {
  final AuthNavigationService _authService;

  AppRouter() : _authService = getIt<AuthNavigationService>();

  Route? generateRoute(RouteSettings settings) {
    final arguments = settings.arguments;
    final isAuthenticated = _authService.isAuthenticated;
    final isFirstTime = _authService.isFirstTime;

    // Special handling for initial route
    if (settings.name == '/') {
      if (isFirstTime) {
        return MaterialPageRoute(
          builder: (_) => const OnboardingScreen(),
        );
      } else if (isAuthenticated) {
        return MaterialPageRoute(
          builder: (_) => const HomeScreen(),
        );
      } else {
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<LoginCubit>(),
            child: const LoginScreen(),
          ),
        );
      }
    }

    switch (settings.name) {
      // Public Routes
      case Routes.onBoardingScreen:
        return MaterialPageRoute(
          builder: (_) => const OnboardingScreen(),
        );

      // Auth Routes
      case Routes.loginScreen:
        if (isAuthenticated) {
          return MaterialPageRoute(
            builder: (_) => const HomeScreen(),
          );
        }
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<LoginCubit>(),
            child: const LoginScreen(),
          ),
        );

      case Routes.signUpScreen:
        if (isAuthenticated) {
          return MaterialPageRoute(
            builder: (_) => const HomeScreen(),
          );
        }
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<SignupCubit>(),
            child: const SignupScreen(),
          ),
        );

      case Routes.forgetPasswordScreen:
        if (isAuthenticated) {
          return MaterialPageRoute(
            builder: (_) => const HomeScreen(),
          );
        }
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<SendCodeCubit>(),
            child: const SendCodeScreen(),
          ),
        );

      case Routes.verifyCodeScreen:
        if (isAuthenticated) {
          return MaterialPageRoute(
            builder: (_) => const HomeScreen(),
          );
        }
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) {
                  final cubit = getIt<SendCodeCubit>();
                  if (arguments is String) {
                    cubit.emailController.text = arguments;
                  }
                  return cubit;
                },
              ),
              BlocProvider(
                create: (context) {
                  final cubit = getIt<VerifyCodeCubit>();
                  if (arguments is String) {
                    cubit.email = arguments;
                  }
                  return cubit;
                },
              ),
            ],
            child: const VerifyCodeScreen(),
          ),
        );

      case Routes.newPasswordScreen:
        if (isAuthenticated) {
          return MaterialPageRoute(
            builder: (_) => const HomeScreen(),
          );
        }
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) {
              final cubit = getIt<NewPasswordCubit>();
              if (arguments is Map<String, dynamic>) {
                cubit.email = arguments['email'] as String? ?? '';
                cubit.code = arguments['code'] as String? ?? '';
              }
              return cubit;
            },
            child: const NewPasswordScreen(),
          ),
        );

      // Protected Routes
      case Routes.homeScreen:
        if (!isAuthenticated) {
          return MaterialPageRoute(
            builder: (_) => BlocProvider(
              create: (context) => getIt<LoginCubit>(),
              child: const LoginScreen(),
            ),
          );
        }
        return MaterialPageRoute(
          builder: (_) => const HomeScreen(),
        );

      case Routes.webviewScreen:
        if (!isAuthenticated) {
          return MaterialPageRoute(
            builder: (_) => BlocProvider(
              create: (context) => getIt<LoginCubit>(),
              child: const LoginScreen(),
            ),
          );
        }
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) {
              final cubit = getIt<WebViewCubit>();
              if (arguments is Map<String, dynamic>) {
                cubit.updateUrl(arguments['url'] as String);
                cubit.updateTitle(arguments['title'] as String);
              }
              return cubit;
            },
            child: const WebviewScreen(),
          ),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
