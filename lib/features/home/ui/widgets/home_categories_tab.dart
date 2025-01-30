import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:morostick/core/theming/text_styles.dart';
import 'package:morostick/core/theming/colors.dart';
import 'package:morostick/core/widgets/app_shimmer_loading.dart';

class HomeCategoriesTab extends StatelessWidget {
  final TabController tabController;
  final List<String?> categories;
  final bool isLoading;

  const HomeCategoriesTab({
    super.key,
    required this.tabController,
    required this.categories,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      child: Theme(
        data: Theme.of(context).copyWith(
          tabBarTheme: const TabBarTheme(
            tabAlignment: TabAlignment.start,
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
          tabs: [
            for (final category in categories)
              Tab(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2.w),
                  child: isLoading && categories.indexOf(category) >= 2
                      ? AppShimmerLoading(
                          child: Container(
                            width: 60.w,
                            height: 13.h,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16.r),
                            ),
                          ),
                        )
                      : Text(category!),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
