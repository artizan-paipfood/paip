import 'dart:async';
import 'package:core/core.dart';
import 'package:manager/src/core/services/printer/printer_dto.dart';
import 'package:paipfood_package/paipfood_package.dart';
import 'package:thermal_printer_flutter/thermal_printer_flutter.dart';

class PrinterService {
  static PrinterService? _instance;

  final ILocalStorage localStorage;

  final _plugin = ThermalPrinterFlutter();

  final Map<String, bool> _connectionCache = {};

  Timer? _connectionCheckTimer;

  final int _maxReconnectAttempts = 3;

  final Map<String, int> _reconnectAttempts = {};

  bool _isCheckingConnections = false;

  PrinterService._({
    required this.localStorage,
  }) {
    _initializeConnectionCheck();
  }

  static PrinterService getInstance({required ILocalStorage localStorage}) {
    _instance ??= PrinterService._(localStorage: localStorage);
    return _instance!;
  }

  static void reset() {
    _instance?.dispose();
    _instance = null;
  }

  void _initializeConnectionCheck() {
    _connectionCheckTimer?.cancel();

    _connectionCheckTimer = Timer.periodic(const Duration(seconds: 30), (_) {
      if (!_isCheckingConnections) {
        _checkConnections();
      }
    });
  }

  void dispose() {
    _connectionCheckTimer?.cancel();
    _disconnectAll();
  }

  Future<void> _disconnectAll() async {
    for (final address in _connectionCache.keys) {
      await disconnect(PrinterEntity(
        printerType: PaipPrinterType.bluetooth,
        address: address,
      ));
    }
    _connectionCache.clear();
    _reconnectAttempts.clear();
  }

  Future<void> _checkConnections() async {
    if (_isCheckingConnections) return;

    try {
      _isCheckingConnections = true;

      for (final entry in _connectionCache.entries) {
        if (entry.value) {
          final printer = PrinterEntity(
            printerType: PaipPrinterType.bluetooth,
            address: entry.key,
          );

          try {
            await _plugin.printBytes(
              bytes: [0x1B, 0x40],
              printer: Printer(
                type: PrinterType.bluethoot,
                bleAddress: entry.key,
              ),
            );
          } catch (e) {
            // Se falhar, tenta reconectar
            await _reconnectPrinter(printer);
          }
        }
      }
    } finally {
      _isCheckingConnections = false;
    }
  }

  Future<void> _reconnectPrinter(PrinterEntity printer) async {
    if (printer.address == null) return;

    final attempts = _reconnectAttempts[printer.address] ?? 0;
    if (attempts >= _maxReconnectAttempts) {
      _connectionCache[printer.address!] = false;
      _reconnectAttempts.remove(printer.address);
      return;
    }

    _reconnectAttempts[printer.address!] = attempts + 1;

    try {
      final connected = await connect(printer);
      if (connected) {
        _reconnectAttempts.remove(printer.address);
      }
    } catch (e) {
      await Future.delayed(const Duration(seconds: 5));
      await _reconnectPrinter(printer);
    }
  }

  Future<void> disconnect(PrinterEntity printer) async {
    if (printer.printerType == PaipPrinterType.bluetooth && printer.address != null) {
      await _plugin.connect(
        printer: Printer(
          type: PrinterType.bluethoot,
          bleAddress: printer.address!,
        ),
      );
      _connectionCache.remove(printer.address);
      _reconnectAttempts.remove(printer.address);
    }
  }

  Future<List<PrinterEntity>> getPrinters({required PaipPrinterType printerType}) async {
    if (printerType == PaipPrinterType.usb) return _getPrintersUsb();
    if (printerType == PaipPrinterType.bluetooth) return _getPrintersBle();
    return [];
  }

  Future<List<PrinterEntity>> _getPrintersUsb() async {
    final result = await _plugin.getPrinters(printerType: PrinterType.usb);
    return result
        .map((e) => PrinterEntity(
              printerType: PaipPrinterType.usb,
              name: e.name,
            ))
        .toList();
  }

  Future<bool> connect(PrinterEntity printer) async {
    if (printer.printerType == PaipPrinterType.bluetooth && printer.address != null) {
      if (_connectionCache[printer.address] == true) {
        return true;
      }

      final connected = await _plugin.connect(
        printer: Printer(
          type: PrinterType.bluethoot,
          bleAddress: printer.address!,
        ),
      );

      if (connected) {
        _connectionCache[printer.address!] = true;
        _reconnectAttempts.remove(printer.address);
      }
      return connected;
    }
    return false;
  }

  Future<void> _verifyBluetoothSetup() async {
    final bluetoothEnabled = await _plugin.isBluetoothEnabled();
    if (!bluetoothEnabled) throw PrinterServiceException('Bluetooth not enabled', error: PrinterServiceError.bluetoothNotEnabled);
    final havePrinters = await _plugin.checkBluetoothPermissions();
    if (!havePrinters) throw PrinterServiceException('Bluetooth permissions not granted', error: PrinterServiceError.bluetoothPermissionsNotGranted);
  }

  Future<List<PrinterEntity>> _getPrintersBle() async {
    await _verifyBluetoothSetup();
    final result = await _plugin
        .getPrinters(printerType: PrinterType.bluethoot) //
        .timeout(Duration(seconds: 30))
        .catchError((_) => throw PrinterServiceException('Failed to get printers', error: PrinterServiceError.failedToGetPrinters));

    return result
        .map((e) => PrinterEntity(
              printerType: PaipPrinterType.bluetooth,
              name: e.name,
              address: e.bleAddress,
            ))
        .toList();
  }

  Future<PrinterEntity?> getPrinterById(String id) async {
    final req = await localStorage.get(PrinterEntity.box, key: id);
    if (req != null) return PrinterEntity.fromMap(req);
    return null;
  }

  Future<void> savePrinter({
    required PrinterEntity printer,
    required String id,
  }) async {
    await localStorage.put(PrinterEntity.box, key: id, value: printer.toMap());
  }

  Future<void> deletePrinter(String id) async {
    await localStorage.delete(PrinterEntity.box, keys: [id]);
  }

  Future<void> sendPrint({
    required PrinterEntity printer,
    required List<int> bytes,
    required int qty,
  }) async {
    final Printer printer0 = Printer(
      bleAddress: printer.address ?? '',
      type: fromPrinterType(printer.printerType),
      name: printer.name,
      isConnected: printer.isConnected,
      ip: printer.ip ?? '',
      port: printer.port ?? '9100',
    );

    if (printer.printerType == PaipPrinterType.bluetooth && printer.address != null) {
      if (_connectionCache[printer.address] != true) {
        await connect(printer);
      }
    }

    await _sendPrint(printer: printer0, bytes: bytes, qty: qty);
  }

  PrinterType fromPrinterType(PaipPrinterType printerType) {
    return switch (printerType) {
      PaipPrinterType.bluetooth => PrinterType.bluethoot,
      PaipPrinterType.usb => PrinterType.usb,
      PaipPrinterType.network => PrinterType.network,
    };
  }

  Future<void> _sendPrint({required Printer printer, required List<int> bytes, required int qty}) async {
    for (int i = 0; i < qty; i++) {
      await _plugin.printBytes(
        bytes: bytes,
        printer: printer,
      );
    }
  }
}

enum PrinterServiceError {
  bluetoothNotEnabled,
  bluetoothPermissionsNotGranted,
  failedToGetPrinters,
  failedToConnect,
  failedToPrint,
  unknown;
}

class PrinterServiceException extends GenericException {
  final PrinterServiceError error;
  PrinterServiceException(super.message, {required this.error});
}
