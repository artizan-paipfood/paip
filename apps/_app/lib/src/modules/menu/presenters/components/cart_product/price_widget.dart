import 'package:flutter/material.dart';
import 'package:app/l10n/l18n_extension.dart';
import 'package:paipfood_package/paipfood_package.dart';

class PriceWidget extends StatelessWidget {
  final double price;
  final double? promotionalPrice;
  final double? priceFrom;
  final TextStyle? textStyle;
  final Color? colorText;
  const PriceWidget({required this.price, super.key, this.promotionalPrice, this.priceFrom, this.textStyle, this.colorText});

  @override
  Widget build(BuildContext context) {
    if (priceFrom != null) {
      return SizedBox(child: Text("${context.i18n.aPartirDe} ${priceFrom!.toStringCurrency}", style: textStyle ?? context.textTheme.bodyLarge?.copyWith(color: colorText), overflow: TextOverflow.ellipsis));
    }
    if (price == 0 && priceFrom == null) {
      return Text("", style: textStyle ?? context.textTheme.bodyLarge?.copyWith(color: colorText));
    }
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Visibility(
          visible: (promotionalPrice ?? 0) > 0.1,
          child: Padding(
            padding: const EdgeInsets.only(right: 8),
            child: DecoratedBox(
              decoration: BoxDecoration(color: context.color.tertiaryColor.withOpacity(1), borderRadius: 0.5.borderRadiusAll),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Text(
                  price.toStringCurrency,
                  style: textStyle?.copyWith(decoration: TextDecoration.lineThrough, color: PColors.neutral_.get1000, decorationColor: PColors.neutral_.get1000) ??
                      context.textTheme.bodyLarge?.copyWith(decoration: TextDecoration.lineThrough, color: PColors.neutral_.get1000, decorationColor: PColors.neutral_.get1000),
                ),
              ),
            ),
          ),
        ),
        Text((promotionalPrice ?? 0) > 0.1 ? promotionalPrice!.toStringCurrency : price.toStringCurrency, style: textStyle ?? context.textTheme.bodyLarge?.copyWith(color: colorText)),
      ],
    );
  }
}
