import 'package:core_flutter/core_flutter.dart';
import 'package:flutter/material.dart';

class PaipCachedNetworkImage extends StatelessWidget {
  final String imageUrl;
  final String? cacheKey;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final PlaceholderWidgetBuilder? placeholder;
  final LoadingErrorWidgetBuilder? errorWidget;
  final BorderRadius? borderRadius;
  final BoxDecoration? decoration;
  final VoidCallback? onTap;
  final bool showLoadingIndicator;

  const PaipCachedNetworkImage({
    required this.imageUrl,
    super.key,
    this.width,
    this.height,
    this.fit,
    this.placeholder,
    this.errorWidget,
    this.borderRadius,
    this.decoration,
    this.cacheKey,
    this.onTap,
    this.showLoadingIndicator = true,
  });

  @override
  Widget build(BuildContext context) {
    Widget imageWidget = CachedNetworkImage(
      imageUrl: imageUrl,
      width: width,
      height: height,
      cacheKey: cacheKey,
      fit: fit ?? BoxFit.cover,
      placeholder: placeholder ?? (showLoadingIndicator ? _buildDefaultPlaceholder : null),
      errorWidget: errorWidget ?? _buildDefaultErrorWidget,
    );

    if (borderRadius != null || decoration != null) {
      imageWidget = Container(
        width: width,
        height: height,
        decoration: decoration ?? BoxDecoration(borderRadius: borderRadius),
        clipBehavior: borderRadius != null ? Clip.antiAliasWithSaveLayer : Clip.none,
        child: imageWidget,
      );
    }

    if (onTap != null) {
      imageWidget = GestureDetector(onTap: onTap, child: imageWidget);
    }

    return imageWidget;
  }

  Widget _buildDefaultPlaceholder(BuildContext context, String url) {
    return Container(
      width: width,
      height: height,
      color: Colors.grey[300],
      child: const Center(
        child: CircularProgressIndicator(
          strokeCap: StrokeCap.round,
        ),
      ),
    );
  }

  Widget _buildDefaultErrorWidget(BuildContext context, String url, Object error) {
    return Image.asset(
      'assets/images/image-placeholder.png',
      package: 'ui',
      width: width,
      height: height,
      fit: fit ?? BoxFit.cover,
    );
  }
}
