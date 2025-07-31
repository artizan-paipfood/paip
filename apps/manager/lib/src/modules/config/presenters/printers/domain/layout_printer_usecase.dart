import 'package:core/core.dart';
import 'package:manager/src/modules/config/presenters/printers/domain/layout_printer/layout_printer_dto.dart';

class LayoutPrinterUsecase {
  final LayoutPrinterApi api;

  LayoutPrinterUsecase({required this.api});

  Future<LayoutPrinterDto> upsert({required LayoutPrinterDto dto}) async {
    final result = await api.upsert(layoutPrinters: [dto.toEntity()]);
    return LayoutPrinterDto.fromLayoutPrinterEnity(result.first);
  }

  Future<void> delete({required String id}) async {
    await api.delete(id: id);
  }

  Future<List<LayoutPrinterDto>> getByEstablishmentId(String id) async {
    final result = await api.getByEstablishmentId(id: id);
    return result.map((e) => LayoutPrinterDto.fromLayoutPrinterEnity(e)).toList();
  }
}
