import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:morostick/core/theming/images.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MessagingDudImage extends StatelessWidget {
  const MessagingDudImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SvgPicture.asset(
          Images.messagingDudOnBoarding,
          width: 250.w,
          height: 250.h,
        ),
      ],
    );
  }
}
