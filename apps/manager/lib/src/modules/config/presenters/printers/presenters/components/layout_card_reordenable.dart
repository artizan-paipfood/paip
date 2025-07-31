import 'package:flutter/material.dart';
import 'package:core/core.dart';

import 'package:manager/src/core/stores/orders_store.dart';
import 'package:manager/src/modules/config/presenters/printers/domain/layout_printer/layout_printer.dart';
import 'package:manager/src/modules/config/presenters/printers/domain/layout_printer/sections/section_cart.dart';
import 'package:manager/src/modules/config/presenters/printers/domain/layout_printer/sections/section_spacer.dart';
import 'package:manager/src/modules/config/presenters/printers/domain/layout_printer/sections/section_text.dart';
import 'package:paipfood_package/paipfood_package.dart';

class LayoutCardReordenable extends StatefulWidget {
  final OrderModel order;
  final LayoutPrinter printerLayout;
  final void Function() onRemove;
  final void Function() onSelect;
  final bool isSelected;
  const LayoutCardReordenable({
    required this.order,
    required this.printerLayout,
    required this.onRemove,
    required this.isSelected,
    required this.onSelect,
    super.key,
  });

  @override
  State<LayoutCardReordenable> createState() => _LayoutCardReordenableState();
}

class _LayoutCardReordenableState extends State<LayoutCardReordenable> {
  final style = LayoutPrinterStyle(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    isReverse: false,
    textAlign: TextAlign.center,
    upperCase: true,
  );
  bool _isHover = false;
  bool get _isSelected => _isHover || widget.isSelected;
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: InkWell(
          hoverColor: Colors.transparent,
          onHover: (hover) {
            setState(() {
              _isHover = hover;
            });
          },
          onTap: widget.onSelect,
          child: Ink(
            decoration: BoxDecoration(
              color: Colors.transparent,
              border: Border.all(color: _isSelected ? context.color.primaryColor : context.color.border, width: _isSelected ? 1.5 : 1.5),
              borderRadius: PSize.i.borderRadiusAll,
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ReorderableDragStartListener(index: widget.printerLayout.index, child: const Icon(PaipIcons.dragDropVertical)),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.printerLayout.type.name.toUpperCase(),
                          style: context.textTheme.bodyLarge?.copyWith(color: _isSelected ? context.color.primaryColor : context.color.muted),
                        ),
                        MediaQuery(
                          data: MediaQuery.of(context).copyWith(textScaleFactor: .7),
                          child: ColoredBox(
                              color: Colors.white,
                              child: SizedBox(
                                  width: double.infinity,
                                  child: () {
                                    final type = widget.printerLayout.type;
                                    final index = widget.printerLayout.index;
                                    if (type.type == TypeSection.spacer) {
                                      return Row(
                                        children: [
                                          Expanded(child: SectionSpacer(index: index, type: type).build(context)),
                                          Text(
                                            widget.printerLayout.value,
                                            style: context.textTheme.bodySmall?.copyWith(color: Colors.black),
                                          )
                                        ],
                                      );
                                    }
                                    if (type.type == TypeSection.text) {
                                      return SectionText(index: index, style: widget.printerLayout.style ?? style, type: type).build(context,
                                          order: OrdersStore.instance.orders.last.copyWith(
                                            scheduleDate: DateTime.now().add(
                                              Duration(hours: 2),
                                            ),
                                            paymentType: PaymentType.cash,
                                            changeTo: 200,
                                            deliveryTax: 5,
                                            discount: 12.99,
                                          ),
                                          tableNumber: 3);
                                    }
                                    if (type.type == TypeSection.cart) {
                                      return SectionCart(index: index, style: widget.printerLayout.style ?? style, sectionCartStyle: SectionCartStyle.fromLayoutPrinterStyle(widget.printerLayout.style ?? style))
                                          .build(context, cartProducts: OrdersStore.instance.orders.last.cartProducts);
                                    }
                                    return SizedBox.shrink();
                                  }())),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        widget.onRemove();
                      },
                      icon: Icon(
                        PIcons.strokeRoundedCancel01,
                        size: 18,
                      ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
