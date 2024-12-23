import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:morostick/core/helpers/spacing.dart';
import 'package:morostick/core/theming/colors.dart';
import 'package:morostick/core/theming/images.dart';
import 'package:morostick/core/theming/text_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:morostick/core/widgets/app_button.dart';
import 'package:morostick/features/favorites/ui/widgets/type_modal.dart';
import 'package:morostick/features/pack/ui/widgets/creator_info.dart';
import 'package:morostick/features/pack/ui/widgets/pack_app_bar.dart';
import 'package:morostick/features/pack/ui/widgets/pack_header.dart';
import 'package:morostick/features/pack/ui/widgets/sticker_grid.dart';

class PackScreen extends StatefulWidget {
  const PackScreen({super.key});

  @override
  State<PackScreen> createState() => _PackScreenState();
}

class _PackScreenState extends State<PackScreen> {
  final ValueNotifier<bool> _isFavorite = ValueNotifier<bool>(false);
  late List<bool> _favoritedStickers;

  void _toggleFavorite() {
    _isFavorite.value = !_isFavorite.value;
    // Implement favorite logic
  }

  void _handleHide() {
    // Implement hide logic
  }

  void _handleReport() {
    // Implement report logic
  }

  @override
  void dispose() {
    _isFavorite.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    // Initialize all stickers as not favorited
    _favoritedStickers = List.generate(30, (_) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.backgroundLightColor,
      appBar: PackAppBar(
        isFavorite: _isFavorite,
        onFavoriteToggle: _toggleFavorite,
        onHide: _handleHide,
        onReport: _handleReport,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const PackHeader(
                packName: "Awesome Sticker Pack",
                downloads: 125000,
                favorites: 45200,
                mainStickerUrl:
                    "https://pub-77ec04db39ef4d8bb8dc21139a0e97e1.r2.dev/stickers/TestStickers/pngwing.com%20(3).png",
              ),
              CreatorInfo(
                imageUrl:
                    'https://pub-77ec04db39ef4d8bb8dc21139a0e97e1.r2.dev/stickers/TestStickers/Badr2.jpg',
                name: 'Badr Karrachai',
                followers: 320000,
                isVerified: true,
                isFollowing: false,
                onFollowTap: () {
                  // Handle follow/unfollow
                },
                onCreatorTap: () {
                  // Navigate to creator profile
                },
              ),
              verticalSpace(8),

              StickerGrid(
                stickers: List.generate(
                  30,
                  (index) =>
                      'https://pub-77ec04db39ef4d8bb8dc21139a0e97e1.r2.dev/stickers/TestStickers/pngwing.com%20(2).png',
                ),
                favoritedStickers: _favoritedStickers,
                onFavoriteToggle: (index) {
                  setState(() {
                    _favoritedStickers[index] = !_favoritedStickers[index];
                  });
                  // Handle favoriting logic
                },
                showAnimatedIndicator: true,
              ),
              verticalSpace(80), // Space for bottom button
            ],
          ),
        ),
      ),
      bottomSheet: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: AppButton(
          buttonText: 'Add to WhatsApp',
          textStyle: TextStyles.font16WhiteSemiBold,
          onPressed: () => showWhatsAppStickerTypeModal(context),
          borderColor: ColorsManager.whatsappGreen,
          leftIcon: SizedBox(
            width: 23.w,
            height: 23.h,
            child: SvgPicture.asset(Images.whatsappLogo),
          ),
          backgroundColor: ColorsManager.whatsappGreen,
        ),
      ),
    );
  }
}
