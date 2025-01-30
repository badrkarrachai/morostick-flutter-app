import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:morostick/core/data/models/pack_model.dart';
import 'package:morostick/features/home/data/models/category_tabs_requestbody.dart';
import 'package:morostick/features/home/data/repos/home_repo.dart';
import 'package:morostick/features/home/logic/category_tabs_cubit/category_tabs_state.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  final HomeRepo _homeRepo;

  static const staticCategories = [
    Category(
      id: 'for-you',
      name: 'For You',
      isStatic: true,
    ),
    Category(
      id: 'trending',
      name: 'Trending',
      isStatic: true,
    ),
  ];

  CategoriesCubit(this._homeRepo)
      : super(const CategoriesState(categories: staticCategories)) {
    loadCategories();
  }

  Future<void> loadCategories({bool shouldResetPacks = true}) async {
    emit(state.copyWith(
      isLoading: true,
      // Only reset packs if shouldResetPacks is true
      stickerPacks: shouldResetPacks ? [] : state.stickerPacks,
    ));

    try {
      final response = await _homeRepo.getCategories();

      response.when(
        success: (categoryResponse) {
          final serverCategories = categoryResponse.topCategoryTabs ?? [];

          emit(state.copyWith(
            isLoading: false,
            categories: [...staticCategories, ...serverCategories],
            hasError: false,
            errorMessage: null,
            // Preserve existing packs if shouldResetPacks is false
            stickerPacks: shouldResetPacks ? [] : state.stickerPacks,
          ));
        },
        failure: (error) {
          emit(state.copyWith(
            isLoading: false,
            hasError: true,
            errorMessage: error.apiErrorModel.message,
            categories: staticCategories,
            // Preserve existing packs if shouldResetPacks is false
            stickerPacks: shouldResetPacks ? [] : state.stickerPacks,
          ));
        },
      );
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        hasError: true,
        errorMessage: e.toString(),
        categories: staticCategories,
        // Preserve existing packs if shouldResetPacks is false
        stickerPacks: shouldResetPacks ? [] : state.stickerPacks,
      ));
    }
  }

  Future<void> getPacksByCategoryName(String categoryKey) async {
    // Load categories if they haven't been loaded yet, but don't reset packs
    if (state.categories.length <= staticCategories.length) {
      await loadCategories(shouldResetPacks: false);
    }

    emit(state.copyWith(isLoading: true));

    try {
      final response = await _homeRepo.getTabByCategoryName(
        CategoryTabsRequestBody(categoryKey: categoryKey),
        1,
        limit: 10,
      );

      response.when(
        success: (packsResponse) {
          final packs = packsResponse.packs ?? [];
          emit(state.copyWith(
            isLoading: false,
            stickerPacks: packs,
            hasError: false,
            errorMessage: null,
          ));
        },
        failure: (error) {
          emit(state.copyWith(
            isLoading: false,
            hasError: true,
            errorMessage: error.apiErrorModel.message,
            stickerPacks: [], // Clear packs on error
          ));
        },
      );
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        hasError: true,
        errorMessage: e.toString(),
        stickerPacks: [], // Clear packs on error
      ));
    }
  }

  // Optional: Add a method to refresh both categories and packs
  Future<void> refreshAll(String categoryKey) async {
    await loadCategories(shouldResetPacks: true);
    await getPacksByCategoryName(categoryKey);
  }
}
