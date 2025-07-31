import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:core/core.dart';

import 'package:manager/src/core/stores/orders_store.dart';
import 'package:manager/src/modules/config/presenters/printers/domain/layout_printer/layout_printer.dart';
import 'package:manager/src/modules/config/presenters/printers/domain/layout_printer/sections/section_cart.dart';
import 'package:manager/src/modules/config/presenters/printers/domain/layout_printer/sections/section_spacer.dart';
import 'package:manager/src/modules/config/presenters/printers/domain/layout_printer/sections/section_text.dart';
import 'package:paipfood_package/paipfood_package.dart';

class LayoutDialogAdd extends StatefulWidget {
  final void Function(LayoutPrinter layout) onSelected;
  const LayoutDialogAdd({
    required this.onSelected,
    super.key,
  });

  @override
  State<LayoutDialogAdd> createState() => _LayoutDialogAddState();
}

class _LayoutDialogAddState extends State<LayoutDialogAdd> {
  final style = LayoutPrinterStyle(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    isReverse: false,
    textAlign: TextAlign.center,
    upperCase: true,
  );
  @override
  Widget build(BuildContext context) {
    return CwDialog(
      title: Text('Escolha uma seção'),
      content: SizedBox(
        width: MediaQuery.of(context).size.width * 0.95,
        height: MediaQuery.of(context).size.height * 0.95,
        child: MasonryGridView.count(
          crossAxisCount: MediaQuery.sizeOf(context).width * 0.8 ~/ 320,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          itemCount: SectionType.values.length,
          itemBuilder: (context, index) {
            final type = SectionType.values[index];
            if (type.type == TypeSection.spacer) {
              return CardLayoutAdd(
                onSelected: () {
                  widget.onSelected(SectionSpacer(index: index, type: type));
                },
                type: type,
                child: SectionSpacer(index: index, type: type).build(context),
              );
            }
            if (type.type == TypeSection.text) {
              return CardLayoutAdd(
                type: type,
                onSelected: () {
                  widget.onSelected(SectionText(index: index, style: style, type: type));
                },
                child: SectionText(index: index, style: style, type: type).build(context,
                    order: OrdersStore.instance.orders.last.copyWith(
                      scheduleDate: DateTime.now().add(
                        Duration(hours: 2),
                      ),
                      paymentType: PaymentType.cash,
                      changeTo: 200,
                      deliveryTax: 5,
                      discount: 12.99,
                    ),
                    tableNumber: 3),
              );
            }
            if (type.type == TypeSection.cart) {
              return CardLayoutAdd(
                type: type,
                onSelected: () {
                  widget.onSelected(SectionCart(index: index, style: style, sectionCartStyle: SectionCartStyle.fromLayoutPrinterStyle(style)));
                },
                child: SectionCart(index: index, style: style, sectionCartStyle: SectionCartStyle.fromLayoutPrinterStyle(style)).build(context, cartProducts: OrdersStore.instance.orders.last.cartProducts),
              );
            }
            return SizedBox.shrink();
          },
        ),
      ),
    );
  }
}

class CardLayoutAdd extends StatefulWidget {
  final SectionType type;
  final Widget child;
  final void Function() onSelected;

  const CardLayoutAdd({
    required this.type,
    required this.child,
    required this.onSelected,
    super.key,
  });

  @override
  State<CardLayoutAdd> createState() => _CardLayoutAddState();
}

class _CardLayoutAddState extends State<CardLayoutAdd> {
  bool _isHover = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      hoverColor: Colors.transparent,
      onHover: (hover) {
        setState(() {
          _isHover = hover;
        });
      },
      onTap: widget.onSelected,
      child: Ink(
          decoration: BoxDecoration(
            border: Border.all(color: _isHover ? context.color.primaryColor : context.color.border, width: _isHover ? 1.5 : 1.5),
            borderRadius: PSize.i.borderRadiusAll,
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.type.name.toUpperCase(),
                  style: context.textTheme.bodyLarge?.copyWith(color: _isHover ? context.color.primaryColor : context.color.muted),
                ),
                ColoredBox(color: Colors.white, child: SizedBox(width: double.infinity, child: widget.child)),
              ],
            ),
          )),
    );
  }
}
