import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:morostick/core/data/models/general_response_model.dart';
import 'package:morostick/core/services/auth_navigation_service.dart';
import 'package:morostick/core/theming/colors.dart';
import 'package:morostick/core/widgets/app_offline_banner.dart';
import 'package:morostick/features/home/data/models/for_you_tab_response.dart';
import 'package:morostick/features/home/data/repos/for_you_tab_repo.dart';
import 'package:morostick/features/home/logic/for_you_tab_state.dart';

class ForYouCubit extends Cubit<ForYouState> {
  final HomeRepo _homeRepo;
  final AuthNavigationService _authService;
  static const int _pageSize = 10;

  ForYouCubit(this._homeRepo, this._authService) : super(const ForYouState());

  Future<void> getForYouContent() async {
    if (state.isLoading) return;

    emit(state.copyWith(
      isLoading: true,
      hasError: false,
      error: null,
      currentPage: 1,
      hasReachedMax: false,
    ));

    try {
      final response = await _homeRepo.getForYouTab(1, limit: _pageSize);

      response.when(
        success: (forYouResponse) {
          final hasReachedMax =
              forYouResponse.forYouData?.suggested.pagination.hasNextPage ==
                  false;

          // Generate colors for recommended packs
          final colors = List.generate(
            forYouResponse.forYouData?.recommended.length ?? 0,
            (_) => ColorsManager.getRandomColor(),
          );

          emit(state.copyWith(
            isLoading: false,
            data: forYouResponse,
            hasReachedMax: hasReachedMax,
            carouselColors: colors,
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
      final response = await _homeRepo.getForYouTab(nextPage, limit: _pageSize);

      response.when(
        success: (moreData) {
          if (moreData.forYouData?.suggested.packs != null &&
              state.data != null) {
            final updatedData = _mergeForYouData(state.data!, moreData);
            final hasReachedMax =
                moreData.forYouData!.suggested.pagination.hasNextPage == false;

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

  ForYouResponse _mergeForYouData(
      ForYouResponse currentData, ForYouResponse newData) {
    // Create a deep copy of the current data
    final Map<String, dynamic> updatedData =
        Map<String, dynamic>.from(currentData.toJson());

    // Get the current suggested data
    final Map<String, dynamic> currentSuggested = (updatedData['data']
        as Map<String, dynamic>)['suggested'] as Map<String, dynamic>;

    // Get current and new packs
    final List<dynamic> currentPacks =
        List<dynamic>.from(currentSuggested['packs'] as List);
    final List<dynamic> newPacks =
        (newData.data?['suggested']?['packs'] as List?)?.cast<dynamic>() ?? [];

    // Merge packs
    currentSuggested['packs'] = [...currentPacks, ...newPacks];

    // Update pagination
    currentSuggested['pagination'] = newData.data?['suggested']?['pagination'];

    // Update the data
    (updatedData['data'] as Map<String, dynamic>)['suggested'] =
        currentSuggested;

    // Create new ForYouResponse with merged data
    return ForYouResponse(
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

  void refresh() {
    getForYouContent();
  }

  void updateCarouselPage(int page) {
    emit(state.copyWith(carouselCurrentPage: page));
  }
}
