import 'package:flutter/material.dart';
import 'package:app/l10n/l18n_extension.dart';

import 'package:paipfood_package/paipfood_package.dart';

class RowDetailsCardOrder extends StatefulWidget {
  final CartProductDto cartProduct;
  final int index;
  const RowDetailsCardOrder({required this.cartProduct, super.key, this.index = 0});

  @override
  State<RowDetailsCardOrder> createState() => _RowDetailsCardOrderState();
}

class _RowDetailsCardOrderState extends State<RowDetailsCardOrder> {
  bool _isExpanded = true;
  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: 0.5.borderRadiusAll,
      color: context.color.onPrimaryBG,
      child: InkWell(
        borderRadius: 0.5.borderRadiusAll,
        onTap: () => setState(() => _isExpanded = !_isExpanded),
        child: Ink(
          decoration: BoxDecoration(borderRadius: 0.5.borderRadiusAll, color: context.color.onPrimaryBG),
          // color: widget.index % 2 != 0
          //     ? context.color.neutral200
          //     : (context.isDarkTheme ? context.color.neutral100.withOpacity(0.4) : context.color.neutral100),
          child: Padding(
            padding: PSize.i.paddingHorizontal + 0.5.paddingVertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(child: Text("${widget.cartProduct.qty} - ${widget.cartProduct.product.name}")),
                    Row(children: [Text(widget.cartProduct.amount.toStringCurrency), PSize.i.sizedBoxW, Visibility.maintain(visible: widget.cartProduct.getComplements().isNotEmpty, child: Icon(_isExpanded ? PIcons.strokeRoundedArrowUp01 : PaipIcons.chevronDown))]),
                  ],
                ),
                Visibility(
                  visible: _isExpanded,
                  child: Column(
                    children: widget.cartProduct
                        .getComplements()
                        .map(
                          (e) => Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(e.name, style: context.textTheme.bodySmall?.copyWith(fontWeight: FontWeight.bold), maxLines: 1, overflow: TextOverflow.ellipsis),
                              ...widget.cartProduct
                                  .getItemsCartByComplement(e)
                                  .map((e) => Row(children: [Expanded(child: Text("${e.qty}x ${e.item.name}", style: context.textTheme.bodySmall)), Text(e.price > 0 ? e.price.toStringCurrency : " - ", style: context.textTheme.bodySmall)])),
                            ],
                          ),
                        )
                        .toList(),
                  ),
                ),
                if (widget.cartProduct.observation.isNotEmpty) Text(context.i18n.obs(widget.cartProduct.observation).toUpperCase(), style: context.textTheme.bodySmall?.copyWith(color: context.color.tertiaryColor)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
