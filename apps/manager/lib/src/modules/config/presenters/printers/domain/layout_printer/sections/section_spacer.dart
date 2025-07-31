import 'package:flutter/material.dart';

import 'package:manager/src/modules/config/presenters/printers/domain/layout_printer/layout_printer.dart';
import 'package:paipfood_package/paipfood_package.dart' hide Path;

class SectionSpacer extends LayoutPrinter {
  SectionSpacer({required super.index, required super.type, super.value});
  SectionSpacer.dashed({required super.index}) : super(type: SectionType.divider);
  SectionSpacer.spacer({required super.index, super.value}) : super(type: SectionType.spacer);

  factory SectionSpacer.empty() {
    return SectionSpacer(index: 0, type: SectionType.spacer);
  }

  @override
  Widget build(BuildContext context) {
    final result = switch (type) {
      SectionType.divider => fullWidthPath,
      SectionType.spacer => SizedBox(
          height: value.isNotEmpty ? (double.tryParse(value) ?? 4) : 4,
        ),
      _ => const Text('undefined'),
    };
    return result;
  }

  Widget get fullWidthPath {
    return DottedBorder(
        strokeWidth: 1.2,
        dashPattern: const [10, 2],
        customPath: (size) {
          return Path()
            ..moveTo(0, 5)
            ..lineTo(size.width, 5);
        },
        child: const SizedBox(
          height: 5,
          width: double.infinity,
        ));
  }

  @override
  Map<String, dynamic> toMap() {
    return {'index': index, 'type': type.name};
  }

  @override
  LayoutPrinter fromMap(Map<String, dynamic> map) {
    return SectionSpacer(
      index: map['index'] ?? 0,
      type: SectionType.fromMap(map['type']),
    );
  }

  @override
  LayoutPrinter copyWith({int? index, SectionType? type, LayoutPrinterStyle? style, String? value}) {
    return SectionSpacer(
      index: index ?? this.index,
      type: type ?? this.type,
      value: value ?? this.value,
    );
  }
}
