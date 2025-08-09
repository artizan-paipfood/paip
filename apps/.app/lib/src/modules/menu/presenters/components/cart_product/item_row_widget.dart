import 'package:flutter/material.dart';
import 'package:app/src/modules/menu/presenters/components/cart_product/increment_item_cart_button.dart';
import 'package:app/src/modules/menu/presenters/components/cart_product/increment_unique_cart_product_button.dart';
import 'package:app/src/modules/menu/presenters/components/cart_product/price_widget.dart';
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
    return Material(
      color: context.color.primaryBG,
      child: InkWell(
        onTap: widget.onincremet,
        child: Padding(
          padding: PSize.ii.paddingHorizontal,
          child: Ink(
            decoration: BoxDecoration(
                color: context.color.primaryBG,
                border: Border(
                  bottom: BorderSide(color: widget.isDivider ? Colors.transparent : context.color.secondaryText.withOpacity(0.2)),
                )),
            child: Padding(
              padding: PSize.i.paddingVertical,
              child: Row(
                children: [
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.name, style: context.textTheme.titleMedium?.copyWith(color: context.color.neutral900)),
                      if (widget.description.isNotEmpty)
                        Text(
                          widget.description,
                          style: context.textTheme.bodyMedium?.muted(context),
                        ),
                      widget.priceWidget,
                    ],
                  )),
                  if (widget.isMultiple)
                    IncrementItemCartButton(
                      qty: widget.qty,
                      onIncrement: widget.onincremet ?? () {},
                      onDecrement: widget.onDecrement ?? () {},
                    ),
                  if (!widget.isMultiple) IncrementUniqueCartProductButton(qty: widget.qty, onTap: widget.onincremet),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
