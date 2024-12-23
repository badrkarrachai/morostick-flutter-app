import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:morostick/core/widgets/app_cached_network_image.dart';
import 'package:morostick/core/theming/colors.dart';
import 'package:morostick/core/theming/text_styles.dart';

class TopCategories extends StatelessWidget {
  const TopCategories({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 16.w, bottom: 12.h),
          child: Text(
            'Categories',
            style: TextStyles.font14DarkPurpleSemiBold,
          ),
        ),
        GridView.builder(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 5,
            mainAxisSpacing: 0.h,
            crossAxisSpacing: 10.w,
            childAspectRatio: 0.6, // Adjust this for proper text spacing
          ),
          itemCount: categories.length,
          itemBuilder: (context, index) {
            return CategoryItem(category: categories[index]);
          },
        ),
      ],
    );
  }

  static final List<CategoryData> categories = [
    CategoryData(
      title: 'MoroStick\nPLUS',
      imageUrl:
          'https://pub-77ec04db39ef4d8bb8dc21139a0e97e1.r2.dev/stickers/TestStickers/pngwing.com%20(2).png',
      backgroundColor: const Color(0xFF7E57C2),
      hasPlus: true,
    ),
    CategoryData(
      title: 'Love',
      imageUrl:
          'https://pub-77ec04db39ef4d8bb8dc21139a0e97e1.r2.dev/stickers/TestStickers/newtest%20(10).png',
      backgroundColor: const Color(0xFFFFB7C5),
    ),
    CategoryData(
      title: 'Meme',
      imageUrl:
          'https://pub-77ec04db39ef4d8bb8dc21139a0e97e1.r2.dev/stickers/TestStickers/newtest%20(9).png',
      backgroundColor: const Color(0xFFFFDAD3),
    ),
    CategoryData(
      title: 'Cat',
      imageUrl:
          'https://pub-77ec04db39ef4d8bb8dc21139a0e97e1.r2.dev/stickers/TestStickers/pngwing.com.png',
      backgroundColor: const Color(0xFFFFE4C8),
    ),
    CategoryData(
      title: 'Christmas',
      imageUrl:
          'https://pub-77ec04db39ef4d8bb8dc21139a0e97e1.r2.dev/stickers/TestStickers/newtest%20(7).png',
      backgroundColor: const Color(0xFFE74C3C),
    ),
    CategoryData(
      title: 'Reaction',
      imageUrl:
          'https://pub-77ec04db39ef4d8bb8dc21139a0e97e1.r2.dev/stickers/TestStickers/newtest%20(6).png',
      backgroundColor: const Color(0xFFADD8E6),
    ),
    CategoryData(
      title: 'Cute',
      imageUrl:
          'https://pub-77ec04db39ef4d8bb8dc21139a0e97e1.r2.dev/stickers/TestStickers/newtest%20(5).png',
      backgroundColor: const Color(0xFFB2DFDB),
    ),
    CategoryData(
      title: 'Baby',
      imageUrl:
          'https://pub-77ec04db39ef4d8bb8dc21139a0e97e1.r2.dev/stickers/TestStickers/newtest%20(4).png',
      backgroundColor: const Color(0xFFFFC0CB),
    ),
    CategoryData(
      title: 'Emoji\nIphone',
      imageUrl:
          'https://pub-77ec04db39ef4d8bb8dc21139a0e97e1.r2.dev/stickers/TestStickers/newtest%20(3).png',
      backgroundColor: const Color(0xFFFFB6C1),
    ),
    CategoryData(
      title: 'Crypto',
      imageUrl:
          'https://pub-77ec04db39ef4d8bb8dc21139a0e97e1.r2.dev/stickers/TestStickers/newtest%20(2).png',
      backgroundColor: const Color(0xFF9370DB),
    ),
  ];
}

class CategoryData {
  final String title;
  final String imageUrl;
  final Color backgroundColor;
  final bool hasPlus;

  CategoryData({
    required this.title,
    required this.imageUrl,
    required this.backgroundColor,
    this.hasPlus = false,
  });
}

class CategoryItem extends StatelessWidget {
  final CategoryData category;

  const CategoryItem({
    super.key,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Circle with image
        Stack(
          children: [
            Container(
              width: 60.w,
              height: 60.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: category.backgroundColor,
              ),
              padding: EdgeInsets.all(8.w),
              child: AppCachedImageExtensions.thumbnail(
                imageUrl: category.imageUrl,
              ),
            ),
          ],
        ),
        SizedBox(height: 4.h),
        // Category title
        Text(
          category.title,
          style: TextStyles.font12GrayPurpleRegular.copyWith(
            color: ColorsManager.darkPurple,
          ),
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
