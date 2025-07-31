import 'package:flutter/material.dart';
import 'package:manager/l10n/i18n_extension.dart';
import 'package:manager/src/modules/order/aplication/stores/order_store.dart';
import 'package:manager/src/modules/order/presenter/components/card_order.dart';
import 'package:paipfood_package/paipfood_package.dart';

class ListOrders extends StatefulWidget {
  final OrderStore store;
  final List<OrderModel> orders;
  final Color color;
  final String label;
  final bool isExpanded;

  const ListOrders({required this.store, required this.orders, required this.color, required this.label, this.isExpanded = false, super.key});

  @override
  State<ListOrders> createState() => _ListOrdersState();
}

class _ListOrdersState extends State<ListOrders> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(border: Border(left: widget.isExpanded ? BorderSide.none : BorderSide(color: context.color.neutral300, width: 2))),
      width: 370,
      child: Column(
        children: [
          Text(widget.label.toUpperCase()),
          PSize.i.sizedBoxH,
          if (widget.orders.isEmpty) CwEmptyState(size: 150, icon: PaipIcons.dropBox, bgColor: false, label: context.i18n.descEmptyStatePedido),
          Expanded(
            child: ListView.builder(
              itemCount: widget.orders.length,
              itemBuilder: (context, index) {
                final OrderModel order = widget.orders[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8, right: 8, left: 8),
                  child: CardOrder(order: order, color: widget.color, index: index, store: widget.store, isExpanded: widget.isExpanded, driver: widget.store.getDriver(order), bill: widget.store.getBill(order)),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
