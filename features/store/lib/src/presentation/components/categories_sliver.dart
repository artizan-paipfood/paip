import 'package:core/core.dart';
import 'package:core_flutter/core_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:store/src/presentation/components/price.dart';
import 'package:ui/ui.dart';

class CategorySliver extends StatelessWidget {
  final CategoryEntity category;
  final List<ProductEntity> products;
  final GlobalKey? sliverKey;
  const CategorySliver({required this.category, required this.products, this.sliverKey, super.key});

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
            return ConstrainedBox(
              constraints: const BoxConstraints(
                minHeight: 70,
              ),
              child: Ink(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: context.artColorScheme.muted),
                  ),
                ),
                child: Padding(
                  padding: PSize.spacer.paddingLeft + PSize.iii.paddingRight + PSize.ii.paddingVertical,
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(product.name, style: context.textTheme.labelMedium?.copyWith(color: context.artColorScheme.foreground)),
                            Text(product.description ?? '', style: context.textTheme.labelMedium?.copyWith(color: context.artColorScheme.mutedForeground)),
                            PSize.ii.sizedBoxH,
                            Price(price: product.price ?? 0, promotionalPrice: product.promotionalPrice, priceFrom: product.priceFrom),
                          ],
                        ),
                      ),
                      Material(
                        color: context.artColorScheme.muted,
                        borderRadius: PSize.ii.borderRadiusAll,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: SizedBox(
                          width: 70,
                          height: 70,
                          child: CachedNetworkImage(
                            imageUrl: product.imageThumbPath ?? '',
                            cacheKey: product.imageThumbPath ?? '' 'abstract',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
          childCount: products.length,
        ),
      ),
    );
  }
}
