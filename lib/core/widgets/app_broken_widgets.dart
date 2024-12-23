import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:morostick/core/theming/colors.dart';
import 'package:morostick/core/theming/images.dart';

SvgPicture brokenPackImage({
  double? width,
  double? height,
  Color? color,
}) {
  return SvgPicture.asset(
    Images.appSvgIcon,
    width: width ?? 65,
    height: height ?? 65,
    colorFilter:
        ColorFilter.mode(color ?? ColorsManager.white, BlendMode.srcIn),
  );
}
