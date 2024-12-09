import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:morostick/core/routing/app_routes.dart';
import 'package:morostick/core/services/auth_navigation_service.dart';
import 'package:morostick/core/theming/colors.dart';
import 'package:morostick/core/widgets/app_offline_banner.dart';
import 'package:provider/provider.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MoroStickApp extends StatelessWidget {
  final AuthNavigationService authService;
  late final AppRouter _appRouter;

  // Cache theme data
  static final _theme = ThemeData(
    primaryColor: ColorsManager.mainPurple,
    highlightColor: ColorsManager.mainPurple.withOpacity(0.2),
    secondaryHeaderColor: ColorsManager.secondaryLightPurple,
    scaffoldBackgroundColor: ColorsManager.backgroundLightColor,
    platform: TargetPlatform.android,
    // Optimize render performance
    useMaterial3: true,
    visualDensity: VisualDensity.standard,
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: {
        TargetPlatform.android: CupertinoPageTransitionsBuilder(),
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      },
    ),
  );

  MoroStickApp({
    super.key,
    required this.authService,
  }) {
    _appRouter = AppRouter();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AuthNavigationService>.value(
      value: authService,
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        child: RepaintBoundary(
          child: MaterialApp(
            navigatorKey: navigatorKey,
            title: 'MoroStick App',
            theme: _theme,
            debugShowCheckedModeBanner: false,
            initialRoute: '/',
            onGenerateRoute: _appRouter.generateRoute,
            builder: (context, child) {
              if (child == null) return const SizedBox.shrink();

              return MediaQuery(
                data: MediaQuery.of(context).copyWith(
                  textScaler: const TextScaler.linear(1.0),
                ),
                child: Scaffold(
                  body: Stack(
                    children: [
                      child,
                      SafeArea(
                        child: OfflineStateHandler(authService: authService),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
