import 'dart:convert';

enum PaipPrinterType {
  bluetooth,
  usb,
  network;

  static PaipPrinterType fromMap(String value) =>
      PaipPrinterType.values.firstWhere((element) => element.name == value, orElse: () => PaipPrinterType.usb);
}

class PrinterDto {
  final String id;
  final String name;
  final PrinterEntity printer;
  final bool enable;
  final int qtyCopy;
  final bool leftHandedDriver;
  final bool beep;
  final bool is80mm;
  final int numberColumns;
  final String layoutPrinter;
  final bool mirror;
  final double textScale;
  PrinterDto({
    required this.id,
    required this.name,
    required this.printer,
    this.enable = true,
    this.qtyCopy = 1,
    this.leftHandedDriver = false,
    this.beep = false,
    this.is80mm = true,
    this.numberColumns = 55,
    this.layoutPrinter = 'default',
    this.mirror = false,
    this.textScale = 1.5,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'printer': printer.toMap(),
      'enable': enable,
      'qtyCopy': qtyCopy,
      'leftHandedDriver': leftHandedDriver,
      'beep': beep,
      'is80mm': is80mm,
      'numberColumns': numberColumns,
      'layoutPrinter': layoutPrinter,
      'mirror': mirror,
      'textScale': textScale
    };
  }

  factory PrinterDto.fromMap(Map map) {
    return PrinterDto(
      id: map['id'],
      name: map['name'],
      printer: PrinterEntity.fromMap(map['printer']),
      enable: map['enable'] ?? false,
      qtyCopy: map['qtyCopy']?.toInt() ?? 0,
      leftHandedDriver: map['leftHandedDriver'] ?? false,
      beep: map['beep'] ?? false,
      is80mm: map['is80mm'] ?? false,
      numberColumns: map['numberColumns']?.toInt() ?? 0,
      layoutPrinter: map['layoutPrinter'] ?? 'default',
      mirror: map['mirror'] ?? false,
      textScale: map['textScale'] ?? 1.5,
    );
  }

  String toJson() => json.encode(toMap());

  factory PrinterDto.fromJson(String source) => PrinterDto.fromMap(json.decode(source));

  List<int> getColumns() => List.generate(60, (index) => index + 11).toList();

  int buildWidthByNumberColumns() => numberColumns * 10;

  PrinterDto copyWith({
    String? id,
    String? name,
    PrinterEntity? printer,
    bool? enable,
    int? qtyCopy,
    bool? leftHandedDriver,
    bool? beep,
    bool? is80mm,
    int? numberColumns,
    String? layoutPrinter,
    bool? mirror,
    double? textScale,
  }) {
    return PrinterDto(
      id: id ?? this.id,
      name: name ?? this.name,
      printer: printer ?? this.printer,
      enable: enable ?? this.enable,
      qtyCopy: qtyCopy ?? this.qtyCopy,
      leftHandedDriver: leftHandedDriver ?? this.leftHandedDriver,
      beep: beep ?? this.beep,
      is80mm: is80mm ?? this.is80mm,
      numberColumns: numberColumns ?? this.numberColumns,
      layoutPrinter: layoutPrinter ?? this.layoutPrinter,
      mirror: mirror ?? this.mirror,
      textScale: textScale ?? this.textScale,
    );
  }
}

class PrinterEntity {
  final String name;
  final String? vendorId;
  final String? productId;
  final String? address;
  final PaipPrinterType printerType;
  final String? ip;
  final String? port;
  final bool isConnected;
  const PrinterEntity({
    required this.printerType,
    this.name = '',
    this.vendorId,
    this.productId,
    this.address,
    this.ip,
    this.port = '9100',
    this.isConnected = false,
  });

  static String box = 'printer_model';

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'vendor_id': vendorId,
      'product_id': productId,
      'address': address,
      'printer_type': printerType.name,
      'ip': ip,
      'port': port,
    };
  }

  factory PrinterEntity.fromMap(Map map) {
    return PrinterEntity(
      name: map['name'] ?? '',
      vendorId: map['vendor_id'],
      productId: map['product_id'],
      address: map['address'],
      printerType: PaipPrinterType.fromMap(map['printer_type']),
      ip: map['ip'],
      port: map['port'] ?? '9100',
      isConnected: map['is_connected'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory PrinterEntity.fromJson(String source) => PrinterEntity.fromMap(json.decode(source));

  PrinterEntity copyWith({
    String? name,
    String? vendorId,
    String? productId,
    String? address,
    PaipPrinterType? printerType,
    String? ip,
    String? port,
    bool? isConnected,
  }) {
    return PrinterEntity(
      name: name ?? this.name,
      vendorId: vendorId ?? this.vendorId,
      productId: productId ?? this.productId,
      address: address ?? this.address,
      printerType: printerType ?? this.printerType,
      ip: ip ?? this.ip,
      port: port ?? this.port,
      isConnected: isConnected ?? this.isConnected,
    );
  }
}
