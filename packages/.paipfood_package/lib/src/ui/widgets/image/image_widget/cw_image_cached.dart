import 'package:flutter/material.dart';
import 'package:paipfood_package/paipfood_package.dart';

class CwImageCached extends StatefulWidget {
  final double size;
  final String? pathImage;
  final String cacheKey;
  const CwImageCached({
    required this.cacheKey,
    super.key,
    this.size = 0.0,
    this.pathImage,
  });

  @override
  State<CwImageCached> createState() => _CwImageCachedState();
}

class _CwImageCachedState extends State<CwImageCached> {
  @override
  Widget build(BuildContext context) {
    if (widget.pathImage == null || widget.pathImage!.isEmpty) {
      return Container(
        color: context.color.onPrimaryBG,
        width: widget.size,
        height: widget.size,
        child: Icon(PIcons.strokeRoundedInformationCircle, size: widget.size / 3),
      );
    }
    return CachedNetworkImage(
      cacheKey: widget.cacheKey,
      key: Key(widget.cacheKey),
      imageUrl: widget.pathImage!.buildPublicUriBucket,
      height: widget.size,
      width: widget.size,
      fit: BoxFit.cover,
      progressIndicatorBuilder: (context, url, downloadProgress) => CircularProgressIndicator(value: downloadProgress.progress),
      errorWidget: (context, url, error) => const Icon(Icons.error),
    );
  }
}
