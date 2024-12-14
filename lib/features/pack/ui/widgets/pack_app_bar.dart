import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:morostick/core/theming/colors.dart';
import 'package:morostick/core/widgets/app_back_button.dart';
import 'package:morostick/features/pack/ui/widgets/pack_favorite_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:morostick/features/pack/ui/widgets/pack_options_bottom_sheet.dart';
import 'package:morostick/features/pack/ui/widgets/pack_report_dialog.dart';

class PackAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onFavoriteToggle;
  final ValueNotifier<bool> isFavorite;
  final VoidCallback onHide;
  final VoidCallback onReport;

  const PackAppBar({
    super.key,
    required this.onFavoriteToggle,
    required this.isFavorite,
    required this.onHide,
    required this.onReport,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      automaticallyImplyLeading: false, // Disable default back button
      title: Row(
        children: [
          AppBackButton(
            buttonWidth: 40.w,
            buttonHeight: 40.h,
          ),
        ],
      ),
      titleSpacing: 16.w,
      actions: [
        PackFavoriteButton(
          isFavorite: isFavorite,
          onToggle: onFavoriteToggle,
        ),
        Padding(
          padding: EdgeInsets.only(right: 16.w),
          child: IconButton(
            onPressed: () => _showOptionsBottomSheet(context),
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

  void _showOptionsBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => PackOptionsBottomSheet(
        onHide: () {
          Navigator.pop(context);
          onHide();
        },
        onReport: () {
          Navigator.pop(context);
          _showReportDialog(context);
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
          onReport();
        },
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
