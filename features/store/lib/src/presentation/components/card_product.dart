import 'package:core/core.dart';
import 'package:core_flutter/core_flutter.dart';
import 'package:flutter/material.dart';
import 'package:store/src/presentation/components/price.dart';
import 'package:ui/ui.dart';

class CardProduct extends StatelessWidget {
  final ProductEntity product;
  final Function(ProductEntity product) onProductTap;
  const CardProduct({required this.product, required this.onProductTap, super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      overlayColor: WidgetStateProperty.all(context.artColorScheme.primary.withValues(alpha: 0.2)),
      onTap: () => onProductTap(product),
      child: ConstrainedBox(
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
                    width: 60,
                    height: 60,
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
      ),
    );
  }
}
