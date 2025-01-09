import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:morostick/core/data/models/general_response_model.dart';
import 'package:morostick/core/data/models/pack_model.dart';
import 'package:morostick/core/helpers/extensions.dart';
import 'package:morostick/core/helpers/pack_events.dart';
import 'package:morostick/core/services/auth_navigation_service.dart';
import 'package:morostick/core/theming/colors.dart';
import 'package:morostick/core/widgets/app_message_box.dart';
import 'package:morostick/core/widgets/app_offline_messagebox.dart';
import 'package:morostick/core/widgets/app_snackbar.dart';
import 'package:morostick/features/pack/data/models/report_pack_request_body.dart';
import 'package:morostick/features/pack/data/repo/pack_repo.dart';
import 'package:morostick/features/pack/logic/view_pack_details_state.dart';
import 'package:morostick/morostick_app.dart';
import 'package:toastification/toastification.dart';

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

  // GET PACK DETAILS LOGIC
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
            final stickersLenght = packResponse.pack?.stickers?.length ?? 0;
            emit(state.copyWith(
              isLoadingPack: false,
              pack: packResponse.pack,
              isFavorite: packResponse.pack?.isFavorite ?? false,
              downloadCount: packResponse.pack?.stats?.downloads ?? 0,
              favoriteCount: packResponse.pack?.stats?.favorites ?? 0,
              stickers: packResponse.pack?.stickers ?? [],
              stickerBGColors: _generateColors(stickersLenght),
            ));
          },
          failure: (error) async {
            if (!await _authService.checkConnectivity()) {
              emit(state.copyWith(
                isLoadingPack: false,
                hasError: true,
                error: const GeneralResponse(
                  success: false,
                  status: -6,
                  message: 'No Internet Connection',
                ),
              ));
              return;
            }
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

  // TOGGLE FAVORITE PACK LOGIC
  Future<void> togglePackFavorite(String packId, bool isFavorite) async {
    if (_authService.isGuestMode) {
      GuestDialogService.showGuestRestriction(
          message: 'Please login to add this pack to your favourites');
      return;
    }
    if (state.isLoadingFavorite) return;

    emit(state.copyWith(
        isLoadingFavorite: true,
        isFavorite: isFavorite,
        favoriteCount:
            isFavorite ? state.favoriteCount + 1 : state.favoriteCount - 1));

    final operation = _packRepo.togglePackFavorite(packId).then(
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
          failure: (error) async {
            if (!await _authService.checkConnectivity()) {
              emit(state.copyWith(
                isLoadingFavorite: false,
                isMessageBoxError: false,
                hasError: true,
                error: const GeneralResponse(
                  success: false,
                  status: -6,
                  message: 'No Internet Connection',
                ),
              ));
              return;
            }
            emit(state.copyWith(
              isLoadingFavorite: false,
              isMessageBoxError: true,
              isFavorite: !isFavorite,
              hasError: true,
              error: error.apiErrorModel,
            ));
          },
        );
      },
      onError: (e) {
        emit(state.copyWith(
          isLoadingFavorite: false,
          isMessageBoxError: true,
          isFavorite: !isFavorite,
          hasError: true,
          error: GeneralResponse(
            success: false,
            status: 500,
            message: "Something went wrong. Please try again later.",
          ),
        ));
      },
    );

    _pendingOperations.add(operation);
    await operation;
    _pendingOperations.remove(operation);
  }

  // HIDE PACK LOGIC
  Future<void> hidePack(String packId) async {
    if (state.isLoadingHide) return;
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
          failure: (error) async {
            if (!await _authService.checkConnectivity()) {
              emit(state.copyWith(
                isLoadingHide: false,
                isMessageBoxError: false,
                hasError: true,
                error: const GeneralResponse(
                  success: false,
                  status: -6,
                  message: 'No Internet Connection',
                ),
              ));
              return;
            }
            try {
              emit(state.copyWith(
                isLoadingHide: false,
                isMessageBoxError: true,
                error: error.apiErrorModel,
              ));
            } catch (e) {
              showAppSnackbar(
                title: error.apiErrorModel.message,
                duration: 3,
                type: ToastificationType.error,
                description: error.apiErrorModel.error?.details ??
                    "Something went wrong. Please try again later.",
              );
            }
          },
        );
      },
      onError: (e) {
        try {
          emit(state.copyWith(
            isLoadingHide: false,
            isMessageBoxError: true,
            error: GeneralResponse(
              success: false,
              status: 500,
              message: "Something went wrong. Please try again later.",
            ),
          ));
        } catch (e) {
          showAppSnackbar(
            title: "Error Occurred",
            duration: 3,
            type: ToastificationType.error,
            description: "Something went wrong. Please try again later.",
          );
        }
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

  // REPORT PACK LOGIC
  Future<void> reportPack(String packId, String reason) async {
    if (state.isLoadingHide) return;
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
          failure: (error) async {
            if (!await _authService.checkConnectivity()) {
              emit(state.copyWith(
                isLoadingHide: false,
                isMessageBoxError: false,
                hasError: true,
                error: const GeneralResponse(
                  success: false,
                  status: -6,
                  message: 'No Internet Connection',
                ),
              ));
              return;
            }
            try {
              emit(state.copyWith(
                isLoadingHide: false,
                isMessageBoxError: true,
                error: error.apiErrorModel,
              ));
            } catch (e) {
              showAppSnackbar(
                title: error.apiErrorModel.message,
                duration: 3,
                type: ToastificationType.error,
                description: error.apiErrorModel.error?.details ??
                    "Something went wrong. Please try again later.",
              );
            }
          },
        );
      },
      onError: (e) {
        try {
          emit(state.copyWith(
            isLoadingHide: false,
            isMessageBoxError: true,
            error: GeneralResponse(
              success: false,
              status: 500,
              message: "Something went wrong. Please try again later.",
            ),
          ));
        } catch (e) {
          showAppSnackbar(
            title: "Error Occurred",
            duration: 3,
            type: ToastificationType.error,
            description: "Something went wrong. Please try again later.",
          );
        }
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

  // TOGGLE FAVORITE STICKER LOGIC
  Future<void> toggleStickerFavorite({
    required String stickerId,
  }) async {
    // check if the user is not in guest mode
    if (_authService.isGuestMode) {
      GuestDialogService.showGuestRestriction(
          message: 'Please login to add this pack to your favourites');
      return;
    }
    if (state.isLoadingFavoriteSticker) return;
    // Hold the current stickers list
    final List<Sticker> currentStickers = state.stickers;
    emit(state.copyWith(
      isLoadingFavoriteSticker: true,
      stickers: state.stickers.map((sticker) {
        if (sticker.id == stickerId) {
          sticker.isFavorite = !sticker.isFavorite!;
        }
        return sticker;
      }).toList(),
    ));

    final operation = _packRepo.toggleStickerFavorite(stickerId).then(
      (response) {
        response.when(
          success: (togglePackFavoriteResponse) {
            emit(state.copyWith(
              isLoadingFavoriteSticker: false,
              stickers: state.stickers.map((sticker) {
                if (sticker.id == stickerId) {
                  sticker.isFavorite =
                      togglePackFavoriteResponse.favoriteData!.isFavorite;
                }
                return sticker;
              }).toList(),
            ));
          },
          failure: (error) async {
            if (!await _authService.checkConnectivity()) {
              emit(state.copyWith(
                isLoadingFavoriteSticker: false,
                isMessageBoxError: false,
                hasError: true,
                stickers: currentStickers,
                error: const GeneralResponse(
                  success: false,
                  status: -6,
                  message: 'No Internet Connection',
                ),
              ));
              return;
            }
            emit(state.copyWith(
              isLoadingFavoriteSticker: false,
              isMessageBoxError: true,
              hasError: true,
              error: error.apiErrorModel,
              stickers: currentStickers,
            ));
          },
        );
      },
      onError: (e) {
        emit(state.copyWith(
          isLoadingFavoriteSticker: false,
          isMessageBoxError: true,
          hasError: true,
          stickers: currentStickers,
          error: GeneralResponse(
            success: false,
            status: 500,
            message: "Something went wrong. Please try again later.",
          ),
        ));
      },
    );

    _pendingOperations.add(operation);
    await operation;
    _pendingOperations.remove(operation);
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

  List<Color> _generateColors(int length) {
    if (length == 0) return const [];
    return List.generate(length, (_) => ColorsManager.getRandomColor());
  }
}
