import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:morostick/core/theming/text_styles.dart';
import 'package:morostick/features/top_menu/ui/widgets/top_menu_item.dart';

class TopMenuSection extends StatelessWidget {
  final String? title;
  final List<TopMenuItem> items;

  const TopMenuSection({
    super.key,
    this.title,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null)
          Padding(
            padding: EdgeInsets.all(16.w),
            child: Text(
              title!,
              style: TextStyles.font14RegularGray,
            ),
          ),
        ...items.map((item) => TopMenuItemWidget(item: item)),
      ],
    );
  }
}
