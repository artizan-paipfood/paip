import 'package:core/core.dart';
import 'package:manager/src/modules/config/presenters/printers/domain/layout_printer/layout_printer.dart';
import 'package:manager/src/modules/config/presenters/printers/domain/layout_printer/sections/section_cart.dart';
import 'package:manager/src/modules/config/presenters/printers/domain/layout_printer/sections/section_spacer.dart';
import 'package:manager/src/modules/config/presenters/printers/domain/layout_printer/sections/section_text.dart';

extension LayoutPrinterEntityExtension on PrinterLayoutEntity {
  bool get isDefault => name == 'default' || name == 'default_kitchen';
}

class LayoutPrinterDto {
  final PrinterLayoutEntity layoutPrinter;
  final List<LayoutPrinter> sections;
  LayoutPrinterDto({
    required this.layoutPrinter,
    required this.sections,
  });

  PrinterLayoutEntity toEntity() {
    final map = layoutPrinter.toMap();
    map['sections'] = sections.map((s) => s.toMap()).toList();
    return PrinterLayoutEntity.fromMap(map);
  }

  factory LayoutPrinterDto.fromLayoutPrinterEnity(PrinterLayoutEntity layoutPrinter) {
    return LayoutPrinterDto(
      layoutPrinter: layoutPrinter,
      sections: layoutPrinter.sections.map((map) {
        final type = SectionType.fromMap(map['type']);
        final style = map['style'] != null ? LayoutPrinterStyle.fromMap(map['style']) : null;
        final index = map['index'];
        final value = map['value'] ?? '';
        return switch (type.type) {
          TypeSection.cart => SectionCart(index: index, style: style, sectionCartStyle: SectionCartStyle.fromLayoutPrinterStyle(style!), value: value),
          TypeSection.spacer => SectionSpacer(index: index, type: type, value: value),
          TypeSection.text => SectionText(index: index, style: style, type: type, value: value)
        };
      }).toList(),
    );
  }

  LayoutPrinterDto copyWith({
    PrinterLayoutEntity? layoutPrinter,
    List<LayoutPrinter>? sections,
  }) {
    return LayoutPrinterDto(
      layoutPrinter: layoutPrinter ?? this.layoutPrinter,
      sections: sections ?? this.sections,
    );
  }
}
