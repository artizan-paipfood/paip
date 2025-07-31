import 'package:flutter/material.dart';
import 'package:manager/src/modules/menu/presenters/components/price_widget.dart';
import 'package:paipfood_package/paipfood_package.dart';

class CardProductGrid extends StatefulWidget {
  final ProductModel product;
  final void Function() onTap;

  const CardProductGrid({
    required this.product,
    required this.onTap,
    super.key,
  });

  @override
  State<CardProductGrid> createState() => _CardProductGridState();
}

class _CardProductGridState extends State<CardProductGrid> {
  bool isHover = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 360,
      child: Material(
        color: context.color.primaryBG,
        borderRadius: PSize.i.borderRadiusAll,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: InkWell(
          hoverColor: context.color.primaryColor,
          onTap: widget.onTap,
          onHover: (value) => setState(() => isHover = value),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Material(
                      borderRadius: PSize.i.borderRadiusAll,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: Hero(
                        tag: widget.product.id,
                        transitionOnUserGestures: true,
                        child: CwImageCached(
                          cacheKey: widget.product.imageCacheId,
                          pathImage: widget.product.image,
                          size: 90,
                        ),
                      ),
                    ),
                    PSize.i.sizedBoxW,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.product.name,
                            style: context.textTheme.titleMedium?.copyWith(
                              color: isHover ? PColors.neutral_.get50 : context.color.primaryText,
                            ),
                            maxLines: 1,
                          ),
                          Text(
                            widget.product.description,
                            maxLines: 2,
                            style: context.textTheme.bodySmall?.copyWith(
                              color: isHover ? PColors.neutral_.get50 : context.color.muted,
                            ),
                          ),
                          PSize.i.sizedBoxH,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              PriceWidget(
                                price: widget.product.price,
                                priceFrom: widget.product.priceFrom,
                                promotionalPrice: widget.product.promotionalPrice,
                                colorText: isHover ? PColors.neutral_.get50 : context.color.primaryText,
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
