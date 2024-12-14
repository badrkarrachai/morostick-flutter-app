import 'package:flutter/material.dart';
import 'package:morostick/core/helpers/spacing.dart';
import 'package:morostick/features/home/ui/widgets/suggested_for_you.dart';
import 'package:morostick/features/search/ui/widgets/selected_filters_view.dart';
import 'package:morostick/features/search/ui/widgets/serach_filters_bottom_sheet.dart';

class SearchPacksTab extends StatefulWidget {
  const SearchPacksTab({super.key});

  @override
  State<SearchPacksTab> createState() => _SearchPacksTabState();
}

class _SearchPacksTabState extends State<SearchPacksTab> {
  final Map<String, dynamic> selectedFilters = {
    'sort': 'Most Popular',
    'minStickers': 15,
    'searchBy': 'pack',
    'stickerType': 'animated',
  };

  void showFiltersBottomSheet(BuildContext context) async {
    final result = await showModalBottomSheet<Map<String, dynamic>>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => SizedBox(
        height: screenH * 0.75,
        child: const FilterBottomSheet(),
      ),
    );
    if (result != null) {
      print(result);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SelectedFiltersView(
          filters: selectedFilters,
          onOpenFilters: () => showFiltersBottomSheet(context),
          onClearAll: () {},
          onRemoveFilter: (filterKey) {
            // Remove specific filter
          },
        ),
        verticalSpace(16),
        // const SuggestedForYou(),
        // const SuggestedForYou(),
        // const SuggestedForYou(),
        // const SuggestedForYou(),
        // const SuggestedForYou(),
        // const SuggestedForYou(),
        // const SuggestedForYou(),
      ],
    );
  }
}
