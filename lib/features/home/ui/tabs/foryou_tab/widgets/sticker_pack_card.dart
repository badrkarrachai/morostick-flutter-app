import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:morostick/core/data/models/pack_model.dart';
import 'package:morostick/core/di/dependency_injection.dart';
import 'package:morostick/core/widgets/app_cached_network_image.dart';
import 'package:morostick/core/helpers/spacing.dart';
import 'package:morostick/core/theming/text_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:morostick/features/pack/logic/view_pack_details_cubit.dart';
import 'package:morostick/features/pack/ui/pack_screen.dart';

class StickerPackCard extends StatelessWidget {
  final Pack stickerPack;
  final EdgeInsetsGeometry? margin;
  final Color color;
  final String packId;

  const StickerPackCard({
    super.key,
    required this.stickerPack,
    this.margin,
    required this.color,
    required this.packId,
  });

  @override
  Widget build(BuildContext context) {
    // Make sure there are preview stickers available
    if (stickerPack.stickers == null || stickerPack.stickers!.isEmpty) {
      return const SizedBox.shrink();
    }

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BlocProvider(
              create: (context) {
                final cubit = getIt<ViewPackDetailsCubit>();
                cubit.packId = packId;
                return cubit;
              },
              child: const PackScreen(),
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(16.r),
        ),
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                  flex: 1,
                  child: AppCachedNetworkImage.thumbnail(
                    width: 110.w,
                    height: 110.h,
                    imageUrl: stickerPack.trayIcon ?? '',
                  ),
                ),
                horizontalSpace(20),
                Flexible(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        stickerPack.name!.toUpperCase(),
                        style: TextStyles.font23WhiteSemiBold,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        '${stickerPack.totalStickers} STICKERS',
                        style: TextStyles.font13GrayWhiteRegular,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
