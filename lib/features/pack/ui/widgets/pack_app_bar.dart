import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:morostick/core/helpers/extensions.dart';
import 'package:morostick/core/theming/colors.dart';
import 'package:morostick/core/widgets/app_custom_icon_button.dart';
import 'package:morostick/features/pack/ui/widgets/pack_favorite_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:morostick/features/pack/ui/widgets/pack_options_bottom_sheet.dart';
import 'package:morostick/features/pack/ui/widgets/pack_report_dialog.dart';

class PackAppBar extends StatelessWidget implements PreferredSizeWidget {
  final void Function(String, bool) onFavoriteToggle;
  final bool isFavorite;
  final void Function(String, BuildContext) onHide;
  final Function(dynamic Function(BuildContext)) handelReportMessagBox;
  final void Function(String, String) onReport;
  final bool isLoading;
  final String packId;
  final BuildContext mainContext;

  const PackAppBar({
    super.key,
    required this.onFavoriteToggle,
    required this.isFavorite,
    required this.onHide,
    required this.handelReportMessagBox,
    this.isLoading = false,
    required this.packId,
    required this.onReport,
    required this.mainContext,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      automaticallyImplyLeading: false, // Disable default back button
      title: const Row(
        children: [
          AppCustomIconButton(),
        ],
      ),
      titleSpacing: 16.w,
      actions: [
        if (!isLoading)
          PackFavoriteButton(
            isFavorite: isFavorite,
            onToggle: onFavoriteToggle,
            packId: packId,
          ),
        if (!isLoading)
          Padding(
            padding: EdgeInsets.only(right: 16.w),
            child: IconButton(
              onPressed: () => _showOptionsBottomSheet(context, mainContext),
              icon: Icon(
                HugeIcons.strokeRoundedMoreVertical,
                color: ColorsManager.darkPurple,
                size: 24.sp,
              ),
            ),
          ),
      ],
    );
  }

  void _showOptionsBottomSheet(BuildContext context, BuildContext mainContext) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => PackOptionsBottomSheet(
        onHide: () {
          context.pop();
          onHide(packId, mainContext);
        },
        onReport: () {
          context.pop();
          handelReportMessagBox((context) => _showReportDialog(context));
        },
      ),
    );
  }

  void _showReportDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => PackReportDialog(
        onReport: (reason) {
          // Handle report with reason
          onReport(packId, reason);
        },
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
