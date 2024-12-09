import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:morostick/core/di/dependency_injection.dart';
import 'package:morostick/core/routing/routes.dart';
import 'package:morostick/core/services/auth_navigation_service.dart';
import 'package:morostick/features/auth/web_view/logic/web_view_cubit.dart';
import 'package:morostick/features/auth/web_view/ui/web_view_screen.dart';
import 'package:morostick/features/auth/forget_password/send_code/logic/send_code_cubit.dart';
import 'package:morostick/features/auth/forget_password/verify_code/logic/verify_code_cubit.dart';
import 'package:morostick/features/auth/forget_password/verify_code/ui/verify_code_screen.dart';
import 'package:morostick/features/auth/login/logic/login_cubit.dart';
import 'package:morostick/features/auth/login/ui/login_screen.dart';
import 'package:morostick/features/auth/sign_up/logic/sign_up_cubit.dart';
import 'package:morostick/features/auth/sign_up/ui/sign_up_screen.dart';
import 'package:morostick/features/home/ui/home_screen.dart';
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

    // Protected Routes
    Routes.homeScreen: RouteConfig(
      path: Routes.homeScreen,
      type: RouteType.protected,
      builder: (args) =>
          const MainNavigation(), // Changed from HomeScreen to MainNavigation
    ),
    Routes.topMenuScreen: RouteConfig(
      path: Routes.topMenuScreen,
      type: RouteType.protected,
      builder: (args) => const TopMenuScreen(),
    ),
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

    // Special handling for root route
    if (config.path == '/') {
      if (isFirstTime) {
        return const OnboardingScreen();
      } else if (isAuthenticated) {
        return const MainNavigation();
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
        if (isAuthenticated) {
          return const HomeScreen();
        }
        return config.builder(arguments);

      case RouteType.protected:
        if (!isAuthenticated) {
          return BlocProvider(
            create: (context) => getIt<LoginCubit>(),
            child: const LoginScreen(),
          );
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
}
