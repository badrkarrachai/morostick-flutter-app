import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:morostick/core/di/dependency_injection.dart';
import 'package:morostick/core/routing/routes.dart';
import 'package:morostick/core/services/auth_navigation_service.dart';
import 'package:morostick/core/widgets/app_message_box.dart';
import 'package:morostick/features/auth/forget_password/new_password/logic/new_password_cubit.dart';
import 'package:morostick/features/auth/forget_password/new_password/ui/new_password_screen.dart';
import 'package:morostick/features/auth/forget_password/send_code/ui/send_code_screen.dart';
import 'package:morostick/features/auth/web_view/logic/web_view_cubit.dart';
import 'package:morostick/features/auth/web_view/ui/web_view_screen.dart';
import 'package:morostick/features/auth/forget_password/send_code/logic/send_code_cubit.dart';
import 'package:morostick/features/auth/forget_password/verify_code/logic/verify_code_cubit.dart';
import 'package:morostick/features/auth/forget_password/verify_code/ui/verify_code_screen.dart';
import 'package:morostick/features/auth/login/logic/login_cubit.dart';
import 'package:morostick/features/auth/login/ui/login_screen.dart';
import 'package:morostick/features/auth/sign_up/logic/sign_up_cubit.dart';
import 'package:morostick/features/auth/sign_up/ui/sign_up_screen.dart';
import 'package:morostick/features/main_navigation/logic/main_navigation_cubit.dart';
import 'package:morostick/features/main_navigation/ui/main_navigation.dart';
import 'package:morostick/features/onboarding/onboarding_screen.dart';
import 'package:morostick/features/top_menu/ui/top_menu_screen.dart';

// Route Types
enum RouteType { public, auth, protected }

// Route Config
class RouteConfig {
  final String path;
  final RouteType type;
  final Widget Function(dynamic) builder;

  const RouteConfig({
    required this.path,
    required this.type,
    required this.builder,
  });
}

// App Router
class AppRouter {
  final AuthNavigationService _authService;

  AppRouter() : _authService = getIt<AuthNavigationService>();

