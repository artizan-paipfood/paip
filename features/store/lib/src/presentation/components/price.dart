import 'package:core_flutter/core_flutter.dart';
import 'package:flutter/material.dart';
import 'package:store/src/_i18n/gen/strings.g.dart';
import 'package:ui/ui.dart';

class PriceLabel extends StatefulWidget {
  final double price;
  final double? promotionalPrice;
  final double? priceFrom;
  const PriceLabel({
    required this.price,
    super.key,
    this.promotionalPrice,
    this.priceFrom,
  });

  @override
  State<PriceLabel> createState() => _PriceLabelState();
}

class _PriceLabelState extends State<PriceLabel> {
  TextStyle? get _relativeTextStyle => context.textTheme.labelMedium?.copyWith(color: context.artColorScheme.foreground, fontWeight: FontWeight.w600);
  @override
  Widget build(BuildContext context) {
    if (widget.priceFrom != null) {
      return SizedBox(
        child: Text(
          t.a_partir_de(price: widget.priceFrom!.toCurrency()).toUpperCase(),
          overflow: TextOverflow.ellipsis,
          style: _relativeTextStyle,
        ),
      );
    }
    if (widget.price == 0 && widget.priceFrom == null) {
      return Text("", style: _relativeTextStyle);
    }
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Visibility(
          visible: (widget.promotionalPrice ?? 0) > 0.1,
          child: Padding(
            padding: const EdgeInsets.only(right: 8),
            child: ArtBadge(
              backgroundColor: Colors.amber,
              child: Text(widget.price.toCurrency().toUpperCase(),
                  style: _relativeTextStyle?.copyWith(
                    decoration: TextDecoration.lineThrough,
                    color: context.artColorScheme.foreground,
                    decorationColor: context.artColorScheme.foreground,
                  )),
            ),
          ),
        ),
        Text(
          ((widget.promotionalPrice ?? 0) > 0.1 ? widget.promotionalPrice!.toCurrency() : widget.price.toCurrency()).toUpperCase(),
          style: _relativeTextStyle,
        ),
      ],
    );
  }
}
