// ignore_for_file: avoid_redundant_argument_values

import 'package:flutter_test/flutter_test.dart';
import 'package:core/core.dart';
import 'package:paipfood_package/paipfood_package.dart';
import 'package:manager/src/modules/invoices/domain/usecases/invoices_usecase.dart';
import 'package:mocktail/mocktail.dart';

class MockEstablishmentInvoiceApi extends Mock implements IEstablishmentInvoiceRepository {}

class MockIEstablishmentRepository extends Mock implements IEstablishmentRepository {}

class MockHipayApi extends Mock implements IHipayApi {}

void main() {
  late InvoicesUsecase usecase;
  late MockEstablishmentInvoiceApi mockEstablishmentInvoiceApi;
  late MockIEstablishmentRepository mockEstablishmentRepository;
  late MockHipayApi mockHipayApi;

  const testEstablishmentId = 'est-id';
  const testPlanId = 'plan-id';
  const testInvoiceId = 'invoice-id';

  setUp(() {
    mockEstablishmentInvoiceApi = MockEstablishmentInvoiceApi();
    mockEstablishmentRepository = MockIEstablishmentRepository();
    mockHipayApi = MockHipayApi();
    usecase = InvoicesUsecase(
      establishmentInvoiceRepo: mockEstablishmentInvoiceApi,
      establishmentRepository: mockEstablishmentRepository,
      hipayApi: mockHipayApi,
    );

    registerFallbackValue(EstablishmentInvoiceEntity(
      id: testInvoiceId,
      establishmentId: testEstablishmentId,
      amount: 0,
      dueDate: DateTime.now(),
      createdAt: DateTime.now(),
      establishmentPlanId: testPlanId,
    ));

    registerFallbackValue(EstablishmentModel(
      id: testEstablishmentId,
      companySlug: 'company-slug',
    ));
  });

  group('checkInvoice', () {
    test('deve retornar null quando não houver fatura ou plano', () async {
      when(() => mockEstablishmentInvoiceApi.getLastInvoiceAndPlan(
            establishmentId: any(named: 'establishmentId'),
          )).thenAnswer((_) async => null);

      final result = await usecase.checkInvoice(testEstablishmentId);
      expect(result, null);
    });

    test('deve retornar fatura quando não estiver paga', () async {
      final plan = EstablishmentPlanEntity(
        id: testPlanId,
        establishmentId: testEstablishmentId,
        planId: testPlanId,
        billingDay: 15,
        price: 100,
        createdAt: DateTime.now(),
      );

      final invoice = EstablishmentInvoiceEntity(
        id: testInvoiceId,
        establishmentId: testEstablishmentId,
        amount: 100,
        dueDate: DateTime.now(),
        createdAt: DateTime.now(),
        establishmentPlanId: testPlanId,
        paymentDate: null,
      );

      when(() => mockEstablishmentInvoiceApi.getLastInvoiceAndPlan(
            establishmentId: any(named: 'establishmentId'),
          )).thenAnswer((_) async => LastInvoiceAndPlanView(plan: plan, invoice: invoice, establishmentId: testEstablishmentId));

      final result = await usecase.checkInvoice(testEstablishmentId);
      expect(result, isNotNull);
      expect(result?.id, testInvoiceId);
      expect(result?.establishmentId, testEstablishmentId);
      expect(result?.establishmentPlanId, testPlanId);
      expect(result?.amount, 100);
    });

    test('deve lançar exceção quando a API falhar', () async {
      when(() => mockEstablishmentInvoiceApi.getLastInvoiceAndPlan(
            establishmentId: any(named: 'establishmentId'),
          )).thenThrow(Exception('API Error'));

      expect(() => usecase.checkInvoice(testEstablishmentId), throwsException);
    });
  });

  group('generatePix', () {
    test('deve gerar PIX e atualizar fatura com transactionId', () async {
      final invoice = EstablishmentInvoiceEntity(
        id: testInvoiceId,
        establishmentId: testEstablishmentId,
        amount: 100,
        dueDate: DateTime.now(),
        createdAt: DateTime.now(),
        establishmentPlanId: testPlanId,
      );

      final pixResponse = PixResponse(
        id: 'pix-id',
        qrCode: 'qr-code',
        amount: 10,
      );

      final updatedInvoice = invoice.copyWith(transactionId: pixResponse.id);

      when(() => mockHipayApi.createPixEstablishmentInvoice(
            amount: any(named: 'amount'),
            description: any(named: 'description'),
            establishmentId: any(named: 'establishmentId'),
          )).thenAnswer((_) async => pixResponse);

      when(() => mockEstablishmentInvoiceApi.upsert(
            establishmentInvoice: any(named: 'establishmentInvoice'),
            authToken: any(named: 'authToken'),
          )).thenAnswer((_) async => updatedInvoice);

      final result = await usecase.generatePix(invoice: invoice);

      expect(result.id, 'pix-id');
      expect(result.qrCode, 'qr-code');
      expect(result.amount, 10);

      verify(() => mockEstablishmentInvoiceApi.upsert(
            establishmentInvoice: any(named: 'establishmentInvoice'),
            authToken: any(named: 'authToken'),
          )).called(1);
    });
  });

  group('pixPaymentStatus', () {
    test('deve retornar status do pagamento', () async {
      final paymentStatus = PaymentStatusResponse(
        status: PaymentStatus.paid,
        id: 'payment-id',
        amount: 100,
        provider: PaymentProvider.hipay,
      );

      when(() => mockHipayApi.paymentStatus(
            id: any(named: 'id'),
          )).thenAnswer((_) async => paymentStatus);

      final result = await usecase.pixPaymentStatus(id: 'payment_id');

      expect(result.status, PaymentStatus.paid);
      expect(result.amount, 100);
      expect(result.provider, PaymentProvider.hipay);
      expect(result.id, 'payment-id');

      verify(() => mockHipayApi.paymentStatus(
            id: any(named: 'id'),
          )).called(1);
    });
  });

  group('buildCurrentInvoice', () {
    test('deve criar nova fatura quando não existir fatura anterior', () async {
      final plan = EstablishmentPlanEntity(
        id: testPlanId,
        establishmentId: testEstablishmentId,
        planId: testPlanId,
        billingDay: 15,
        price: 100,
        createdAt: DateTime.now(),
      );

      final newInvoice = EstablishmentInvoiceEntity(
        id: testInvoiceId,
        establishmentId: testEstablishmentId,
        amount: 100,
        dueDate: DateTime.now(),
        createdAt: DateTime.now(),
        establishmentPlanId: testPlanId,
      );

      when(() => mockEstablishmentInvoiceApi.upsert(
            establishmentInvoice: any(named: 'establishmentInvoice'),
            authToken: any(named: 'authToken'),
          )).thenAnswer((_) async => newInvoice);

      final result = await usecase.buildCurrentInvoice(
        plan: plan,
        dueDay: 15,
      );

      expect(result.establishmentId, testEstablishmentId);
      expect(result.establishmentPlanId, testPlanId);
      expect(result.amount, 100);
      expect(result.dueDate.day, 15);

      verify(() => mockEstablishmentInvoiceApi.upsert(
            establishmentInvoice: any(named: 'establishmentInvoice'),
            authToken: any(named: 'authToken'),
          )).called(1);
    });

    test('deve retornar fatura existente quando válida', () async {
      final plan = EstablishmentPlanEntity(
        id: testPlanId,
        establishmentId: testEstablishmentId,
        planId: testPlanId,
        billingDay: 15,
        price: 100,
        createdAt: DateTime.now(),
      );

      final existingInvoice = EstablishmentInvoiceEntity(
        id: testInvoiceId,
        establishmentId: testEstablishmentId,
        amount: 100,
        dueDate: DateTime.now(),
        createdAt: DateTime.now(),
        establishmentPlanId: testPlanId,
      );

      final result = await usecase.buildCurrentInvoice(
        plan: plan,
        dueDay: 15,
        invoice: existingInvoice,
      );

      expect(result.id, testInvoiceId);
    });
  });

  group('isValidPlanAndInvoice', () {
    test('deve retornar true quando planAndInvoice e plan são válidos', () {
      final plan = EstablishmentPlanEntity(
        id: testPlanId,
        establishmentId: testEstablishmentId,
        planId: testPlanId,
        billingDay: 15,
        price: 100,
        createdAt: DateTime.now(),
      );

      final planAndInvoice = LastInvoiceAndPlanView(
        plan: plan,
        invoice: null,
        establishmentId: testEstablishmentId,
      );

      expect(usecase.isValidPlanAndInvoice(planAndInvoice), true);
    });

    test('deve retornar false quando planAndInvoice é null', () {
      expect(usecase.isValidPlanAndInvoice(null), false);
    });

    test('deve retornar false quando plan é null', () {
      final planAndInvoice = LastInvoiceAndPlanView(
        plan: null,
        invoice: null,
        establishmentId: testEstablishmentId,
      );

      expect(usecase.isValidPlanAndInvoice(planAndInvoice), false);
    });
  });

  group('getLastInvoiceAndPlan', () {
    test('deve retornar LastInvoiceAndPlanView quando API retorna dados', () async {
      final plan = EstablishmentPlanEntity(
        id: testPlanId,
        establishmentId: testEstablishmentId,
        planId: testPlanId,
        billingDay: 15,
        price: 100,
        createdAt: DateTime.now(),
      );

      final expectedResponse = LastInvoiceAndPlanView(
        plan: plan,
        invoice: null,
        establishmentId: testEstablishmentId,
      );

      when(() => mockEstablishmentInvoiceApi.getLastInvoiceAndPlan(
            establishmentId: any(named: 'establishmentId'),
          )).thenAnswer((_) async => expectedResponse);

      final result = await usecase.getLastInvoiceAndPlan(testEstablishmentId);
      expect(result, expectedResponse);
    });
  });

  group('handleUnpaidInvoice', () {
    test('deve fechar estabelecimento quando fatura está bloqueada', () async {
      final invoice = EstablishmentInvoiceEntity(
        id: testInvoiceId,
        establishmentId: testEstablishmentId,
        amount: 100,
        dueDate: DateTime.now().subtract(const Duration(days: 31)),
        createdAt: DateTime.now(),
        establishmentPlanId: testPlanId,
      );

      final expectedEstablishment = EstablishmentModel(
        id: testEstablishmentId,
        companySlug: 'company-slug',
      );

      when(() => mockEstablishmentRepository.updateEstablishment(
            establishment: any(named: 'establishment'),
            authToken: any(named: 'authToken'),
          )).thenAnswer((_) async => expectedEstablishment);

      await usecase.handleUnpaidInvoice(invoice, testEstablishmentId);

      verify(() => mockEstablishmentRepository.updateEstablishment(
            establishment: any(named: 'establishment'),
            authToken: any(named: 'authToken'),
          )).called(1);
    });
  });

  group('closeEstablishment', () {
    test('deve atualizar estabelecimento como fechado', () async {
      final expectedEstablishment = EstablishmentModel(
        id: testEstablishmentId,
        companySlug: 'company-slug',
      );

      when(() => mockEstablishmentRepository.updateEstablishment(
            establishment: any(named: 'establishment'),
            authToken: any(named: 'authToken'),
          )).thenAnswer((_) async => expectedEstablishment);

      await usecase.closeEstablishment(establishmentId: testEstablishmentId);

      verify(() => mockEstablishmentRepository.updateEstablishment(
            establishment: any(named: 'establishment'),
            authToken: any(named: 'authToken'),
          )).called(1);
    });
  });

  group('update', () {
    test('deve atualizar fatura com sucesso', () async {
      final invoice = EstablishmentInvoiceEntity(
        id: testInvoiceId,
        establishmentId: testEstablishmentId,
        amount: 100,
        dueDate: DateTime.now(),
        createdAt: DateTime.now(),
        establishmentPlanId: testPlanId,
      );

      when(() => mockEstablishmentInvoiceApi.upsert(
            establishmentInvoice: any(named: 'establishmentInvoice'),
            authToken: any(named: 'authToken'),
          )).thenAnswer((_) async => invoice);

      final result = await usecase.upsert(invoice);
      expect(result, invoice);
    });
  });

  group('shouldCreateNewInvoice', () {
    test('deve retornar true quando invoice é null', () {
      expect(usecase.shouldCreateNewInvoice(null), true);
    });

    test('deve retornar true quando invoice não é do mês atual e está paga', () {
      final invoice = EstablishmentInvoiceEntity(
        id: testInvoiceId,
        establishmentId: testEstablishmentId,
        amount: 100,
        dueDate: DateTime.now().subtract(const Duration(days: 31)),
        createdAt: DateTime.now(),
        establishmentPlanId: testPlanId,
        paymentDate: DateTime.now(),
      );

      expect(usecase.shouldCreateNewInvoice(invoice), true);
    });

    test('deve retornar false quando invoice é do mês atual', () {
      final invoice = EstablishmentInvoiceEntity(
        id: testInvoiceId,
        establishmentId: testEstablishmentId,
        amount: 100,
        dueDate: DateTime.now(),
        createdAt: DateTime.now(),
        establishmentPlanId: testPlanId,
      );

      expect(usecase.shouldCreateNewInvoice(invoice), false);
    });
  });

  group('buildInvoiceFromPlan', () {
    test('deve criar fatura com dados do plano', () {
      final plan = EstablishmentPlanEntity(
        id: testPlanId,
        establishmentId: testEstablishmentId,
        planId: testPlanId,
        billingDay: 15,
        price: 100,
        createdAt: DateTime.now(),
      );

      final result = usecase.buildInvoiceFromPlan(
        plan: plan,
        dueDay: 15,
      );

      expect(result.establishmentId, testEstablishmentId);
      expect(result.establishmentPlanId, testPlanId);
      expect(result.amount, 100);
      expect(result.dueDate.day, 15);
    });
  });
}
