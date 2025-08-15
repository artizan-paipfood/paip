import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:ui/ui.dart';

class ComplementSliver extends StatelessWidget {
  final GlobalKey? sliverKey;
  final ComplementEntity complement;
  final List<ItemEntity> items;
  final Function(String complementId, String itemId) onItemIncrement;
  final Function(String complementId, String itemId) onItemDecrement;
  final int? complementQtySelected;
  const ComplementSliver({required this.complement, required this.items, required this.onItemIncrement, required this.onItemDecrement, this.sliverKey, this.complementQtySelected, super.key});

  @override
  Widget build(BuildContext context) {
    return SliverStickyHeader(
      key: sliverKey,
      header: Container(
        height: 50,
        color: context.artColorScheme.muted,
        child: Padding(
          padding: PSize.iv.paddingHorizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(complement.name.toUpperCase(), style: context.textTheme.titleMedium),
              Text(complementQtySelected != null ? '$complementQtySelected/${complement.qtyMax.toInt()}' : complement.qtyMax.toInt().toString()),
            ],
          ),
        ),
      ),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            // final product = products[index];
            return InkWell(
                onTap: () => onItemIncrement(complement.id, items[index].id),
                child: Ink(
                  height: 50,
                  child: Text(items[index].name),
                ));
          },
          childCount: items.length,
        ),
      ),
    );
  }
}
