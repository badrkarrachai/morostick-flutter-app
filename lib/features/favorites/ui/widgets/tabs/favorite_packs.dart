import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:morostick/core/theming/colors.dart';
import 'package:morostick/core/theming/text_styles.dart';
import 'package:morostick/features/favorites/logic/favorite_packs_cubit/favorite_packs_cubit.dart';
import 'package:morostick/features/favorites/logic/favorite_packs_cubit/favorite_packs_state.dart';
import 'package:morostick/features/home/ui/tabs/foryou_tab/foryou_tab.dart';
import 'package:morostick/features/home/ui/tabs/foryou_tab/widgets/no_data.dart';
import 'package:morostick/features/home/ui/tabs/other_categories_tabs/widgets/other_categories_shimmer.dart';
import 'package:morostick/features/home/ui/tabs/trending/widgets/trending_packs.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FavoritePacks extends StatefulWidget {
  const FavoritePacks({super.key});

  @override
  State<FavoritePacks> createState() => _FavoritePacksState();
}

class _FavoritePacksState extends State<FavoritePacks>
    with AutomaticKeepAliveClientMixin {
  late final ScrollController _scrollController;
  final List<String> _filterOptions = ['All', 'Regular', 'Animated'];

  @override
  bool get wantKeepAlive => true; // Keep the state alive

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); // Required by AutomaticKeepAliveClientMixin

    return ScrollConfiguration(
      behavior: ScrollConfiguration.of(context).copyWith(
        physics: const ClampingScrollPhysics(),
      ),
      child: BlocBuilder<FavoritePacksCubit, FavoritePacksState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const OtherCategoriesTabShimmer();
          }

          final packs = state.favoritePacks ?? [];

          if (packs.isEmpty) {
            return Column(
              children: [
                _buildFilterChips(state.selectedFilter),
                Expanded(
                  child: NoDataWidget(
                    title: "No Favorite Packs",
                    message:
                        "You haven't added any packs to your favorites yet",
                    onRefresh: () =>
                        context.read<FavoritePacksCubit>().refresh(),
                  ),
                ),
              ],
            );
          }

          return RefreshIndicator(
            onRefresh: () async {
              if (!state.isLoading) {
                await context.read<FavoritePacksCubit>().refresh();
              }
            },
            child: LazyLoadingListView(
              key: const PageStorageKey('packs_list'),
              scrollController: _scrollController,
              isLoading: state.isLoadingMore,
              hasReachedMax: state.hasReachedMax,
              onLoadMore: () => context.read<FavoritePacksCubit>().loadMore(),
              headerWidgets: [
                _buildFilterChips(state.selectedFilter),
              ],
              items: packs,
              itemBuilder: (context, index) {
                return TrendingPacks(
                  trendingPacks: [packs[index]],
                );
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildFilterChips(String selectedFilter) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: _filterOptions.map((filter) {
          final bool isSelected =
              selectedFilter.toLowerCase() == filter.toLowerCase();
          return Padding(
            padding: EdgeInsets.only(right: 8.w),
            child: _buildFilterChip(filter, isSelected),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildFilterChip(String filter, bool isSelected) {
    return InkWell(
      onTap: () => context.read<FavoritePacksCubit>().setFilter(filter),
      borderRadius: BorderRadius.circular(20.r),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: isSelected
              ? ColorsManager.mainPurple
              : ColorsManager.lighterPurple,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
            color: isSelected
                ? ColorsManager.mainPurple
                : ColorsManager.mainPurple.withValues(alpha: 0.3),
            width: 1.5,
          ),
        ),
        child: Text(
          filter,
          style: isSelected
              ? TextStyles.font13GrayWhiteRegular
              : TextStyles.font13PurpleRegular,
        ),
      ),
    );
  }
}