  static final Map<String, RouteConfig> _routes = {
    '/': RouteConfig(
      path: '/',
      type: RouteType.public,
      builder: (args) => const OnboardingScreen(),
    ),

    // Public Routes
    Routes.onBoardingScreen: RouteConfig(
      path: Routes.onBoardingScreen,
      type: RouteType.public,
      builder: (args) => const OnboardingScreen(),
    ),
    Routes.webviewScreen: RouteConfig(
      path: Routes.webviewScreen,
      type: RouteType.public,
      builder: (args) => BlocProvider(
        create: (context) {
          final cubit = getIt<WebViewCubit>();
          if (args is Map<String, dynamic>) {
            cubit.updateUrl(args['url'] as String);
            cubit.updateTitle(args['title'] as String);
          }
          return cubit;
        },
        child: const WebviewScreen(),
      ),
    ),
    Routes.homeScreen: RouteConfig(
      path: Routes.homeScreen,
      type: RouteType.public,
      builder: (args) => BlocProvider(
        create: (context) => MainNavigationCubit(),
        child: const MainNavigation(),
      ),
    ),
    Routes.topMenuScreen: RouteConfig(
      path: Routes.topMenuScreen,
      type: RouteType.public,
      builder: (args) => const TopMenuScreen(),
    ),

    // Auth Routes
    Routes.loginScreen: RouteConfig(
      path: Routes.loginScreen,
      type: RouteType.auth,
      builder: (args) => BlocProvider(
        create: (context) => getIt<LoginCubit>(),
        child: const LoginScreen(),
      ),
    ),
    Routes.signUpScreen: RouteConfig(
      path: Routes.signUpScreen,
      type: RouteType.auth,
      builder: (args) => BlocProvider(
        create: (context) => getIt<SignupCubit>(),
        child: const SignupScreen(),
      ),
    ),
    Routes.forgetPasswordScreen: RouteConfig(
      path: Routes.forgetPasswordScreen,
      type: RouteType.auth,
      builder: (args) => BlocProvider(
        create: (context) => getIt<SendCodeCubit>(),
        child: const SendCodeScreen(),
      ),
    ),
    Routes.verifyCodeScreen: RouteConfig(
      path: Routes.verifyCodeScreen,
      type: RouteType.auth,
      builder: (args) => MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) {
              final cubit = getIt<SendCodeCubit>();
              if (args is String) {
                cubit.emailController.text = args;
              }
              return cubit;
            },
          ),
          BlocProvider(
            create: (context) {
              final cubit = getIt<VerifyCodeCubit>();
              if (args is String) {
                cubit.email = args;
              }
              return cubit;
            },
          ),
        ],
        child: const VerifyCodeScreen(),
      ),
    ),
    Routes.newPasswordScreen: RouteConfig(
      path: Routes.newPasswordScreen,
      type: RouteType.auth,
      builder: (args) => BlocProvider(
        create: (context) {
          final cubit = getIt<NewPasswordCubit>();
          if (args is Map<String, dynamic>) {
            cubit.email = args['email'] as String;
            cubit.code = args['code'] as String;
          }
          return cubit;
        },
        child: const NewPasswordScreen(),
      ),
    ),

    // Protected Routes
    //here....
  };

  Route<dynamic>? generateRoute(RouteSettings settings) {
    final routeConfig = _routes[settings.name];
    if (routeConfig == null) {
      return _buildErrorRoute(settings.name);
    }

    return MaterialPageRoute(
      builder: (_) => _handleRouteBasedOnType(
        routeConfig,
        settings.arguments,
      ),
    );
  }

  Widget _handleRouteBasedOnType(RouteConfig config, dynamic arguments) {
    final isAuthenticated = _authService.isAuthenticated;
    final isFirstTime = _authService.isFirstTime;
    final isGuestMode = _authService.isGuestMode;

    // Special handling for root route
    if (config.path == '/') {
      if (isFirstTime) {
        return const OnboardingScreen();
      } else if (isAuthenticated || isGuestMode) {
        return BlocProvider(
          create: (context) => MainNavigationCubit(),
          child: const MainNavigation(),
        );
      } else {
        return BlocProvider(
          create: (context) => getIt<LoginCubit>(),
          child: const LoginScreen(),
        );
      }
    }

    switch (config.type) {
      case RouteType.public:
        return config.builder(arguments);

      case RouteType.auth:
        if (isAuthenticated || isGuestMode) {
          return BlocProvider(
            create: (context) => MainNavigationCubit(),
            child: const MainNavigation(),
          );
        }
        return config.builder(arguments);

      case RouteType.protected:
        if (!isAuthenticated && !isGuestMode) {
          return BlocProvider(
            create: (context) => getIt<LoginCubit>(),
            child: const LoginScreen(),
          );
        }
        if (!isAuthenticated && isGuestMode) {
          return _buildGuestRestrictedWidget(config.builder(arguments));
        }
        return config.builder(arguments);
    }
  }

  Route<dynamic> _buildErrorRoute(String? routeName) {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        body: Center(
          child: Text('No route defined for $routeName'),
        ),
      ),
    );
  }

  static void dispose() {
    _routes.clear();
  }

  Widget _buildGuestRestrictedWidget(Widget restrictedWidget) {
    return Builder(
      builder: (context) {
        // Show the dialog when the widget is built
        WidgetsBinding.instance.addPostFrameCallback((_) {
          AppMessageBoxDialogManager.showConfirmDialog(
            context: context,
            title: 'Login Required',
            message: 'Sorry, Please login to access this feature',
            confirmText: 'Login',
            cancelText: 'Go Back',
            onConfirm: () {
              Navigator.of(context).pushReplacementNamed(
                Routes.loginScreen,
              );
            },
          );
        });

        // Return the navigation destination (like home screen) as fallback
        return BlocProvider(
          create: (context) => MainNavigationCubit(),
          child: const MainNavigation(),
        );
      },
    );
  }
}
