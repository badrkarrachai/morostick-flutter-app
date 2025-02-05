import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:morostick/core/di/dependency_injection.dart';
import 'package:morostick/core/helpers/extensions.dart';
import 'package:morostick/core/services/auth_navigation_service.dart';
import 'package:morostick/core/services/user_service.dart';
import 'package:morostick/morostick_app.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'core/helpers/constants.dart';
import 'core/helpers/shared_pref_helper.dart';

Future<void> main() async {
  try {
    // Ensure bindings are initialized
    WidgetsFlutterBinding.ensureInitialized();

    // First, load the environment variables
    await dotenv.load(fileName: ".env");

    // Initialize dependencies that need env variables
    await setupGetIt();

    // Initialize screen util
    await ScreenUtil.ensureScreenSize();

    // Load user before running the app
    final userService = getIt<UserService>();
    await userService.loadUser();

    // Initialize auth service
    final authService = getIt<AuthNavigationService>();
    await authService.checkInitialStatus();

    // Initialize guest dialog service
    GuestDialogService.init(AppKeys.navigatorKey);

    // Set orientation and run the app
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      // DeviceOrientation.portraitDown, // Include this if you want upside down portrait
    ]);

    runApp(MoroStickApp(
      authService: authService,
    ));
  } catch (e, stackTrace) {
    debugPrint('Initialization error: $e');
    debugPrint('Stack trace: $stackTrace');
    rethrow;
  }
}

Future<bool> checkIfLoggedInUser() async {
  try {
    String userToken =
        await SharedPrefHelper.getSecuredString(SharedPrefKeys.userToken);
    return !userToken.isNullOrEmpty();
  } catch (e) {
    debugPrint('Error checking login status: $e');
    return false;
  }
}
