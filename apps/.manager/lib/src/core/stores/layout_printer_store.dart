import 'package:flutter/material.dart';
import 'package:core/core.dart';
import 'package:manager/src/modules/config/presenters/printers/domain/layout_printer/layout_printer.dart';
import 'package:manager/src/modules/config/presenters/printers/domain/layout_printer/layout_printer_dto.dart';
import 'package:manager/src/modules/config/presenters/printers/domain/layout_printer/sections/section_cart.dart';
import 'package:manager/src/modules/config/presenters/printers/domain/layout_printer/sections/section_spacer.dart';
import 'package:manager/src/modules/config/presenters/printers/domain/layout_printer/sections/section_text.dart';

class LayoutPrinterStore extends ChangeNotifier {
  static LayoutPrinterStore? _instance;
  // Avoid self instance
  LayoutPrinterStore._();
  static LayoutPrinterStore get instance => _instance ??= LayoutPrinterStore._();

  Map<String, LayoutPrinterDto> _layoutPrinters = {
    'default': defaults.firstWhere((l) => l.layoutPrinter.name == 'default'),
    'default_kitchen': defaults.firstWhere((l) => l.layoutPrinter.name == 'default_kitchen'),
  };

  void addLayouts({required List<LayoutPrinterDto> layouts}) {
    for (final layout in layouts) {
      _layoutPrinters[layout.layoutPrinter.name] = layout;
    }
    notifyListeners();
  }

  void removeLayout({required String name}) {
    _layoutPrinters.remove(name);
    notifyListeners();
  }

  void reload({required List<LayoutPrinterDto> layouts}) {
    _layoutPrinters = {
      'default': defaults.firstWhere((l) => l.layoutPrinter.name == 'default'),
      'default_kitchen': defaults.firstWhere((l) => l.layoutPrinter.name == 'default_kitchen'),
    };
    addLayouts(layouts: layouts);
  }

  List<LayoutPrinterDto> get layoutPrinters => _layoutPrinters.values.toList();

  LayoutPrinterDto getByName(String name) => _layoutPrinters[name] ?? _layoutPrinters['default']!;

