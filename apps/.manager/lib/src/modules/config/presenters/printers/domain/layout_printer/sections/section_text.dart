import 'package:flutter/material.dart';
import 'package:core/core.dart';

import 'package:manager/l10n/l10n_provider.dart';
import 'package:manager/l10n/l10n_service.dart';
import 'package:manager/src/modules/config/presenters/printers/domain/layout_printer/layout_printer.dart';
import 'package:paipfood_package/paipfood_package.dart';

class SectionText extends LayoutPrinter {
  SectionText({
    required super.index,
    required super.style,
    required super.type,
    super.value,
  });
  SectionText.orderNumber({
    required super.index,
    required super.style,
  }) : super(type: SectionType.orderNumber);
  SectionText.orderDate({
    required super.index,
    required super.style,
  }) : super(type: SectionType.orderDate);
  SectionText.orderType({
    required super.index,
    required super.style,
  }) : super(type: SectionType.orderType);
  SectionText.sheduling({
    required super.index,
    required super.style,
    required bool isReverse,
  }) : super(type: SectionType.sheduling);
  SectionText.freeText({
    required super.index,
    required super.style,
    required super.value,
  }) : super(type: SectionType.freeText);
  SectionText.customerPhone({
    required super.index,
    required super.style,
  }) : super(type: SectionType.customerPhone);
  SectionText.deliveryAddress({
    required super.index,
    required super.style,
  }) : super(type: SectionType.deliveryAddress);
  SectionText.customerName({
    required super.index,
    required super.style,
  }) : super(type: SectionType.customerName);
  SectionText.subtotal({
    required super.index,
    required super.style,
  }) : super(type: SectionType.subtotal);
  SectionText.total({
    required super.index,
    required super.style,
  }) : super(type: SectionType.total);
  SectionText.changeTo({
    required super.index,
    required super.style,
  }) : super(type: SectionType.changeTo);
  factory SectionText.empty() {
    return SectionText(index: 0, style: LayoutPrinterStyle.empty(), type: SectionType.orderNumber);
  }

  SectionText.paymentMethod({required super.index, required super.style}) : super(type: SectionType.paymentMethod);
  SectionText.totals({required super.index, required super.style}) : super(type: SectionType.totals);

  SectionText.table({required super.index, required super.style}) : super(type: SectionType.table);

  TextStyle get textStyle => TextStyle(
        fontSize: this.style!.fontSize,
        fontWeight: this.style!.fontWeight,
        color: this.style!.fontColor,
      );

  final dateFormat = DateFormat("dd/MM/yyyy HH:mm");

  @override
  Widget build(BuildContext context, {OrderModel? order, int? tableNumber}) {
    if (order != null) {
      return switch (type) {
        SectionType.orderNumber => buildSection('${l10n.pedido} ${order.getOrderNumber}'.toUpperCase()),
        SectionType.orderDate => buildSection(dateFormat.format(order.createdAt ?? DateTime.now())),
        SectionType.orderType => buildSection(l10n.byString(order.orderType!.i18nText)),
        SectionType.sheduling => !order.isScheduling ? const SizedBox.shrink() : buildSection('${l10n.agendado}\n${order.scheduleDate!.pFactoryCountryFormatDDMMYYYYHHmm()}'.toUpperCase()),
        SectionType.paymentMethod => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              buildSection(order.paymentType?.name.toUpperCase() ?? ''),
              if (order.isPaid) buildSection(l10n.pago),
            ],
          ),
        SectionType.totals => buildSection(order.paymentType!.name.toUpperCase()),
        SectionType.table => tableNumber == null ? SizedBox.shrink() : buildSection('${l10n.mesa}: $tableNumber'.toUpperCase()),
        SectionType.freeText => value.isEmpty ? SizedBox.shrink() : buildSection(value),
        SectionType.customerPhone => order.customer.phone.isEmpty ? SizedBox.shrink() : buildSection(order.customer.phone),
        SectionType.customerName => buildSection(order.customer.name),
        SectionType.deliveryAddress => order.orderType == OrderTypeEnum.delivery ? buildSection(order.customer.address?.formattedAddress(LocaleNotifier.instance.locale) ?? '') : SizedBox.shrink(),
        SectionType.subtotal => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildRowKeyValue(key: l10n.subtotal, value: order.subTotal.toStringAsFixed(2)),
              if (order.deliveryTax > 0) _buildRowKeyValue(key: l10n.taxaEntrega, value: "+ ${order.deliveryTax.toStringAsFixed(2)}"),
              if (order.discount > 0) _buildRowKeyValue(key: l10n.desconto, value: "- ${order.discount.toStringAsFixed(2)}")
            ],
          ),
        SectionType.total => _buildRowKeyValue(key: l10n.total, value: order.getAmount.toStringAsFixed(2)),
        SectionType.changeTo => (order.paymentType == PaymentType.cash && order.changeTo > order.getAmount) ? _buildRowKeyValue(key: '${l10n.trocop.toUpperCase()}  ${order.changeTo.toStringAsFixed(0)}  |', value: order.getChange.toStringAsFixed(2)) : SizedBox.shrink(),
        _ => const Text(''),
      };
    }

    return Text('Undefined');
  }

  Widget _buildRowKeyValue({required String key, required String value}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          this.style!.buildUpperCaseCondition(key),
          style: TextStyle(fontSize: this.style!.fontSize, fontWeight: this.style!.fontWeight, color: Colors.black),
          textAlign: TextAlign.start,
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(fontSize: this.style!.fontSize, fontWeight: this.style!.fontWeight, color: Colors.black),
            textAlign: TextAlign.end,
          ),
        ),
      ],
    );
  }

  Widget buildSection(String value) {
    if (this.style!.isReverse) {
      return Container(
        width: double.infinity,
        color: Colors.black,
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: Text(
            this.style!.buildUpperCaseCondition(value),
            textAlign: this.style!.textAlign,
            style: textStyle.copyWith(color: Colors.white, letterSpacing: 1),
          ),
        ),
      );
    }

    return SizedBox(
        width: double.infinity,
        child: Text(
          this.style!.buildUpperCaseCondition(value),
          style: textStyle,
          textAlign: this.style!.textAlign,
        ));
  }

  @override
  LayoutPrinter fromMap(Map<String, dynamic> map) {
    return SectionText(
      index: map['index'],
      style: LayoutPrinterStyle.fromMap(map['style']),
      type: SectionType.fromMap(map['type']),
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      "index": index,
      "style": this.style?.toMap(),
      "type": type.name,
    };
  }

  @override
  LayoutPrinter copyWith({int? index, SectionType? type, LayoutPrinterStyle? style, String? value}) {
    return SectionText(
      index: index ?? this.index,
      type: type ?? this.type,
      style: style ?? this.style,
      value: value ?? this.value,
    );
  }
}
