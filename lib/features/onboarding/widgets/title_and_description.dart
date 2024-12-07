import 'package:flutter/material.dart';
import 'package:morostick/core/helpers/spacing.dart';
import 'package:morostick/core/theming/text_styles.dart';

class TitleAndDescription extends StatelessWidget {
  const TitleAndDescription({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Best Moroccan Sticker \nCreation & Sharing",
          style: TextStyles.font24SemiBoldBlack,
          textAlign: TextAlign.center,
        ),
        verticalSpace(15),
        Text(
          "This creative tool offers the best Moroccan-\nthemed stickers, designed to help you make \nand share beautiful, personalized creations \nwith ease!",
          style: TextStyles.font14RegularGray,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
