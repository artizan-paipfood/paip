import 'package:flutter/material.dart';
import 'package:manager/l10n/l10n_provider.dart';
import 'package:manager/src/modules/config/presenters/printers/domain/layout_printer/layout_printer.dart';
import 'package:manager/src/modules/config/presenters/printers/domain/layout_printer/sections/section_spacer.dart';
import 'package:paipfood_package/paipfood_package.dart';

class SectionCart extends LayoutPrinter {
  final SectionCartStyle sectionCartStyle;
  SectionCart({
    required super.index,
    required super.style,
    required this.sectionCartStyle,
    super.value,
  }) : super(type: SectionType.cart);

  @override
  Widget build(BuildContext context, {List<CartProductDto>? cartProducts}) {
    return CartSectionWidget(section: this, cartProducts: cartProducts ?? []);
  }

  factory SectionCart.empty() {
    return SectionCart(index: 0, style: LayoutPrinterStyle.empty(), sectionCartStyle: SectionCartStyle(fontSizeProduct: 0, fontSizeComplement: 0, fontSizeItem: 0, fontWeightProduct: FontWeight.normal, fontWeightComplement: FontWeight.normal, fontWeightItem: FontWeight.normal));
  }

  @override
  LayoutPrinter fromMap(Map<String, dynamic> map) {
    return SectionCart(index: map['index'], style: LayoutPrinterStyle.fromMap(map['style']), sectionCartStyle: SectionCartStyle.fromLayoutPrinterStyle(LayoutPrinterStyle.fromMap(map['style'])), value: map['value'] ?? '');
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      "index": index,
      "type": type.name,
      "style": this.style!.toMap(),
      "value": value,
    };
  }

  @override
  LayoutPrinter copyWith({int? index, SectionType? type, LayoutPrinterStyle? style, String? value, SectionCartStyle? sectionCartStyle}) {
    return SectionCart(
      index: index ?? this.index,
      style: style ?? this.style,
      sectionCartStyle: this.sectionCartStyle,
      value: value ?? this.value,
    );
  }
}

class SectionCartStyle {
  final double fontSizeProduct;
  final double fontSizeComplement;
  final double fontSizeItem;
  final FontWeight fontWeightProduct;
  final FontWeight fontWeightComplement;
  final FontWeight fontWeightItem;

  SectionCartStyle({required this.fontSizeProduct, required this.fontSizeComplement, required this.fontSizeItem, required this.fontWeightProduct, required this.fontWeightComplement, required this.fontWeightItem});

  factory SectionCartStyle.fromLayoutPrinterStyle(LayoutPrinterStyle style) {
    return SectionCartStyle(
      fontSizeProduct: (style.fontSize + (style.fontSize * 0.25)).floor().toDouble(),
      fontSizeComplement: style.fontSize,
      fontSizeItem: (style.fontSize + (style.fontSize * 0.2)).floor().toDouble(),
      fontWeightProduct: style.fontWeight.multiply(2),
      fontWeightComplement: style.fontWeight.multiply(2),
      fontWeightItem: style.fontWeight,
    );
  }
}

class CartSectionWidget extends StatelessWidget {
  final SectionCart section;
  final List<CartProductDto> cartProducts;
  const CartSectionWidget({
    required this.section,
    required this.cartProducts,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 10),
        ...cartProducts.map((cartProduct) {
          final lenght = cartProducts.length;
          final index = cartProducts.indexOf(cartProduct);
          final bool showDivider = index < (lenght - 1);
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              buildSection(context, cartProduct),
              if (showDivider) SectionSpacer.dashed(index: index).build(context),
            ],
          );
        }),
      ],
    );
  }

  Widget buildSection(BuildContext context, CartProductDto cartProduct) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
                child: Text(
              section.style!.buildUpperCaseCondition("${cartProduct.qty} - ${cartProduct.product.name}"),
              style: TextStyle(fontSize: section.sectionCartStyle.fontSizeProduct, fontWeight: section.sectionCartStyle.fontWeightProduct, color: Colors.black),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            )),
            if (cartProduct.product.price > 0)
              Row(
                children: [
                  Text(section.style!.buildUpperCaseCondition(cartProduct.product.price.toStringAsFixed(2)), style: TextStyle(fontSize: section.sectionCartStyle.fontSizeProduct, fontWeight: section.sectionCartStyle.fontWeightProduct, color: Colors.black)),
                  PSize.i.sizedBoxW,
                ],
              )
          ],
        ),
        if (cartProduct.size != null)
          Text(
            '-> ${section.style!.buildUpperCaseCondition(cartProduct.size!.name)} <-',
            style: TextStyle(fontSize: section.sectionCartStyle.fontSizeComplement, fontWeight: section.sectionCartStyle.fontWeightProduct, color: Colors.black),
          ),
        Column(
          children: cartProduct
              .getComplements()
              .map((complement) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(' ${section.style!.buildUpperCaseCondition(complement.name)}',
                          style: TextStyle(fontSize: section.sectionCartStyle.fontSizeComplement, fontWeight: section.sectionCartStyle.fontWeightComplement, color: Colors.black), maxLines: 1, overflow: TextOverflow.ellipsis),
                      ...cartProduct.getItemsCartByComplement(complement).map((item) => Row(
                            children: [
                              Expanded(
                                child: Text(
                                  () {
                                    if (complement.complementType == ComplementType.pizza) {
                                      if (cartProduct.qtyFlavorsPizza!.qty == 1) return "  ${section.style!.buildUpperCaseCondition(item.item.name)}";
                                      return section.style!.buildUpperCaseCondition("  1/${cartProduct.qtyFlavorsPizza!.qty}  -  ${item.item.name}");
                                    }
                                    return section.style!.buildUpperCaseCondition("  ${item.qty}x ${item.item.name}");
                                  }(),
                                  style: TextStyle(fontSize: section.sectionCartStyle.fontSizeItem, fontWeight: section.sectionCartStyle.fontWeightItem, color: Colors.black),
                                ),
                              ),
                              Text(
                                item.price > 0 ? section.style!.buildUpperCaseCondition("+ ${item.price.toStringAsFixed(2)}") : " - ",
                                style: TextStyle(fontSize: section.sectionCartStyle.fontSizeItem, fontWeight: section.sectionCartStyle.fontWeightItem, color: Colors.black),
                              ),
                            ],
                          ))
                    ],
                  ))
              .toList(),
        ),
        const SizedBox(height: 4),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('  ${l10n.total.toUpperCase()}:', style: TextStyle(fontSize: section.sectionCartStyle.fontSizeComplement, fontWeight: section.sectionCartStyle.fontWeightComplement, color: Colors.black)),
            Text(cartProduct.amount.toStringAsFixed(2), style: TextStyle(fontSize: section.sectionCartStyle.fontSizeComplement, fontWeight: section.sectionCartStyle.fontWeightComplement, color: Colors.black)),
          ],
        ),
        if (cartProduct.observation.isNotEmpty)
          Container(
            decoration: BoxDecoration(
              border: Border.all(width: 2),
            ),
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(4),
              child: Text(
                "OBS: ${cartProduct.observation}".toUpperCase(),
                style: TextStyle(fontSize: section.sectionCartStyle.fontSizeComplement, fontWeight: section.sectionCartStyle.fontWeightComplement, color: Colors.black, letterSpacing: 1),
              ),
            ),
          ),
      ],
    );
  }
}
