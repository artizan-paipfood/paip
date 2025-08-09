import 'package:flutter/material.dart';
import 'package:manager/src/modules/menu/presenters/components/price_widget.dart';
import 'package:manager/src/modules/pdv/presenter/components/pdv/cart_product/increment_item_cart_button.dart';
import 'package:manager/src/modules/pdv/presenter/components/pdv/cart_product/increment_unique_cart_product_button.dart';
import 'package:paipfood_package/paipfood_package.dart';

class ItemRowWidget extends StatefulWidget {
  final void Function()? onincremet;
  final void Function()? onDecrement;
  final bool isDivider;
  final String name;
  final String description;
  final PriceWidget priceWidget;
  final bool isMultiple;
  final int qty;

  const ItemRowWidget({
    required this.priceWidget,
    super.key,
    this.onincremet,
    this.onDecrement,
    this.isDivider = false,
    this.name = '',
    this.description = '',
    this.isMultiple = false,
    this.qty = 0,
  });

  @override
  State<ItemRowWidget> createState() => _ItemRowWidgetState();
}

class _ItemRowWidgetState extends State<ItemRowWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: PSize.i.borderRadiusAll,
      onTap: widget.onincremet,
      child: Ink(
        decoration: BoxDecoration(
          color: context.color.primaryBG,
          border: Border.all(color: context.color.border),
          borderRadius: PSize.i.borderRadiusAll,
        ),
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: PSize.i.paddingVertical + PSize.i.paddingLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.name, style: context.textTheme.labelLarge?.copyWith(color: context.color.neutral900)),
                    if (widget.description.isNotEmpty)
                      Text(
                        widget.description,
                        style: context.textTheme.labelSmall,
                      ),
                    widget.priceWidget,
                  ],
                ),
              ),
            ),
            if (widget.isMultiple)
              IncrementItemCartButton(
                qty: widget.qty,
                onIncrement: widget.onincremet ?? () {},
                onDecrement: widget.onDecrement ?? () {},
              ),
            if (!widget.isMultiple)
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: IncrementUniqueCartProductButton(qty: widget.qty),
              ),
          ],
        ),
      ),
    );
  }
}
