import 'package:flutter/material.dart';
import 'package:morostick/core/helpers/spacing.dart';
import 'package:morostick/core/theming/text_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PackReportDialog extends StatelessWidget {
  final Function(String reason) onReport;

  const PackReportDialog({
    super.key,
    required this.onReport,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.r),
      ),
      title: Text(
        'Report Pack',
        style: TextStyles.font18BlackSemiBold,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Why are you reporting this pack?',
            style: TextStyles.font14RegularGray,
          ),
          verticalSpace(16),
          ...['Inappropriate content', 'Spam', 'Violates terms', 'Other']
              .map((reason) => _buildReportOption(context, reason))
              .toList(),
        ],
      ),
    );
  }

  Widget _buildReportOption(BuildContext context, String reason) {
    return InkWell(
      onTap: () {
        onReport(reason);
        Navigator.pop(context);
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 12.h),
        child: Text(
          reason,
          style: TextStyles.font14DarkPurpleMedium,
        ),
      ),
    );
  }
}
