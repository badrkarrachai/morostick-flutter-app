import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:morostick/core/data/models/general_response_model.dart';
import 'package:morostick/core/helpers/pack_events.dart';
import 'package:morostick/core/services/auth_navigation_service.dart';
import 'package:morostick/core/theming/colors.dart';
import 'package:morostick/core/widgets/app_offline_messagebox.dart';
import 'package:morostick/features/home/data/models/trending_tab_response.dart';
import 'package:morostick/features/home/data/repos/home_repo.dart';
import 'package:morostick/features/home/logic/trending_tab_cubit/trending_tab_state.dart';

class TrendingTabCubit extends Cubit<TrendingState> {
  final HomeRepo _homeRepo;
  final AuthNavigationService _authService;
  static const int _pageSize = 10;
  late StreamSubscription _packHiddenSubscription;

  TrendingTabCubit(this._homeRepo, this._authService)
      : super(const TrendingState()) {
    _packHiddenSubscription = PackEvents.onPackHidden.listen((packId) {
      removePackFromList(packId);
    });
  }

  @override
  Future<void> close() {
    _packHiddenSubscription.cancel();
    return super.close();
  }

  void removePackFromList(String packId) {
    if (state.data == null) return;
    refresh();
  }

  Future<void> getTrendingContent() async {
    if (state.isLoading) return;

    emit(state.copyWith(
      isLoading: true,
      hasError: false,
      error: null,
      currentPage: 1,
      hasReachedMax: false,
    ));

    try {
      final response = await _homeRepo.getTrendingTab(1, limit: _pageSize);

      response.when(
        success: (trendingResponse) {
          final hasReachedMax = trendingResponse
                  .trendingData?.trending?.pagination?.hasNextPage ==
              false;

          // Generate colors for recommended packs
          final colors = List.generate(
            trendingResponse.trendingData?.topCategories?.length ?? 0,
            (_) => ColorsManager.getRandomColor(),
          );

          emit(state.copyWith(
            isLoading: false,
            data: trendingResponse,
            hasReachedMax: hasReachedMax,
            categoriesColors: colors,
          ));
        },
        failure: (error) {
          emit(state.copyWith(
            isLoading: false,
            hasError: true,
            error: error.apiErrorModel,
          ));
        },
      );
    } on DioException catch (e) {
      _handleDioError(e);
    } catch (e) {
      _handleGenericError(e.toString());
    }
  }

  Future<void> loadMoreContent() async {
    if (state.isLoadingMore || state.isLoading || state.hasReachedMax) return;

    emit(state.copyWith(isLoadingMore: true));

    try {
      final nextPage = state.currentPage + 1;
      final response =
          await _homeRepo.getTrendingTab(nextPage, limit: _pageSize);

      response.when(
        success: (moreData) {
          if (moreData.trendingData?.trending?.packs != null &&
              state.data != null) {
            final updatedData = _mergeTrendingData(state.data!, moreData);
            final hasReachedMax =
                moreData.trendingData!.trending?.pagination?.hasNextPage ==
                    false;

            emit(state.copyWith(
              isLoadingMore: false,
              data: updatedData,
              currentPage: nextPage,
              hasReachedMax: hasReachedMax,
            ));
          } else {
            emit(state.copyWith(
              isLoadingMore: false,
              hasReachedMax: true,
            ));
          }
        },
        failure: (error) {
          emit(state.copyWith(
            isLoadingMore: false,
            hasError: true,
            error: error.apiErrorModel,
          ));
        },
      );
    } on DioException catch (e) {
      _handleDioError(e);
    } catch (e) {
      _handleGenericError(e.toString());
    }
  }

  TrendingResponse _mergeTrendingData(
      TrendingResponse currentData, TrendingResponse newData) {
    // Create a deep copy of the current data
    final Map<String, dynamic> updatedData =
        Map<String, dynamic>.from(currentData.toJson());

    // Get the current trending data
    final Map<String, dynamic> currentSuggested = (updatedData['data']
        as Map<String, dynamic>)['trending'] as Map<String, dynamic>;

    // Get current and new packs
    final List<dynamic> currentPacks =
        List<dynamic>.from(currentSuggested['packs'] as List);
    final List<dynamic> newPacks =
        (newData.data?['trending']?['packs'] as List?)?.cast<dynamic>() ?? [];

    // Merge packs
    currentSuggested['packs'] = [...currentPacks, ...newPacks];

    // Update pagination
    currentSuggested['pagination'] = newData.data?['trending']?['pagination'];

    // Update the data
    (updatedData['data'] as Map<String, dynamic>)['trending'] =
        currentSuggested;

    // Create new TrendingResponse with merged data
    return TrendingResponse(
      status: newData.status,
      success: newData.success,
      message: newData.message,
      metadata: newData.metadata,
      data: updatedData['data'] as Map<String, dynamic>,
    );
  }

  void _handleDioError(DioException e) {
    if (e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.receiveTimeout ||
        e.type == DioExceptionType.sendTimeout) {
      _authService.setIsOffline(true, reason: OfflineReason.serverTimeout);
    }

    emit(state.copyWith(
      isLoading: false,
      isLoadingMore: false,
      hasError: true,
      error: const GeneralResponse(
        success: false,
        status: 500,
        message: 'Connection error occurred',
      ),
    ));
  }

  void _handleGenericError(String message) {
    emit(state.copyWith(
      isLoading: false,
      isLoadingMore: false,
      hasError: true,
      error: GeneralResponse(
        success: false,
        status: 500,
        message: message,
      ),
    ));
  }

  void resetError() {
    emit(state.copyWith(hasError: false, error: null));
  }

  Future<void> refresh() async {
    // Wait for new data before generating new colors
    await getTrendingContent();

    // Generate new colors based on current data length
    final recommendedLength =
        state.data?.trendingData?.topCategories?.length ?? 0;
    final newColors = List.generate(
      recommendedLength,
      (_) => ColorsManager.getRandomColor(),
    );

    emit(state.copyWith(
      categoriesColors: newColors,
    ));
  }
}
