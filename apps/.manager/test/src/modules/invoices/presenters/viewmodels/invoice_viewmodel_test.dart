import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:core/core.dart';
import 'package:manager/l10n/gen/app_localizations_pt.dart';
import 'package:manager/src/modules/invoices/domain/usecases/invoices_usecase.dart';
import 'package:manager/src/modules/invoices/presenters/viewmodels/invoice_viewmodel.dart';

class MockInvoicesUsecase extends Mock implements InvoicesUsecase {}

void main() {
  setUpAll(() {
    registerFallbackValue(EstablishmentInvoiceEntity(id: 'dummy-id', establishmentId: 'dummy-establishment-id', amount: 0, dueDate: DateTime.now(), createdAt: DateTime.now(), establishmentPlanId: 'dummy-plan-id'));
  });

  late InvoiceViewmodel viewmodel;
  late MockInvoicesUsecase mockUsecase;
  late AppLocalizationsPtBr i18n;

  const testEstablishmentId = 'est-id';
  const testInvoiceId = 'invoice-id';
  const testTransactionId = 'transaction-id';

  setUp(() {
    mockUsecase = MockInvoicesUsecase();
    viewmodel = InvoiceViewmodel(usecase: mockUsecase);
    i18n = AppLocalizationsPtBr();
  });

  group('checkInvoice', () {
    test('deve retornar null quando não houver fatura', () async {
      when(() => mockUsecase.checkInvoice(testEstablishmentId)).thenAnswer((_) async => null);

      final result = await viewmodel.checkInvoice(i18n, establishmentId: testEstablishmentId);
      expect(result, null);
      expect(viewmodel.paymentState, PaymentState.initial);
    });

    test('deve retornar null quando establishmentId for vazio', () async {
      final result = await viewmodel.checkInvoice(i18n, establishmentId: '');
      expect(result, null);
    });

    test('deve retornar dialog model quando fatura estiver bloqueada', () async {
      final invoice = EstablishmentInvoiceEntity(id: testInvoiceId, establishmentId: testEstablishmentId, amount: 100, dueDate: DateTime.now().subtract(const Duration(days: 31)), createdAt: DateTime.now(), establishmentPlanId: 'plan-id');

      when(() => mockUsecase.checkInvoice(testEstablishmentId)).thenAnswer((_) async => invoice);

      final result = await viewmodel.checkInvoice(i18n, establishmentId: testEstablishmentId);
      expect(result, isNotNull);
      expect(viewmodel.isBlocked, true);
    });

    test('deve verificar status de pagamento quando houver transactionId e a fatura não estiver paga', () async {
      final invoice = EstablishmentInvoiceEntity(id: testInvoiceId, establishmentId: testEstablishmentId, amount: 100, dueDate: DateTime.now(), createdAt: DateTime.now(), establishmentPlanId: 'plan-id', transactionId: testTransactionId);

      when(() => mockUsecase.checkInvoice(testEstablishmentId)).thenAnswer((_) async => invoice);
      when(() => mockUsecase.pixPaymentStatus(id: testTransactionId)).thenAnswer((_) async => PaymentStatusResponse(status: PaymentStatus.paid, id: testTransactionId, amount: 100, provider: PaymentProvider.hipay));
      when(() => mockUsecase.upsert(any())).thenAnswer((_) async => invoice.copyWith(paymentDate: DateTime.now()));

      final result = await viewmodel.checkInvoice(i18n, establishmentId: testEstablishmentId);
      expect(result, null);
      expect(viewmodel.paymentState, PaymentState.paid);
    });

    test('deve atualizar estado para failed quando ocorrer erro', () async {
      when(() => mockUsecase.checkInvoice(testEstablishmentId)).thenThrow(Exception('Erro'));

      await viewmodel.checkInvoice(i18n, establishmentId: testEstablishmentId);
      expect(viewmodel.paymentState, PaymentState.failed);
    });
  });

  group('generatePix', () {
    test('deve lançar exceção quando invoice.id for vazio', () {
      final invoice = EstablishmentInvoiceEntity(id: '', establishmentId: testEstablishmentId, amount: 100, dueDate: DateTime.now(), createdAt: DateTime.now(), establishmentPlanId: 'plan-id');

      expect(() => viewmodel.generatePix(invoice: invoice), throwsException);
    });

    test('deve gerar PIX e iniciar verificação de status', () async {
      final invoice = EstablishmentInvoiceEntity(id: testInvoiceId, establishmentId: testEstablishmentId, amount: 100, dueDate: DateTime.now(), createdAt: DateTime.now(), establishmentPlanId: 'plan-id');

      final pixResponse = PixResponse(id: testTransactionId, qrCode: 'qr-code', amount: 100);

      when(() => mockUsecase.generatePix(invoice: invoice)).thenAnswer((_) async => pixResponse);

      final result = await viewmodel.generatePix(invoice: invoice);
      expect(result.id, testTransactionId);
      expect(viewmodel.paymentState, PaymentState.pending);
      expect(viewmodel.paymentDateLimit, isNotNull);
    });

    test('deve atualizar estado para failed quando falhar ao gerar PIX', () async {
      final invoice = EstablishmentInvoiceEntity(id: testInvoiceId, establishmentId: testEstablishmentId, amount: 100, dueDate: DateTime.now(), createdAt: DateTime.now(), establishmentPlanId: 'plan-id');

      when(() => mockUsecase.generatePix(invoice: invoice)).thenThrow(Exception('Erro ao gerar PIX'));

      expect(() => viewmodel.generatePix(invoice: invoice), throwsException);
      expect(viewmodel.paymentState, PaymentState.failed);
    });
  });

  group('_checkPaymentStatus', () {
    test('deve atualizar status quando pagamento for confirmado', () async {
      final invoice = EstablishmentInvoiceEntity(id: testInvoiceId, establishmentId: testEstablishmentId, amount: 100, dueDate: DateTime.now(), createdAt: DateTime.now(), establishmentPlanId: 'plan-id', transactionId: testTransactionId);

      when(() => mockUsecase.pixPaymentStatus(id: testTransactionId)).thenAnswer((_) async => PaymentStatusResponse(status: PaymentStatus.paid, id: testTransactionId, amount: 100, provider: PaymentProvider.hipay));

      when(() => mockUsecase.upsert(any())).thenAnswer((_) async => invoice.copyWith(paymentDate: DateTime.now()));

      await viewmodel.checkPaymentStatus(invoice: invoice);
      await Future.delayed(const Duration(milliseconds: 100));

      expect(viewmodel.paymentState, PaymentState.paid);
      expect(viewmodel.isBlocked, false);
    });

    test('deve atualizar estado para failed após maxRetries', () async {
      final invoice = EstablishmentInvoiceEntity(id: testInvoiceId, establishmentId: testEstablishmentId, amount: 100, dueDate: DateTime.now(), createdAt: DateTime.now(), establishmentPlanId: 'plan-id', transactionId: testTransactionId);

      when(() => mockUsecase.pixPaymentStatus(id: testTransactionId)).thenThrow(Exception('Erro ao verificar status'));

      // Primeira chamada
      await viewmodel.checkPaymentStatus(invoice: invoice);
      // Segunda chamada
      await viewmodel.checkPaymentStatus(invoice: invoice);
      // Terceira chamada (maxRetries)
      await viewmodel.checkPaymentStatus(invoice: invoice);

      expect(viewmodel.paymentState, PaymentState.failed);
      verify(() => mockUsecase.pixPaymentStatus(id: testTransactionId)).called(3);
    });

    test('não deve fazer nada quando não houver transactionId', () async {
      final invoice = EstablishmentInvoiceEntity(id: testInvoiceId, establishmentId: testEstablishmentId, amount: 100, dueDate: DateTime.now(), createdAt: DateTime.now(), establishmentPlanId: 'plan-id');

      await viewmodel.checkPaymentStatus(invoice: invoice);

      expect(viewmodel.paymentState, PaymentState.initial);
      verifyNever(() => mockUsecase.pixPaymentStatus(id: testTransactionId));
    });
  });

  group('clear', () {
    test('deve limpar todos os estados do ViewModel', () {
      viewmodel.reset();

      expect(viewmodel.isBlocked, false);
      expect(viewmodel.paymentState, PaymentState.initial);
      expect(viewmodel.paymentDateLimit, null);
    });
  });
}
