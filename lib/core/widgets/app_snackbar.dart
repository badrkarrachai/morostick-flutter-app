import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:morostick/core/theming/colors.dart';
import 'package:morostick/core/theming/images.dart';
import 'package:morostick/core/theming/text_styles.dart';
import 'package:morostick/morostick_app.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Future<void> showAppSnackbar({
  IconData? icon,
  String? title,
  String? description,
  int? duration,
  Color? color,
}) async {
  final overlayEntry = OverlayEntry(
    builder: (context) => Positioned(
      top: 58.0.h,
      left: _getHorizontalPadding(context),
      width: MediaQuery.of(navigatorKey.currentContext!).size.width * 0.96,
      child: CustomToast(
        iconAlert: icon,
        duration: duration,
        title: title ?? "Error",
        message: description ?? "Something went wrong. Please try again later.",
        color: color,
      ),
    ),
  );

  navigatorKey.currentState!.overlay!.insert(overlayEntry);
}

double _getHorizontalPadding(BuildContext context) {
  final width = MediaQuery.of(context).size.width;
  return (width - width * 0.96) / 2;
}

class CustomToast extends StatefulWidget {
  final IconData? iconAlert;
  final String title;
  final String message;
  final int? duration;
  final Color? color;

  const CustomToast({
    super.key,
    required this.iconAlert,
    required this.title,
    required this.message,
    this.duration,
    this.color,
  });

  @override
  State<CustomToast> createState() => _CustomToastState();
}

class _CustomToastState extends State<CustomToast>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _opacityAnimation;
  late final Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
    _opacityAnimation = Tween(begin: 0.0, end: 1.0).animate(_controller);
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, -1),
      end: const Offset(0, 0),
    ).animate(_controller);

    _controller.forward();
    _scheduleDismissal();
  }

  void _scheduleDismissal() {
    Future.delayed(Duration(seconds: widget.duration ?? 5), () {
      if (mounted) {
        _controller.reverse();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) => Opacity(
        opacity: _opacityAnimation.value,
        child: SlideTransition(
          position: _slideAnimation,
          child: child,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: _buildDismissibleContainer(),
      ),
    );
  }

  Widget _buildDismissibleContainer() {
    return Dismissible(
      key: UniqueKey(),
      direction: DismissDirection.up,
      onDismissed: (_) => _controller.reverse(),
      child: _buildToastContainer(),
    );
  }

  Widget _buildToastContainer() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(13.0),
        boxShadow: [
          BoxShadow(
            color: ColorsManager.darkPurple.withOpacity(0.20),
            spreadRadius: 0,
            offset: const Offset(0, -4),
            blurRadius: 30,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          Padding(
            padding: const EdgeInsets.only(left: 45.0, right: 30, top: 4),
            child: Text(
              widget.message,
              style: TextStyles.font12GrayPurpleRegular,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Container(
            padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 6.w),
            decoration: BoxDecoration(
                color: widget.color?.withOpacity(0.2) ??
                    Colors.amber.withOpacity(0.2),
                borderRadius: BorderRadius.circular(62.0)),
            child: Icon(widget.iconAlert ?? HugeIcons.strokeRoundedAlert02,
                size: 20, color: widget.color ?? Colors.amber)),
        const SizedBox(width: 13.0),
        Expanded(
          child: Text(
            widget.title,
            style: TextStyles.font14DarkPurpleSemiBold,
          ),
        ),
        const SizedBox(width: 10.0),
        _buildCloseButton(),
      ],
    );
  }

  Widget _buildCloseButton() {
    return Container(
      width: 25,
      height: 25,
      decoration: const BoxDecoration(
        color: Color.fromRGBO(244, 245, 247, 1),
        shape: BoxShape.circle,
      ),
      child: IconButton(
        onPressed: () => _controller.reverse(),
        icon: SvgPicture.asset(
          Images.closeBtn,
          colorFilter: const ColorFilter.mode(
            Color.fromRGBO(143, 149, 159, 1),
            BlendMode.srcIn,
          ),
        ),
      ),
    );
  }
}
