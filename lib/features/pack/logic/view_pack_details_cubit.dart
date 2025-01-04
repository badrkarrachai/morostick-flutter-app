import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:morostick/core/data/models/general_response_model.dart';
import 'package:morostick/core/helpers/extensions.dart';
import 'package:morostick/core/helpers/pack_events.dart';
import 'package:morostick/core/services/auth_navigation_service.dart';
import 'package:morostick/core/widgets/app_message_box.dart';
import 'package:morostick/core/widgets/app_offline_messagebox.dart';
import 'package:morostick/features/pack/data/models/report_pack_request_body.dart';
import 'package:morostick/features/pack/data/repo/pack_repo.dart';
import 'package:morostick/features/pack/logic/view_pack_details_state.dart';
import 'package:morostick/morostick_app.dart';

class ViewPackDetailsCubit extends Cubit<ViewPackDetailsState> {
  final PackRepo _packRepo;
  final AuthNavigationService _authService;
  late String packId;
  final List<Future> _pendingOperations = [];

  ViewPackDetailsCubit(
    this._packRepo,
    this._authService,
  ) : super(const ViewPackDetailsState());

  @override
  Future<void> close() async {
    // Wait for all pending operations to complete
    if (_pendingOperations.isNotEmpty) {
      await Future.wait(_pendingOperations);
    }
    return super.close();
  }

  Future<void> getPackDetails() async {
    if (state.isLoadingPack) return;

    emit(state.copyWith(
      isLoadingPack: true,
      hasError: false,
      error: null,
    ));

    final operation = _packRepo.getPackById(packId).then(
      (response) {
        response.when(
          success: (packResponse) {
            emit(state.copyWith(
              isLoadingPack: false,
              pack: packResponse.pack,
              isFavorite: packResponse.pack?.isFavorite ?? false,
              downloadCount: packResponse.pack?.stats?.downloads ?? 0,
              favoriteCount: packResponse.pack?.stats?.favorites ?? 0,
            ));
          },
          failure: (error) {
            emit(state.copyWith(
              isLoadingPack: false,
              hasError: true,
              error: error.apiErrorModel,
            ));
          },
        );
      },
      onError: (e) {
        if (e is DioException) {
          _handleDioError(e);
        } else {
          _handleGenericError(e.toString());
        }
      },
    );

    _pendingOperations.add(operation);
    await operation;
    _pendingOperations.remove(operation);
  }

  Future<void> toggleFavorite(String packId, bool isFavorite) async {
    // check if the user is not in guest mode
    if (_authService.isGuestMode) {
      GuestDialogService.showGuestRestriction(
          message: 'Please login to add this pack to your favourites');
      return;
    }
    print("Is Authenticated: ${_authService.isAuthenticated}");
    emit(state.copyWith(
        isLoadingFavorite: true,
        isFavorite: isFavorite,
        favoriteCount:
            isFavorite ? state.favoriteCount + 1 : state.favoriteCount - 1));

    final operation = _packRepo.toggleFavorite(packId).then(
      (response) {
        response.when(
          success: (togglePackFavoriteResponse) {
            emit(state.copyWith(
              isLoadingFavorite: false,
              isFavorite: togglePackFavoriteResponse.favoriteData!.isFavorite,
              favoriteCount:
                  togglePackFavoriteResponse.favoriteData!.favoritesCount,
            ));
          },
          failure: (error) {
            emit(state.copyWith(
              isLoadingFavorite: false,
              isFavorite: !isFavorite,
              hasError: true,
              error: error.apiErrorModel,
            ));
          },
        );
      },
      onError: (e) {
        _handleGenericError(e.toString());
      },
    );

    _pendingOperations.add(operation);
    await operation;
    _pendingOperations.remove(operation);
  }

  Future<void> hidePack(String packId) async {
    emit(state.copyWith(isLoadingHide: true));

    final operation = _packRepo.hidePack(packId).then(
      (response) {
        response.when(
          success: (hidePackResponse) {
            emit(state.copyWith(
              isLoadingHide: false,
            ));
            PackEvents.notifyPackHidden(packId);
          },
          failure: (error) {
            emit(state.copyWith(
              isLoadingHide: false,
              isMessageBoxError: true,
              error: error.apiErrorModel,
            ));
          },
        );
      },
      onError: (e) {
        _handleGenericError(e.toString());
      },
    );

    _pendingOperations.add(operation);
    await operation;
    _pendingOperations.remove(operation);
  }

  void handelHidePack(String packId, BuildContext mainContext) {
    // check if the user is not in guest mode
    if (_authService.isGuestMode) {
      GuestDialogService.showGuestRestriction(
          message: 'Please login to add this pack to your favourites');
      return;
    }
    AppMessageBoxDialogServiceNonContext.showConfirm(
      title: 'Confirm Action',
      message: 'Are you sure you want to hide this pack?',
      confirmText: 'Yes, proceed',
      cancelText: 'No, cancel',
      onConfirm: () {
        hidePack(packId);
        mainContext.pop();
      },
    );
  }

  Future<void> reportPack(String packId, String reason) async {
    emit(state.copyWith(isLoadingHide: true));

    final operation = _packRepo
        .reportPack(packId, ReportPackRequestBody(reason: reason))
        .then(
      (response) {
        response.when(
          success: (hidePackResponse) {
            emit(state.copyWith(
              isLoadingHide: false,
            ));
            PackEvents.notifyPackHidden(packId);
          },
          failure: (error) {
            emit(state.copyWith(
              isLoadingHide: false,
              isMessageBoxError: true,
              error: error.apiErrorModel,
            ));
          },
        );
      },
      onError: (e) {
        _handleGenericError(e.toString());
      },
    );

    _pendingOperations.add(operation);
    await operation;
    _pendingOperations.remove(operation);
  }

  void handelReportPackMessageBox(Function(BuildContext) showReportDialog) {
    final context = AppKeys.navigatorKey.currentContext!;
    // check if the user is not in guest mode
    if (_authService.isGuestMode) {
      GuestDialogService.showGuestRestriction(
          message: 'Please login to be able to report this pack.');
      return;
    }
    AppMessageBoxDialogServiceNonContext.showConfirm(
      title: 'Confirm Action',
      message: 'Are you sure you want to report this pack?',
      confirmText: 'Yes, proceed',
      cancelText: 'No, cancel',
      onConfirm: () {
        showReportDialog(context);
      },
    );
  }

  void _handleDioError(DioException e) {
    if (e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.receiveTimeout ||
        e.type == DioExceptionType.sendTimeout) {
      _authService.setIsOffline(true, reason: OfflineReason.serverTimeout);
    }

    emit(state.copyWith(
      isLoadingPack: false,
      isLoadingFavorite: false,
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
      isLoadingPack: false,
      isLoadingFavorite: false,
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
    await getPackDetails();
  }
}
