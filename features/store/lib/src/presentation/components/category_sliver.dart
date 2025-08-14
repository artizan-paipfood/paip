import 'package:core/core.dart';
import 'package:core_flutter/core_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:store/src/presentation/components/card_product.dart';
import 'package:store/src/presentation/components/price.dart';
import 'package:ui/ui.dart';

class CategorySliver extends StatelessWidget {
  final CategoryEntity category;
  final List<ProductEntity> products;
  final GlobalKey? sliverKey;
  final Function(ProductEntity) onProductTap;
  const CategorySliver({required this.category, required this.products, required this.onProductTap, this.sliverKey, super.key});

  @override
  Widget build(BuildContext context) {
    return SliverStickyHeader(
      key: sliverKey,
      header: Container(
        height: 50,
        color: context.artColorScheme.muted,
        child: Padding(
          padding: PSize.iv.paddingHorizontal,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(category.name.toUpperCase(), style: context.textTheme.titleMedium),
          ),
        ),
      ),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            final product = products[index];
            return CardProduct(product: product, onProductTap: onProductTap);
          },
          childCount: products.length,
        ),
      ),
    );
  }
}
