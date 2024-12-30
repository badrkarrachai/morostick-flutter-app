import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:morostick/core/data/models/general_response_model.dart';
import 'package:morostick/core/services/auth_navigation_service.dart';
import 'package:morostick/core/theming/colors.dart';
import 'package:morostick/core/widgets/app_offline_banner.dart';
import 'package:morostick/features/home/data/models/foryou_tab_response.dart';
import 'package:morostick/features/home/data/repos/home_repo.dart';
import 'package:morostick/features/home/logic/foryou_tab_cubit/foryou_tab_state.dart';

class ForYouCubit extends Cubit<ForYouState> {
  final HomeRepo _homeRepo;
  final AuthNavigationService _authService;
  static const int _pageSize = 10;
  static const int _maxRetries = 3;

  ForYouCubit(this._homeRepo, this._authService) : super(const ForYouState());

  Future<void> getForYouContent([int retryCount = 0]) async {
    if (state.isLoading) return;

    emit(state.copyWith(
      isLoading: true,
      hasError: false,
      error: null,
      currentPage: 1,
      hasReachedMax: false,
      carouselState:
          state.carouselState.copyWith(status: CarouselStatus.loading),
    ));

    try {
      final response = await _homeRepo.getForYouTab(1, limit: _pageSize);

      response.when(
        success: (forYouResponse) {
          final recommendedLength =
              forYouResponse.forYouData?.recommended?.length ?? 0;
          final hasReachedMax =
              forYouResponse.forYouData?.suggested?.pagination?.hasNextPage ==
                  false;

          emit(state.copyWith(
            isLoading: false,
            data: forYouResponse,
            hasReachedMax: hasReachedMax,
            carouselState: CarouselState(
              colors: _generateColors(recommendedLength),
              status: CarouselStatus.loaded,
            ),
          ));
        },
        failure: (error) => _handleError(error.apiErrorModel),
      );
    } on DioException catch (e) {
      if (retryCount < _maxRetries) {
        await Future.delayed(Duration(seconds: retryCount + 1));
        return getForYouContent(retryCount + 1);
      }
      _handleDioError(e);
    } catch (e) {
      _handleGenericError(e.toString());
    }
  }

  List<Color> _generateColors(int length) {
    if (length == 0) return const [];
    return List.generate(length, (_) => ColorsManager.getRandomColor());
  }

  Future<void> loadMoreContent() async {
    if (_shouldSkipLoadMore) return;

    emit(state.copyWith(isLoadingMore: true));

    try {
      final nextPage = state.currentPage + 1;
      final response = await _homeRepo.getForYouTab(nextPage, limit: _pageSize);

      response.when(
        success: (moreData) => _handleLoadMoreSuccess(moreData, nextPage),
        failure: (error) => _handleError(error.apiErrorModel),
      );
    } on DioException catch (e) {
      _handleDioError(e);
    } catch (e) {
      _handleGenericError(e.toString());
    }
  }

  bool get _shouldSkipLoadMore =>
      state.isLoadingMore || state.isLoading || state.hasReachedMax;

  void _handleLoadMoreSuccess(ForYouResponse moreData, int nextPage) {
    if (state.data == null) {
      emit(state.copyWith(
        isLoadingMore: false,
        hasReachedMax: true,
      ));
      return;
    }

    final updatedData = _mergeForYouData(state.data!, moreData);
    final hasReachedMax =
        moreData.forYouData?.suggested?.pagination?.hasNextPage == false;

    emit(state.copyWith(
      isLoadingMore: false,
      data: updatedData,
      currentPage: nextPage,
      hasReachedMax: hasReachedMax,
    ));
  }

  void _handleError(GeneralResponse? error) {
    emit(state.copyWith(
      isLoading: false,
      isLoadingMore: false,
      hasError: true,
      error: error,
      carouselState: state.carouselState.copyWith(status: CarouselStatus.error),
    ));
  }

  void _handleDioError(DioException e) {
    if (_isConnectionTimeout(e)) {
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
      carouselState: state.carouselState.copyWith(status: CarouselStatus.error),
    ));
  }

  bool _isConnectionTimeout(DioException e) =>
      e.type == DioExceptionType.connectionTimeout ||
      e.type == DioExceptionType.receiveTimeout ||
      e.type == DioExceptionType.sendTimeout;

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
      carouselState: state.carouselState.copyWith(status: CarouselStatus.error),
    ));
  }

  Future<void> refresh() async {
    await getForYouContent();
  }

  void updateCarouselPage(int page) {
    if (page == state.carouselState.currentPage) return;

    emit(state.copyWith(
      carouselState: state.carouselState.copyWith(currentPage: page),
    ));
  }

  ForYouResponse _mergeForYouData(
      ForYouResponse currentData, ForYouResponse newData) {
    final Map<String, dynamic> updatedData =
        Map<String, dynamic>.from(currentData.toJson());
    final Map<String, dynamic> currentSuggested = (updatedData['data']
        as Map<String, dynamic>)['suggested'] as Map<String, dynamic>;

    final List<dynamic> currentPacks =
        List<dynamic>.from(currentSuggested['packs'] as List);
    final List<dynamic>? newPacks =
        newData.data?['suggested']?['packs'] as List?;

    if (newPacks != null) {
      currentSuggested['packs'] = [...currentPacks, ...newPacks];
      currentSuggested['pagination'] =
          newData.data?['suggested']?['pagination'];
      (updatedData['data'] as Map<String, dynamic>)['suggested'] =
          currentSuggested;
    }

    return ForYouResponse(
      status: newData.status,
      success: newData.success,
      message: newData.message,
      metadata: newData.metadata,
      data: updatedData['data'] as Map<String, dynamic>,
    );
  }
}
