import 'package:core/core.dart';
import 'package:core/src/helpers/base_options.dart';
import 'package:core/src/helpers/env.dart';
import 'package:test/test.dart';
import 'package:uuid/uuid.dart';

void main() {
  late IClient client;

  late LayoutPrinterApi api;

  setUp(() async {
    await Env.initializeForTest(envFilePath: 'test.env');
    client = ClientDio(baseOptions: PaipBaseOptions.supabase);
    api = LayoutPrinterApi(client: client);
  });

  String establishmentId = '';
  group(
    'CRUD LAYOUT-PRINTERS',
    () {
      final layoutPrinter = PrinterLayoutEntity(
        id: Uuid().v4(),
        establishmentId: establishmentId,
        name: 'test',
        fontFamily: 'roboto',
        sections: [
          {
            "oi": "teste",
          },
        ],
      );
      test(
        'UPSERT',
        () async {
          //Arrange

          //Act
          final result = await api.upsert(
            layoutPrinters: [
              layoutPrinter,
            ],
          );
          //Assert
          expect(
            result,
            isA<List<PrinterLayoutEntity>>(),
          );
        },
      );
      test(
        'GET BY ESTABLISHMENT',
        () async {
          //Arrange

          //Act
          final result = await api.getByEstablishmentId(
            id: establishmentId,
          );
          //Assert
          expect(
            result,
            isA<List<PrinterLayoutEntity>>(),
          );
        },
      );
      test(
        'DELETE',
        () async {
          //Arrange

          //Act
          await api.delete(
            id: layoutPrinter.id,
          );
          //Assert
        },
      );
    },
  );
}
