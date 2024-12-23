import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:morostick/core/helpers/extensions.dart';
import 'package:morostick/core/theming/colors.dart';
import 'package:morostick/core/theming/text_styles.dart';
import 'package:morostick/core/helpers/spacing.dart';
import 'package:morostick/core/widgets/app_button.dart';
import 'package:morostick/core/widgets/app_drop_down_menu.dart';

class FilterBottomSheet extends StatefulWidget {
  const FilterBottomSheet({super.key});

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  String? selectedSort;
  double minStickers = 5;
  String searchBy = 'all';
  String stickerType = 'regular';

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: ColorsManager.backgroundLightColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.only(
              top: 12.h,
              bottom: 8.h,
              left: 16.w,
              right: 16.w,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Handle bar
                Container(
                  width: 40.w,
                  height: 4.h,
                  decoration: BoxDecoration(
                    color: ColorsManager.lightGray,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),

                verticalSpace(12),

                // Header row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Smart Search',
                      style: TextStyles.font16DarkPurpleSemiBold,
                    ),
                    GestureDetector(
                      onTap: () => context.pop(),
                      child: Container(
                        decoration: BoxDecoration(
                          color: ColorsManager.middleGray,
                          borderRadius: BorderRadius.circular(52),
                        ),
                        padding: EdgeInsets.all(3.w),
                        child: Icon(
                          Icons.close,
                          color: Colors.white,
                          size: 13.sp,
                        ),
                      ),
                    ),
                  ],
                ),

                verticalSpace(16),

                // Clear All button
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: ColorsManager.mainPurple.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(
                      color: ColorsManager.mainPurple.withOpacity(0.1),
                    ),
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          selectedSort = null;
                          minStickers = 5;
                          searchBy = 'all';
                          stickerType = 'regular';
                        });
                      },
                      borderRadius: BorderRadius.circular(12.r),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 12.h,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.replay_outlined,
                              size: 18.sp,
                              color: ColorsManager.mainPurple,
                            ),
                            horizontalSpace(8),
                            Text(
                              'Reset All Filters',
                              style: TextStyles.font14PurpleSemiBold,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          verticalSpace(10),

          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Sort By Dropdown
                  Text('Sort By', style: TextStyles.font14RegularGray),
                  verticalSpace(8),
                  AppDropDownMenu<String>(
                    value: selectedSort,
                    isExpanded: true,
                    hintText: 'Select sorting',
                    items: ['Most Popular', 'Most Recent', 'Oldest']
                        .map((e) => DropdownMenuItem(
                              value: e,
                              child: Text(e,
                                  style: TextStyles.font14DarkPurpleMedium),
                            ))
                        .toList(),
                    onChanged: (value) => setState(() => selectedSort = value),
                  ),

                  verticalSpace(15),

                  // Minimum Stickers Slider
                  Text('Minimum Number of Stickers',
                      style: TextStyles.font14RegularGray),
                  verticalSpace(10),
                  Text('${minStickers.round()}~30 Stickers',
                      style: TextStyles.font14DarkPurpleMedium),
                  Slider(
                    value: minStickers,
                    min: 1,
                    max: 30,
                    divisions: 30,
                    activeColor: ColorsManager.mainPurple,
                    inactiveColor: ColorsManager.lighterPurple,
                    label: minStickers.round().toString(),
                    onChanged: (value) => setState(() => minStickers = value),
                  ),

                  verticalSpace(15),

                  // Search By Radio Buttons
                  Text('Search By', style: TextStyles.font14RegularGray),
                  verticalSpace(8),
                  _buildRadioTile('All', 'all', searchBy,
                      (value) => setState(() => searchBy = value!)),
                  _buildRadioTile('Pack Name Only', 'pack', searchBy,
                      (value) => setState(() => searchBy = value!)),
                  _buildRadioTile('Creator Name Only', 'creator', searchBy,
                      (value) => setState(() => searchBy = value!)),

                  verticalSpace(15),

                  // Sticker Type Radio Buttons
                  Text('Sticker Type', style: TextStyles.font14RegularGray),
                  verticalSpace(8),
                  _buildRadioTile('Regular Stickers', 'regular', stickerType,
                      (value) => setState(() => stickerType = value!)),
                  _buildRadioTile('Animated Stickers', 'animated', stickerType,
                      (value) => setState(() => stickerType = value!)),

                  verticalSpace(15),
                ],
              ),
            ),
          ),

          // Apply Button
          Padding(
            padding: EdgeInsets.all(16.w),
            child: AppButton(
              buttonText: 'Apply Filters',
              textStyle: TextStyles.font16WhiteMedium,
              onPressed: () {
                // Handle filter application
                Navigator.pop(context, {
                  'sort': selectedSort,
                  'minStickers': minStickers,
                  'searchBy': searchBy,
                  'stickerType': stickerType,
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRadioTile(String title, String value, String groupValue,
      Function(String?) onChanged) {
    return Theme(
      data: Theme.of(context).copyWith(
        unselectedWidgetColor: ColorsManager.grayPurple,
      ),
      child: RadioListTile<String>(
        title: Text(title, style: TextStyles.font14DarkPurpleMedium),
        value: value,
        groupValue: groupValue,
        activeColor: ColorsManager.mainPurple,
        contentPadding: EdgeInsets.zero,
        visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
        onChanged: onChanged,
      ),
    );
  }
}
