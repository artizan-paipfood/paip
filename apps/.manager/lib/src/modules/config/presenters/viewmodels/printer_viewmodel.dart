import 'package:flutter/foundation.dart';
import 'package:manager/src/core/stores/layout_printer_store.dart';
import 'package:manager/src/core/services/printer/printer_dto.dart';
import 'package:manager/src/modules/config/aplication/usecases/printer_usecase.dart';
import 'package:paipfood_package/paipfood_package.dart';

class PrinterViewmodel extends ChangeNotifier {
  final PrinterUsecase printerUsecase;

  PrinterViewmodel({
    required this.printerUsecase,
  }) {
    load();
  }

  final Map<String, PrinterDto> _printers = {};
  List<PrinterDto> get printers => _printers.values.toList();
  List<PrinterDto> get printersInUse => printers.where((p) => p.enable).toList();

  List<int> qtys = [1, 2, 3, 4];

  @override
  void dispose() {
    // Limpa todas as conexões ao fechar o viewmodel
    for (final printer in _printers.values) {
      if (printer.printer.printerType == PaipPrinterType.bluetooth) {
        printerUsecase.disconnectPrinter(printer.printer);
      }
    }
    super.dispose();
  }

  Future<Status> load() async {
    final result = await printerUsecase.getAll();
    for (final printer in result) {
      if (printer.printer.printerType == PaipPrinterType.bluetooth) {
        final connected = await printerUsecase.connectPrinter(printer.printer);
        _printers[printer.id] = printer.copyWith(printer: printer.printer.copyWith(isConnected: connected));
      } else {
        _printers[printer.id] = printer;
      }
      notifyListeners();
    }
    return Status.complete;
  }

  Future<void> savePrinter(final PrinterDto printer) async {
    _printers[printer.id] = printer;
    await printerUsecase.save(printer);
    notifyListeners();
  }

  Future<void> addPrinter() async {
    final printer = PrinterDto(id: uuid, name: 'Printer ${_printers.length + 1}', printer: PrinterEntity(printerType: PaipPrinterType.usb));
    _printers[printer.id] = printer;
    await savePrinter(printer);
    notifyListeners();
  }

  Future<void> onEditPrinter(final PrinterDto printer) async {
    _printers[printer.id] = printer;
    await savePrinter(printer);
    notifyListeners();
  }

  Future<void> removePrinter(final String id) async {
    final printer = _printers[id];
    if (printer != null && printer.printer.printerType == PaipPrinterType.bluetooth) {
      await printerUsecase.disconnectPrinter(printer.printer);
    }
    _printers.remove(id);
    await printerUsecase.delete(id);
    notifyListeners();
  }

  Future<List<PrinterEntity>> getPrinters(PaipPrinterType printerType) async {
    return await printerUsecase.getPrinters(printerType);
  }

  Future<void> printOrder({required OrderModel order}) async {
    for (final dto in printersInUse) {
      final layout = LayoutPrinterStore.instance.getByName(dto.layoutPrinter);
      final bytes = await printerUsecase.buildBytesByOrder(order: order, printerDto: dto, layoutPrinterDto: layout);
      await printerUsecase.print(bytes: bytes, printer: dto.printer, qty: dto.qtyCopy);
    }
  }

  Future<void> printUnique({required OrderModel order, required PrinterDto printerDto}) async {
    final layout = LayoutPrinterStore.instance.getByName(printerDto.layoutPrinter);
    final bytes = await printerUsecase.buildBytesByOrder(order: order, printerDto: printerDto, layoutPrinterDto: layout);
    await printerUsecase.print(bytes: bytes, printer: printerDto.printer, qty: 1);
  }

  Future<void> downloadDriver() async {
    await printerUsecase.downloadDriver();
  }

  Future<void> deletePrinter(PrinterDto printer) async {
    if (printer.printer.printerType == PaipPrinterType.bluetooth) {
      await printerUsecase.disconnectPrinter(printer.printer);
    }
    await printerUsecase.delete(printer.id);
    _printers.remove(printer.id);
    notifyListeners();
  }
}
