import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class AppCachedNetworkImage extends StatelessWidget {
  static final _defaultShimmerBaseColor = Colors.grey[300]!;
  static final _defaultShimmerHighlightColor = Colors.grey[100]!;

  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final BorderRadius? borderRadius;
  final BoxShape shape;
  final Color? backgroundColor;

  // Progressive loading settings
  final bool enableProgressiveLoading;
  final Duration fadeInDuration;
  final bool useBlurHash;
  final Widget? errorWidget;

  const AppCachedNetworkImage({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.fit,
    this.borderRadius,
    this.shape = BoxShape.rectangle,
    this.backgroundColor,
    this.enableProgressiveLoading = true,
    this.fadeInDuration = const Duration(milliseconds: 300),
    this.useBlurHash = true,
    this.errorWidget,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        Widget imageWidget = CachedNetworkImage(
          imageUrl: imageUrl,
          width: width,
          height: height,
          fit: fit ?? BoxFit.contain,
          fadeInDuration: fadeInDuration,
          filterQuality: FilterQuality.medium,
          progressIndicatorBuilder: (context, url, progress) =>
              _buildProgressiveLoading(progress),
          errorWidget: (context, url, error) =>
              errorWidget ?? _buildErrorWidget(),
        );

        // Apply shape clipping if needed
        if (shape == BoxShape.circle) {
          imageWidget = ClipOval(child: imageWidget);
        } else if (borderRadius != null) {
          imageWidget = ClipRRect(
            borderRadius: borderRadius!,
            child: imageWidget,
          );
        }

        return Container(
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: shape == BoxShape.rectangle ? borderRadius : null,
          ),
          child: imageWidget,
        );
      },
    );
  }

  Widget _buildLoadingPlaceholder() {
    return Shimmer.fromColors(
      baseColor: _defaultShimmerBaseColor,
      highlightColor: _defaultShimmerHighlightColor,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: borderRadius,
          shape: shape,
        ),
      ),
    );
  }

  Widget _buildProgressiveLoading(DownloadProgress progress) {
    return Stack(
      alignment: Alignment.center,
      children: [
        _buildLoadingPlaceholder(),
        if (progress.progress != null)
          CircularProgressIndicator(
            value: progress.progress,
            strokeWidth: 2,
            backgroundColor: Colors.white.withValues(alpha: 0.2),
          ),
      ],
    );
  }

  Widget _buildErrorWidget() {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: borderRadius,
        shape: shape,
      ),
      child: Icon(
        Icons.error_outline,
        color: Colors.grey[400],
        size: (width ?? 24) * 0.5,
      ),
    );
  }

  // Convenience constructors for common use cases
  static Widget avatar({
    required String imageUrl,
    double size = 40,
    Color? backgroundColor,
  }) {
    return AppCachedNetworkImage(
      imageUrl: imageUrl,
      width: size,
      height: size,
      shape: BoxShape.circle,
      backgroundColor: backgroundColor,
      enableProgressiveLoading: false,
      fadeInDuration: const Duration(milliseconds: 200),
    );
  }

  static Widget thumbnail({
    required String imageUrl,
    double? width,
    double? height,
    BorderRadius? borderRadius,
  }) {
    return AppCachedNetworkImage(
      imageUrl: imageUrl,
      width: width,
      height: height,
      fit: BoxFit.contain,
      borderRadius: borderRadius ?? BorderRadius.circular(8.r),
      enableProgressiveLoading: true,
    );
  }
}
