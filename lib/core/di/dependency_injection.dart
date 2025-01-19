import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:morostick/core/config/app_config.dart';
import 'package:morostick/core/networking/api_service.dart';
import 'package:morostick/core/networking/dio_factory.dart';
import 'package:morostick/core/services/auth_navigation_service.dart';
import 'package:morostick/core/services/facebook_auth_service.dart';
import 'package:morostick/core/services/google_auth_service.dart';
import 'package:morostick/features/auth/forget_password/new_password/data/repos/new_password_repo.dart';
import 'package:morostick/features/auth/forget_password/new_password/logic/new_password_cubit.dart';
import 'package:morostick/features/auth/forget_password/send_code/data/repos/forget_password_repo.dart';
import 'package:morostick/features/auth/forget_password/send_code/logic/send_code_cubit.dart';
import 'package:morostick/features/auth/forget_password/verify_code/data/repos/verify_code_repo.dart';
import 'package:morostick/features/auth/forget_password/verify_code/logic/verify_code_cubit.dart';
import 'package:morostick/features/auth/login/data/repos/login_repo.dart';
import 'package:morostick/features/auth/login/logic/login_cubit.dart';
import 'package:morostick/features/auth/sign_up/data/repos/sign_up_repo.dart';
import 'package:morostick/features/auth/sign_up/logic/sign_up_cubit.dart';
import 'package:morostick/features/auth/web_view/logic/web_view_cubit.dart';
import 'package:morostick/features/home/data/repos/home_repo.dart';
import 'package:morostick/features/home/logic/category_packs_cubit/category_packs_cubit.dart';
import 'package:morostick/features/home/logic/category_tabs_cubit/category_tabs_cubit.dart';
import 'package:morostick/features/home/logic/foryou_tab_cubit/foryou_tab_cubit.dart';
import 'package:morostick/features/home/logic/trending_tab_cubit/trending_tab_cubit.dart';
import 'package:morostick/features/pack/data/repo/pack_repo.dart';
import 'package:morostick/features/pack/logic/view_pack_details_cubit.dart';
import 'package:morostick/features/search/data/repos/search_repo.dart';
import 'package:morostick/features/search/logic/search_cubit.dart';

final getIt = GetIt.instance;

Future<void> setupGetIt() async {
  // Auth Services
  getIt.registerLazySingleton<GoogleAuthService>(
    () => GoogleAuthService(),
  );
  getIt.registerLazySingleton<FacebookAuthService>(
    () => FacebookAuthService(),
  );
  getIt.registerLazySingleton<AuthNavigationService>(
    () => AuthNavigationService(
      googleAuthService: getIt<GoogleAuthService>(),
      facebookAuthService: getIt<FacebookAuthService>(),
    ),
  );
  DioFactory.init(getIt<AuthNavigationService>());

  // Dio & ApiService
  Dio dio = DioFactory.getDio();
  getIt.registerLazySingleton<ApiService>(
    () => ApiService(dio, baseUrl: AppConfig.apiBaseUrl),
  );

  // login
  getIt.registerLazySingleton<LoginRepo>(() => LoginRepo(getIt()));
  getIt.registerFactory<LoginCubit>(() => LoginCubit(
        getIt<LoginRepo>(),
        getIt<AuthNavigationService>(),
      ));

  // signup
  getIt.registerLazySingleton<SignupRepo>(() => SignupRepo(getIt()));
  getIt.registerFactory<SignupCubit>(() => SignupCubit(
        getIt<SignupRepo>(),
        getIt<AuthNavigationService>(),
      ));

  // forget password
  getIt.registerLazySingleton<SendCodeRepo>(() => SendCodeRepo(getIt()));
  getIt.registerFactory<SendCodeCubit>(() => SendCodeCubit(getIt()));
  getIt.registerLazySingleton<VerifyCodeRepo>(() => VerifyCodeRepo(getIt()));
  getIt.registerFactory<VerifyCodeCubit>(() => VerifyCodeCubit(getIt()));

  // new password - Updated to include AuthNavigationService
  getIt.registerLazySingleton<NewPasswordRepo>(() => NewPasswordRepo(getIt()));
  getIt.registerFactory<NewPasswordCubit>(() => NewPasswordCubit(
        getIt<NewPasswordRepo>(),
        getIt<AuthNavigationService>(),
      ));

  // webview
  getIt.registerFactory<WebViewCubit>(() => WebViewCubit());

  // home
  getIt.registerLazySingleton<HomeRepo>(() => HomeRepo(getIt()));
  getIt.registerLazySingleton<CategoriesCubit>(() => CategoriesCubit(
        getIt<HomeRepo>(),
      ));
  getIt.registerLazySingleton<ForYouCubit>(() => ForYouCubit(
        getIt<HomeRepo>(),
        getIt<AuthNavigationService>(),
      ));
  getIt.registerLazySingleton<TrendingTabCubit>(() => TrendingTabCubit(
        getIt<HomeRepo>(),
        getIt<AuthNavigationService>(),
      ));
  getIt.registerLazySingleton<CategoryPacksCubit>(() => CategoryPacksCubit(
        getIt<HomeRepo>(),
      ));

  // Packs
  getIt.registerLazySingleton<PackRepo>(() => PackRepo(getIt()));
  getIt.registerFactory<ViewPackDetailsCubit>(() =>
      ViewPackDetailsCubit(getIt<PackRepo>(), getIt<AuthNavigationService>()));

  // Search
  getIt.registerLazySingleton<SearchRepo>(() => SearchRepo(getIt()));
  // Change this to lazySingleton
  getIt.registerLazySingleton<SearchCubit>(
      () => SearchCubit(getIt<SearchRepo>()));
}
