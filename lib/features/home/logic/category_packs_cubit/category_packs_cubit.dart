import 'package:morostick/features/home/data/repos/home_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:morostick/features/home/data/models/category_tabs_requestbody.dart';
import 'package:morostick/features/home/logic/category_packs_cubit/category_packs_state.dart';

class CategoryPacksCubit extends Cubit<CategoryPacksState> {
  final HomeRepo _homeRepo;
  HomeRepo get homeRepo => _homeRepo;
  CategoryPacksCubit(this._homeRepo) : super(const CategoryPacksState());

  Future<void> getPacksByCategory(String categoryKey) async {
    emit(state.copyWith(isLoading: true, hasError: false));

    try {
      final response = await _homeRepo.getTabByCategoryName(
        CategoryTabsRequestBody(categoryKey: categoryKey),
        1,
        limit: 10,
      );

      response.when(
        success: (packsResponse) {
          final packs = packsResponse.packs ?? [];
          final pagination = packsResponse.pagination;

          emit(state.copyWith(
            isLoading: false,
            packs: packs,
            hasError: false,
            errorMessage: null,
            hasReachedMax: pagination?.hasNextPage == false,
            currentPage: pagination?.currentPage ?? 1,
          ));
        },
        failure: (error) {
          emit(state.copyWith(
            isLoading: false,
            hasError: true,
            errorMessage: error.apiErrorModel.message,
            errorDetails: error.apiErrorModel.error?.details,
            packs: [], // Clear packs on error
          ));
        },
      );
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        hasError: true,
        errorMessage: e.toString(),
        packs: [], // Clear packs on error
      ));
    }
  }

  Future<void> loadMore(String categoryKey) async {
    if (state.isLoadingMore || state.hasReachedMax) return;

    emit(state.copyWith(isLoadingMore: true));

    try {
      final nextPage = state.currentPage + 1;
      final response = await _homeRepo.getTabByCategoryName(
        CategoryTabsRequestBody(categoryKey: categoryKey),
        nextPage,
        limit: 10,
      );

      response.when(
        success: (packsResponse) {
          final newPacks = packsResponse.packs ?? [];
          final pagination = packsResponse.pagination;

          if (newPacks.isEmpty) {
            emit(state.copyWith(
              isLoadingMore: false,
              hasReachedMax: true,
            ));
            return;
          }

          emit(state.copyWith(
            isLoadingMore: false,
            packs: [...state.packs, ...newPacks],
            currentPage: nextPage,
            hasReachedMax: pagination?.hasNextPage == false,
          ));
        },
        failure: (error) {
          emit(state.copyWith(
            isLoadingMore: false,
            hasError: true,
            errorMessage: error.apiErrorModel.message,
            errorDetails: error.apiErrorModel.error?.details,
          ));
        },
      );
    } catch (e) {
      emit(state.copyWith(
        isLoadingMore: false,
        hasError: true,
        errorMessage: e.toString(),
      ));
    }
  }

  void refresh(String categoryKey) {
    emit(const CategoryPacksState());
    getPacksByCategory(categoryKey);
  }
}
