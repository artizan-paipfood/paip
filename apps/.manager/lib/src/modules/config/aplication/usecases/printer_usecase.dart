import 'dart:io';
import 'package:core/core.dart';
import 'package:manager/l10n/l10n_provider.dart';
import 'package:manager/src/core/stores/bills_store.dart';
import 'package:manager/src/core/services/printer/printer_dto.dart';
import 'package:manager/src/core/services/printer/printer_service.dart';
import 'package:manager/src/modules/config/presenters/printers/domain/layout_printer/layout_printer_dto.dart';
import 'package:manager/src/modules/config/presenters/printers/domain/layout_printer/ui_order_print.dart';
import 'package:manager/src/modules/order/presenter/components/render_image_order.dart';
import 'package:paipfood_package/paipfood_package.dart';
import 'package:thermal_printer_flutter/thermal_printer_flutter.dart';

class PrinterUsecase {
  final ILocalStorage localStorage;
  final PrinterService service;
  final IClient client;

  PrinterUsecase({required this.localStorage, required this.service, required this.client});

  static const String box = 'paip_manager_printers';

  Future<List<PrinterDto>> getAll() async {
    final data = await localStorage.getAll(box);
    if (data == null || data.isEmpty) {
      final result = PrinterDto(id: uuid, name: "Default", printer: PrinterEntity(printerType: PaipPrinterType.usb));
      await save(result);
      return [result];
    }

    return data.entries.map((e) => PrinterDto.fromMap(e.value)).toList();
  }

  Future<void> save(PrinterDto printer) async {
    await localStorage.put(box, key: printer.id, value: printer.toMap());
  }

  Future<bool> connectPrinter(PrinterEntity printer) async {
    final result = await service.connect(printer);
    return result;
  }

  Future<void> disconnectPrinter(PrinterEntity printer) async {
    await service.disconnect(printer);
  }

  Future<void> delete(String id) async {
    await localStorage.delete(box, keys: [id]);
  }

  Future<List<PrinterEntity>> getPrinters(PaipPrinterType printerType) async {
    final result = service.getPrinters(printerType: printerType);
    return result;
  }

  Future<void> print({required List<int> bytes, required PrinterEntity printer, required int qty}) async {
    await service.sendPrint(printer: printer, qty: qty, bytes: bytes);
  }

  Future<List<int>> buildBytesByOrder({required OrderModel order, required PrinterDto printerDto, required LayoutPrinterDto layoutPrinterDto}) async {
    final paperSize = printerDto.is80mm ? PaperSize.mm80 : PaperSize.mm58;
    List<int> bytes = [];
    final profile = await CapabilityProfile.load(name: 'XP-N160I');
    final generator = Generator(paperSize, profile);
    bytes += generator.setGlobalCodeTable('CP1252');
    int? tableNumber;
    if (order.billId != null) {
      tableNumber = BillsStore.instance.getBillById(order.billId!)?.tableNumber;
    }

    final image = await renderImageOrder.buildImageOrder(
      textScaleFactor: printerDto.textScale,
      child: UiOrderPrint(order: order, tableNumber: tableNumber, layoutPrinterDto: layoutPrinterDto, numberColumns: printerDto.buildWidthByNumberColumns().toDouble()),
      numberColumns: printerDto.buildWidthByNumberColumns(),
      mirror: printerDto.mirror,
    );
    bytes += generator.imageRaster(image);
    bytes += generator.feed(2);
    if (printerDto.beep) bytes += generator.beep();
    bytes += generator.cut();
    bytes += generator.reset();

    return bytes;
  }

  Future<void> downloadDriver() async {
    const urlDownload = "https://pub-7c0db3798d624e8c8167096d1efe9bb0.r2.dev/printer_driver_win.exe";
    const fileName = "printer_driver_win.exe";
    final dirDownloads = await getDownloadsDirectory();
    final String outputPath = '${dirDownloads!.path}/$fileName';

    final installer = File(outputPath);
    if (await installer.exists()) {
      await installer.delete();
    }
    toast.showSucess(l10nProiver.iniciandoDownload);
    await client.download(urlDownload, savePath: outputPath);

    toast.showInfo(l10nProiver.downloadDriverImpressoraConcluido);
    final process = await Process.start(outputPath, []);
    await process.exitCode;
    await File(outputPath).delete();
  }
}
