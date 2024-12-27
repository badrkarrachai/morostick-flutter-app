import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:morostick/core/di/dependency_injection.dart';
import 'package:morostick/core/helpers/extensions.dart';
import 'package:morostick/core/services/auth_navigation_service.dart';
import 'package:morostick/morostick_app.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'core/helpers/constants.dart';
import 'core/helpers/shared_pref_helper.dart';

Future<void> main() async {
  // Ensure bindings are initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Optimize system UI overlay style
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );

  // Load everything in parallel
  await Future.wait([
    dotenv.load(fileName: ".env"),
    setupGetIt(),
    ScreenUtil.ensureScreenSize(),
  ]);

  // Initialize auth service
  final authService = getIt<AuthNavigationService>();
  await authService.checkInitialStatus();

  runApp(MoroStickApp(
    authService: authService,
  ));
}

checkIfLoggedInUser() async {
  String? userToken =
      await SharedPrefHelper.getSecuredString(SharedPrefKeys.userToken);
  if (!userToken.isNullOrEmpty()) {
    isLoggedInUser = true;
  } else {
    isLoggedInUser = false;
  }
}
