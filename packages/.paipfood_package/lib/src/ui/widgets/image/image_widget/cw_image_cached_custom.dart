import 'package:flutter/material.dart';

import 'package:paipfood_package/paipfood_package.dart';

class CwImageCachedCustom extends StatefulWidget {
  final double width;
  final double heidth;
  final String? pathImage;
  final String? secondaryPath;
  final double iconEmptySize;
  final String cacheKey;
  const CwImageCachedCustom({
    required this.cacheKey,
    super.key,
    this.width = 0.0,
    this.heidth = 0.0,
    this.pathImage,
    this.iconEmptySize = 20,
    this.secondaryPath,
  });

  @override
  State<CwImageCachedCustom> createState() => _CwImageCachedCustomState();
}

class _CwImageCachedCustomState extends State<CwImageCachedCustom> {
  static String baseUrl = AwsClient.baseUrlAws;

  @override
  Widget build(BuildContext context) {
    if (widget.pathImage == null && widget.secondaryPath == null || widget.pathImage != null && widget.pathImage!.isEmpty) {
      return Container(
        color: context.color.onPrimaryBG,
        width: widget.width,
        height: widget.heidth,
        child: Icon(PIcons.strokeRoundedInformationCircle, size: widget.iconEmptySize),
      );
    }
    return CachedNetworkImage(
      cacheKey: widget.cacheKey,
      key: Key(widget.cacheKey),
      imageUrl: widget.pathImage != null ? "$baseUrl/${widget.pathImage}" : widget.secondaryPath!,
      height: widget.heidth,
      width: widget.width,
      fit: BoxFit.cover,
      progressIndicatorBuilder: (context, url, downloadProgress) => CircularProgressIndicator(value: downloadProgress.progress),
      errorWidget: (context, url, error) => const Icon(Icons.error),
    );
  }
}
