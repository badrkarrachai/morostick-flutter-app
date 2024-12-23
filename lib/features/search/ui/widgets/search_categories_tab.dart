import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:morostick/core/helpers/spacing.dart';
import 'package:morostick/core/theming/text_styles.dart';
import 'package:morostick/core/theming/colors.dart';

class SearchCategoriesTab extends StatelessWidget {
  final TabController tabController;

  final List<Map<String, dynamic>> categories;

  const SearchCategoriesTab({
    super.key,
    required this.tabController,
    required this.categories,
  });

  @override
  Widget build(BuildContext context) {
    return TabBar(
      controller: tabController,
      isScrollable: false,
      labelStyle: TextStyles.font13DarkPurpleSemiBold,
      unselectedLabelStyle: TextStyles.font13RegularGray,
      labelColor: ColorsManager.mainPurple,
      unselectedLabelColor: ColorsManager.grayPurple,
      indicatorColor: ColorsManager.mainPurple,
      indicatorSize: TabBarIndicatorSize.tab,
      tabs: categories
          .map((category) => Tab(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(category['icon']),
                      horizontalSpace(5),
                      Text(category['title']),
                    ],
                  ),
                ),
              ))
          .toList(),
    );
  }
}
