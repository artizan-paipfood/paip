import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:core/core.dart';
import 'package:manager/l10n/gen/app_localizations_pt.dart';
import 'package:manager/src/modules/invoices/domain/models/invoice_dialog_model.dart';

class MockEstablishmentInvoiceEntity extends Mock implements EstablishmentInvoiceEntity {}

void main() {
  late InvoiceDialogModel dialogModel;
  late AppLocalizationsPtBr i18n;
  late MockEstablishmentInvoiceEntity invoice;

  setUp(() {
    i18n = AppLocalizationsPtBr();
    invoice = MockEstablishmentInvoiceEntity();
    dialogModel = InvoiceDialogModel(invoice: invoice, i18n: i18n);
  });

  group('invoice.title', () {
    test('deve retornar mensagem de bloqueio quando a fatura estiver bloqueada', () {
      when(() => invoice.isBlocked()).thenReturn(true);

      expect(dialogModel.title, equals(i18n.sistemaBloqueado));
    });

    test('deve retornar mensagem de vencimento quando os dias até o vencimento for 0', () {
      when(() => invoice.isBlocked()).thenReturn(false);
      when(() => invoice.daysUntilDue()).thenReturn(0);

      expect(dialogModel.title, equals(i18n.faturaVencida));
    });

    test('deve retornar mensagem de disponível quando a fatura não estiver bloqueada e não estiver vencida', () {
      when(() => invoice.isBlocked()).thenReturn(false);
      when(() => invoice.daysUntilDue()).thenReturn(5);

      expect(dialogModel.title, equals(i18n.faturaDisponivel));
    });
  });

  group('invoice.description', () {
    test('deve retornar mensagem de bloqueio com data quando a fatura estiver bloqueada', () {
      when(() => invoice.isBlocked()).thenReturn(true);
      when(() => invoice.dueDate).thenReturn(DateTime(2023));

      expect(dialogModel.description, equals(i18n.faturaDescBloqueado('01/01/2023')));
    });

    test('deve retornar mensagem de vencimento com data quando a fatura não estiver bloqueada', () {
      when(() => invoice.isBlocked()).thenReturn(false);
      when(() => invoice.dueDate).thenReturn(DateTime(2023));

      expect(dialogModel.description, equals(i18n.faturaDescVencimento('01/01/2023')));
    });
  });

  group('invoice.cancelNotice', () {
    test('deve retornar null quando a fatura estiver bloqueada', () {
      when(() => invoice.isBlocked()).thenReturn(true);

      expect(dialogModel.cancelNotice, isNull);
    });

    test('deve retornar string vazia quando dias até vencimento for diferente de 0', () {
      when(() => invoice.isBlocked()).thenReturn(false);
      when(() => invoice.daysUntilDue()).thenReturn(5);

      expect(dialogModel.cancelNotice, equals(''));
    });

    test('deve retornar aviso de bloqueio quando dias até bloqueio for maior que 0', () {
      when(() => invoice.isBlocked()).thenReturn(false);
      when(() => invoice.daysUntilDue()).thenReturn(0);
      when(() => invoice.daysUntilBlock()).thenReturn(3);

      expect(dialogModel.cancelNotice, equals(i18n.faturaAvisoBloqueio(3)));
    });

    test('deve retornar null quando dias até bloqueio for 0', () {
      when(() => invoice.isBlocked()).thenReturn(false);
      when(() => invoice.daysUntilDue()).thenReturn(0);
      when(() => invoice.daysUntilBlock()).thenReturn(0);

      expect(dialogModel.cancelNotice, isNull);
    });

    test('deve retornar null quando dias até bloqueio for null', () {
      when(() => invoice.isBlocked()).thenReturn(false);
      when(() => invoice.daysUntilDue()).thenReturn(0);
      when(() => invoice.daysUntilBlock()).thenReturn(null);

      expect(dialogModel.cancelNotice, isNull);
    });
  });
}