  static List<LayoutPrinterDto> get defaults => [
        LayoutPrinterDto(
          layoutPrinter: PrinterLayoutEntity(id: '', establishmentId: '', name: 'default', sections: [], fontFamily: 'roboto'),
          sections: [
            SectionText.orderNumber(
              index: 0,
              style: LayoutPrinterStyle(
                fontSize: 22,
                fontWeight: FontWeight.normal,
                isReverse: false,
                textAlign: TextAlign.center,
                upperCase: true,
              ),
            ),
            SectionSpacer.spacer(index: 1),
            SectionText.orderDate(
              index: 2,
              style: LayoutPrinterStyle(
                fontSize: 22,
                fontWeight: FontWeight.normal,
                isReverse: false,
                textAlign: TextAlign.center,
                upperCase: true,
              ),
            ),

            SectionText.customerName(
              index: 3,
              style: LayoutPrinterStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                isReverse: true,
                textAlign: TextAlign.center,
                upperCase: true,
              ),
            ),
            SectionText.customerPhone(
              index: 4,
              style: LayoutPrinterStyle(
                fontSize: 14,
                fontWeight: FontWeight.normal,
                isReverse: false,
                textAlign: TextAlign.center,
                upperCase: true,
              ),
            ),
            SectionText.orderType(
              index: 5,
              style: LayoutPrinterStyle(
                fontSize: 22,
                fontWeight: FontWeight.normal,
                isReverse: false,
                textAlign: TextAlign.center,
                upperCase: true,
              ),
            ),

            SectionText.deliveryAddress(
              index: 6,
              style: LayoutPrinterStyle(
                fontSize: 16,
                fontWeight: FontWeight.normal,
                isReverse: false,
                textAlign: TextAlign.start,
                upperCase: true,
              ),
            ),
            // ],
            // if (widget.tableNumber != null)
            SectionText.table(index: 7, style: null),
            SectionSpacer.dashed(index: 8),
            SectionText.sheduling(
              index: 9,
              isReverse: true,
              style: LayoutPrinterStyle(
                fontSize: 22,
                fontWeight: FontWeight.normal,
                isReverse: false,
                textAlign: TextAlign.center,
                upperCase: true,
              ),
            ),
            SectionText.freeText(
                index: 10,
                style: LayoutPrinterStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  isReverse: false,
                  textAlign: TextAlign.center,
                  upperCase: true,
                ),
                value: 'Produtos'),
            SectionCart(
              index: 11,
              style: LayoutPrinterStyle(
                fontSize: 22,
                fontWeight: FontWeight.normal,
                isReverse: false,
                textAlign: TextAlign.center,
                upperCase: true,
              ),
              sectionCartStyle: SectionCartStyle.fromLayoutPrinterStyle(LayoutPrinterStyle(
                fontSize: 14,
                fontWeight: FontWeight.normal,
                isReverse: false,
                textAlign: TextAlign.center,
                upperCase: true,
              )),
            ),

            SectionSpacer.dashed(index: 12),
            SectionText.paymentMethod(
              index: 13,
              style: LayoutPrinterStyle(
                fontSize: 22,
                fontWeight: FontWeight.normal,
                isReverse: false,
                textAlign: TextAlign.center,
                upperCase: true,
              ),
            ),
            SectionSpacer.dashed(index: 14),

            SectionText.subtotal(
              index: 15,
              style: LayoutPrinterStyle(
                fontSize: 16,
                fontWeight: FontWeight.normal,
                isReverse: false,
                textAlign: TextAlign.center,
                upperCase: true,
              ),
            ),
            SectionText.total(
              index: 16,
              style: LayoutPrinterStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                isReverse: false,
                textAlign: TextAlign.center,
                upperCase: true,
              ),
            ),
            SectionText.changeTo(
              index: 17,
              style: LayoutPrinterStyle(
                fontSize: 16,
                fontWeight: FontWeight.normal,
                isReverse: false,
                textAlign: TextAlign.center,
                upperCase: true,
              ),
            ),
            SectionSpacer.dashed(index: 18),
            SectionSpacer.spacer(index: 19, value: "40"),
          ],
        ),
        LayoutPrinterDto(
          layoutPrinter: PrinterLayoutEntity(id: '', establishmentId: '', name: 'default_kitchen', sections: [], fontFamily: 'roboto'),
          sections: [
            SectionText.orderNumber(
              index: 0,
              style: LayoutPrinterStyle(
                fontSize: 22,
                fontWeight: FontWeight.normal,
                isReverse: false,
                textAlign: TextAlign.center,
                upperCase: true,
              ),
            ),
            SectionSpacer.spacer(index: 1),
            SectionText.orderDate(
              index: 2,
              style: LayoutPrinterStyle(
                fontSize: 22,
                fontWeight: FontWeight.normal,
                isReverse: false,
                textAlign: TextAlign.center,
                upperCase: true,
              ),
            ),
            SectionText.customerName(
              index: 3,
              style: LayoutPrinterStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                isReverse: true,
                textAlign: TextAlign.center,
                upperCase: true,
              ),
            ),
            SectionText.orderType(
              index: 4,
              style: LayoutPrinterStyle(
                fontSize: 22,
                fontWeight: FontWeight.normal,
                isReverse: false,
                textAlign: TextAlign.center,
                upperCase: true,
              ),
            ),
            SectionText.table(index: 5, style: null),
            SectionSpacer.dashed(index: 6),
            SectionText.sheduling(
              index: 7,
              isReverse: true,
              style: LayoutPrinterStyle(
                fontSize: 22,
                fontWeight: FontWeight.normal,
                isReverse: false,
                textAlign: TextAlign.center,
                upperCase: true,
              ),
            ),
            SectionText.freeText(
                index: 8,
                style: LayoutPrinterStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  isReverse: false,
                  textAlign: TextAlign.center,
                  upperCase: true,
                ),
                value: 'Produtos'),
            SectionCart(
              index: 9,
              style: LayoutPrinterStyle(
                fontSize: 22,
                fontWeight: FontWeight.normal,
                isReverse: false,
                textAlign: TextAlign.center,
                upperCase: true,
              ),
              sectionCartStyle: SectionCartStyle.fromLayoutPrinterStyle(LayoutPrinterStyle(
                fontSize: 14,
                fontWeight: FontWeight.normal,
                isReverse: false,
                textAlign: TextAlign.center,
                upperCase: true,
              )),
            ),
            SectionSpacer.dashed(index: 10),
            SectionText.total(
              index: 11,
              style: LayoutPrinterStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                isReverse: false,
                textAlign: TextAlign.center,
                upperCase: true,
              ),
            ),
            SectionSpacer.dashed(index: 12),
            SectionSpacer.spacer(index: 13, value: "40"),
          ],
        ),
      ];
}
