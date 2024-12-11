import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class AppCachedNetworkImage extends StatelessWidget {
  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final BorderRadius? borderRadius;
  final Border? border;
  final Widget Function(BuildContext, String)? placeholderBuilder;
  final Widget Function(BuildContext, String, dynamic)? errorBuilder;
  final Color? shimmerBaseColor;
  final Color? shimmerHighlightColor;
  final Duration? fadeInDuration;
  final BoxShape shape;
  final bool useOldImageOnUrlChange;
  final VoidCallback? onLoadStart;
  final void Function(ImageProvider<Object> imageProvider)? onLoadComplete;
  final void Function()? onError;
  final Color? backgroundColor;
  final BlendMode? colorBlendMode;
  final FilterQuality? filterQuality;
  final bool? gaplessPlayback;
  final int? memCacheWidth;
  final int? memCacheHeight;
  final String? cacheKey;
  final int? maxWidthDiskCache;
  final int? maxHeightDiskCache;
  final Widget? loadingOverlay;
  final Alignment? alignment;
  final ImageRepeat? repeat;
  final bool? matchTextDirection;
  final double? scale;
  final Color? color;
  final double? opacity;

  const AppCachedNetworkImage({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.fit,
    this.borderRadius,
    this.border,
    this.placeholderBuilder,
    this.errorBuilder,
    this.shimmerBaseColor,
    this.shimmerHighlightColor,
    this.fadeInDuration,
    this.shape = BoxShape.rectangle,
    this.useOldImageOnUrlChange = true,
    this.onLoadStart,
    this.onLoadComplete,
    this.onError,
    this.backgroundColor,
    this.colorBlendMode,
    this.filterQuality,
    this.gaplessPlayback,
    this.memCacheWidth,
    this.memCacheHeight,
    this.cacheKey,
    this.maxWidthDiskCache,
    this.maxHeightDiskCache,
    this.loadingOverlay,
    this.alignment,
    this.repeat,
    this.matchTextDirection,
    this.scale,
    this.color,
    this.opacity,
  });

  @override
  Widget build(BuildContext context) {
    Widget imageWidget = CachedNetworkImage(
      imageUrl: imageUrl,
      width: width,
      height: height,
      fit: fit ?? BoxFit.contain,
      placeholder: (context, url) =>
          placeholderBuilder?.call(context, url) ?? _buildDefaultShimmer(),
      errorWidget: (context, url, error) =>
          errorBuilder?.call(context, url, error) ?? _buildDefaultError(),
      fadeInDuration: fadeInDuration ?? const Duration(milliseconds: 500),
      useOldImageOnUrlChange: useOldImageOnUrlChange,
      progressIndicatorBuilder: loadingOverlay != null
          ? (context, url, progress) => Stack(
                children: [
                  _buildDefaultShimmer(),
                  Center(child: loadingOverlay!),
                ],
              )
          : null,
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: imageProvider,
            fit: fit ?? BoxFit.contain,
            alignment: alignment ?? Alignment.center,
            repeat: repeat ?? ImageRepeat.noRepeat,
            scale: scale ?? 1.0,
            opacity: opacity ?? 1.0,
            colorFilter: color != null && colorBlendMode != null
                ? ColorFilter.mode(color!, colorBlendMode!)
                : null,
          ),
        ),
      ),
      cacheKey: cacheKey,
      maxWidthDiskCache: maxWidthDiskCache,
      maxHeightDiskCache: maxHeightDiskCache,
      memCacheWidth: memCacheWidth,
      memCacheHeight: memCacheHeight,
      filterQuality: filterQuality ?? FilterQuality.low,
      alignment: alignment ?? Alignment.center,
      repeat: repeat ?? ImageRepeat.noRepeat,
      matchTextDirection: matchTextDirection ?? false,
      color: color,
      colorBlendMode: colorBlendMode,
      key: key,
    );

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
        border: border,
        borderRadius: shape == BoxShape.circle ? null : borderRadius,
        color: backgroundColor,
      ),
      child: imageWidget,
    );
  }

  Widget _buildDefaultShimmer() {
    return Shimmer.fromColors(
      baseColor: shimmerBaseColor ?? Colors.grey[300]!,
      highlightColor: shimmerHighlightColor ?? Colors.grey[100]!,
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

  Widget _buildDefaultError() {
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
}

// Extension for commonly used configurations
extension AppCachedImageExtensions on AppCachedNetworkImage {
  static AppCachedNetworkImage circle({
    required String imageUrl,
    required double size,
    BorderRadius? borderRadius,
    Border? border,
    Color? backgroundColor,
  }) {
    return AppCachedNetworkImage(
      imageUrl: imageUrl,
      width: size,
      height: size,
      shape: BoxShape.circle,
      borderRadius: borderRadius,
      border: border,
      backgroundColor: backgroundColor,
    );
  }

  static AppCachedNetworkImage avatar({
    required String imageUrl,
    double size = 40,
    Border? border,
  }) {
    return circle(
      imageUrl: imageUrl,
      size: size,
      border: border ?? Border.all(color: Colors.transparent, width: 1),
      backgroundColor: Colors.transparent,
    );
  }

  static AppCachedNetworkImage thumbnail({
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
      memCacheWidth: 300,
      filterQuality: FilterQuality.low,
    );
  }
}
