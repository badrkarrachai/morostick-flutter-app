import 'package:flutter/material.dart';
import 'package:morostick/core/helpers/spacing.dart';
import 'package:morostick/core/theming/text_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:morostick/features/search/ui/widgets/search_chip_widget.dart';

class RecentSearchesWidget extends StatelessWidget {
  final List<String> searches;
  final VoidCallback onClearAll;
  final Function(String) onRemoveSearch;

  const RecentSearchesWidget({
    super.key,
    required this.searches,
    required this.onClearAll,
    required this.onRemoveSearch,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (searches.isNotEmpty)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Recent Searches', style: TextStyles.font14RegularGray),
              TextButton(
                onPressed: onClearAll,
                child:
                    Text('Delete All', style: TextStyles.font14PurpleSemiBold),
              ),
            ],
          ),
        if (searches.isNotEmpty) verticalSpace(12),
        Wrap(
          spacing: 8.w,
          runSpacing: 8.h,
          children: searches
              .map((search) => SearchChipWidget(
                    label: search,
                    onRemove: () => onRemoveSearch(search),
                  ))
              .toList(),
        ),
      ],
    );
  }
}
