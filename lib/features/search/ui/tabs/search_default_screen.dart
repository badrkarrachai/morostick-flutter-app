import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:morostick/core/helpers/spacing.dart';
import 'package:morostick/features/search/logic/search_cubit.dart';
import 'package:morostick/features/search/logic/search_state.dart';
import 'package:morostick/features/search/ui/widgets/recent_searches_widget.dart';
import 'package:morostick/features/search/ui/widgets/trending_searches_loading_shimmer.dart';
import 'package:morostick/features/search/ui/widgets/trending_searches_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchDefaultScreen extends StatefulWidget {
  final String currentScreen;
  final void Function(String) onScreenChange;

  const SearchDefaultScreen({
    super.key,
    required this.currentScreen,
    required this.onScreenChange,
  });

  @override
  State<SearchDefaultScreen> createState() => _SearchDefaultScreenState();
}

class _SearchDefaultScreenState extends State<SearchDefaultScreen> {
  @override
  void initState() {
    super.initState();
    // Notify parent of current screen in next frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.onScreenChange('default');
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchCubit, SearchState>(
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RecentSearchesWidget(
                searches: state.recentSearches,
                onClearAll: () =>
                    context.read<SearchCubit>().clearAllSearches(),
                onRemoveSearch: (search) =>
                    context.read<SearchCubit>().removeSearch(search),
              ),
              verticalSpace(24),
              if (state.isLoadingTrendingSearches &&
                  state.trendingSearches.isEmpty)
                TrendingSearchesLoadingShimmer()
              else if (state.trendingSearches.isNotEmpty)
                TrendingSearchesWidget(items: state.trendingSearches)
              else
                const SizedBox.shrink(),
              SizedBox(height: 20.h),
            ],
          ),
        );
      },
    );
  }
}
