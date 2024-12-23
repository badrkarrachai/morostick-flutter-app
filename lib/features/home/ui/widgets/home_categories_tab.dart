import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:morostick/core/theming/text_styles.dart';
import 'package:morostick/core/theming/colors.dart';

class HomeCategoriesTab extends StatelessWidget {
  final TabController tabController;
  final List<String> categories;

  const HomeCategoriesTab({
    super.key,
    required this.tabController,
    required this.categories,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      child: Theme(
        data: Theme.of(context).copyWith(
          tabBarTheme: const TabBarTheme(
            tabAlignment: TabAlignment.start, // This is the key property
          ),
        ),
        child: TabBar(
          controller: tabController,
          isScrollable: true,
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
                      child: Text(category),
                    ),
                  ))
              .toList(),
        ),
      ),
    );
  }
}
