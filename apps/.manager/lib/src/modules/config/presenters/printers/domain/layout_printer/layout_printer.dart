import 'dart:convert';

import 'package:flutter/material.dart';

enum TypeSection {
  cart,
  spacer,
  text;
}

enum SectionType {
  spacer(TypeSection.spacer),
  divider(TypeSection.spacer),
  cart(TypeSection.cart),
  orderNumber(TypeSection.text),
  customerName(TypeSection.text),
  customerPhone(TypeSection.text),
  deliveryAddress(TypeSection.text),
  orderDate(TypeSection.text),
  orderType(TypeSection.text),
  sheduling(TypeSection.text),
  paymentMethod(TypeSection.text),
  totals(TypeSection.text),
  table(TypeSection.text),
  freeText(TypeSection.text),
  subtotal(TypeSection.text),
  total(TypeSection.text),
  changeTo(TypeSection.text),
  ;

  final TypeSection type;

  const SectionType(this.type);

  static SectionType fromMap(String value) =>
      SectionType.values.firstWhere((element) => element.name == value, orElse: () => SectionType.orderNumber);
}

abstract class LayoutPrinter {
  final int index;
  final SectionType type;
  final LayoutPrinterStyle? style;
  final String value;
  LayoutPrinter({required this.index, required this.type, this.value = '', this.style});
  Widget build(BuildContext context);
  Map<String, dynamic> toMap() {
    return {
      'index': index,
      'type': type.name,
      'style': style?.toMap(),
      'value': value,
    };
  }

  LayoutPrinter fromMap(Map<String, dynamic> map);

  LayoutPrinter copyWith({
    int? index,
    SectionType? type,
    LayoutPrinterStyle? style,
    String? value,
  });
}

class LayoutPrinterStyle {
  final double fontSize;
  final FontWeight fontWeight;
  final bool isReverse;
  final TextAlign textAlign;
  final bool upperCase;
  LayoutPrinterStyle({
    required this.fontSize,
    required this.fontWeight,
    required this.isReverse,
    required this.textAlign,
    required this.upperCase,
  });
  Color get fontColor => isReverse ? Colors.white : Colors.black;
  Color get backGroundColor => isReverse ? Colors.black : Colors.white;

  factory LayoutPrinterStyle.empty() {
    return LayoutPrinterStyle(
      fontSize: 0,
      fontWeight: FontWeight.normal,
      isReverse: false,
      textAlign: TextAlign.center,
      upperCase: true,
    );
  }

  LayoutPrinterStyle copyWith({
    double? fontSize,
    FontWeight? fontWeight,
    bool? isReverse,
    TextAlign? textAlign,
    bool? upperCase,
  }) {
    return LayoutPrinterStyle(
      fontSize: fontSize ?? this.fontSize,
      fontWeight: fontWeight ?? this.fontWeight,
      isReverse: isReverse ?? this.isReverse,
      textAlign: textAlign ?? this.textAlign,
      upperCase: upperCase ?? this.upperCase,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'font_size': fontSize,
      'font_weight': fontWeight.value,
      'is_reverse': isReverse,
      'text_align': textAlign.name,
      'upper_case': upperCase,
    };
  }

  factory LayoutPrinterStyle.fromMap(Map<String, dynamic> map) {
    return LayoutPrinterStyle(
        fontSize: map['font_size']?.toDouble() ?? 0.0,
        fontWeight: map['font_weight'] != null
            ? FontWeight.values.firstWhere((f) => f.value == map['font_weight'], orElse: () => FontWeight.normal)
            : FontWeight.normal,
        isReverse: map['is_reverse'] ?? false,
        textAlign: map['text_align'] != null
            ? TextAlign.values.firstWhere(
                (ta) => ta.name == map['text_align'],
                orElse: () => TextAlign.center,
              )
            : TextAlign.center,
        upperCase: map['upper_case'] ?? true);
  }

  String toJson() => json.encode(toMap());

  factory LayoutPrinterStyle.fromJson(String source) => LayoutPrinterStyle.fromMap(json.decode(source));

  String buildUpperCaseCondition(String value) {
    if (upperCase) return value.toUpperCase();
    return value;
  }
}

class CarSectionStyle {
  final double fontSizeProduct;
  final double fontSizeComplement;
  final double fontSizeItem;
  final FontWeight fontWeightProduct;
  final FontWeight fontWeightComplement;
  final FontWeight fontWeightItem;
  CarSectionStyle({
    required this.fontSizeProduct,
    required this.fontSizeComplement,
    required this.fontSizeItem,
    required this.fontWeightProduct,
    required this.fontWeightComplement,
    required this.fontWeightItem,
  });
}
