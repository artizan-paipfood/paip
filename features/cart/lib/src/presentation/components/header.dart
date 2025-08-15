import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:ui/ui.dart';

class Header extends StatelessWidget {
  final ProductEntity product;
  const Header({required this.product, super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 50),
          child: AspectRatio(
            aspectRatio: 3 / 2,
            child: PaipCachedNetworkImage(
              imageUrl: product.imageThumbPath ?? '',
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
    );
  }
}
