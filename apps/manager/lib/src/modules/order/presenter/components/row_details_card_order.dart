import 'package:flutter/material.dart';

import 'package:paipfood_package/paipfood_package.dart';

class RowDetailsCardOrder extends StatefulWidget {
  final CartProductDto cartProduct;
  final int index;
  final bool showIconExpand;
  final bool enableBorder;
  const RowDetailsCardOrder({
    required this.cartProduct,
    super.key,
    this.index = 0,
    this.showIconExpand = true,
    this.enableBorder = false,
  });

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
        onTap: widget.showIconExpand ? () => setState(() => _isExpanded = !_isExpanded) : null,
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: 0.5.borderRadiusAll,
            color: context.color.onPrimaryBG,
            border: widget.enableBorder ? Border.all(color: context.color.border) : null,
          ),
          child: Padding(
            padding: PSize.i.paddingHorizontal + 0.5.paddingVertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(child: Text("${widget.cartProduct.qty} - ${widget.cartProduct.product.name}")),
                    Row(
                      children: [
                        Text(widget.cartProduct.amount.toStringCurrency),
                        if (widget.showIconExpand)
                          Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: Visibility(
                              visible: widget.cartProduct.getComplements().isNotEmpty,
                              child: Icon(_isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down),
                            ),
                          ),
                      ],
                    )
                  ],
                ),
                Visibility(
                  visible: _isExpanded,
                  child: Column(
                    children: widget.cartProduct
                        .getComplements()
                        .map((e) => Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(" ${e.name}",
                                    style: context.textTheme.bodySmall?.copyWith(fontWeight: FontWeight.bold),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis),
                                ...widget.cartProduct
                                    .getItemsCartByComplement(e)
                                    .map((e) => Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                "  ${e.qty}x ${e.item.name}",
                                                style: context.textTheme.bodySmall,
                                              ),
                                            ),
                                            Text(
                                              e.price > 0 ? e.price.toStringCurrency : " - ",
                                              style: context.textTheme.bodySmall,
                                            ),
                                          ],
                                        ))
                                    
                              ],
                            ))
                        .toList(),
                  ),
                ),
                if (widget.cartProduct.observation.isNotEmpty)
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(color: Colors.orange, borderRadius: 0.3.borderRadiusAll),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      child: Text(
                        "OBS: ${widget.cartProduct.observation}".toUpperCase(),
                        style: context.textTheme.bodySmall?.copyWith(color: context.color.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
