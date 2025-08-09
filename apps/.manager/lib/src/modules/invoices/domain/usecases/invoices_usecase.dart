import 'package:flutter/cupertino.dart';

import 'package:core/core.dart';
import 'package:manager/src/core/datasources/data_source.dart';
import 'package:paipfood_package/paipfood_package.dart';

class InvoicesUsecase {
  final IEstablishmentInvoiceRepository establishmentInvoiceRepo;
  final IEstablishmentRepository establishmentRepository;
  final IHipayApi hipayApi;

  InvoicesUsecase({required this.establishmentInvoiceRepo, required this.establishmentRepository, required this.hipayApi});

  Future<EstablishmentInvoiceEntity?> checkInvoice(String establishmentId) async {
    final planAndInvoice = await getLastInvoiceAndPlan(establishmentId);

    if (!isValidPlanAndInvoice(planAndInvoice)) return null;

    final invoice = await buildCurrentInvoice(
      plan: planAndInvoice!.plan!,
      invoice: planAndInvoice.invoice,
      dueDay: establishmentProvider.value.dueDate,
    );

    if (invoice.isNotPaid) {
      await handleUnpaidInvoice(invoice, establishmentId);
      return invoice;
    }

    return null;
  }

  Future<EstablishmentInvoiceEntity> upsert(EstablishmentInvoiceEntity invoice) async {
    return await establishmentInvoiceRepo.upsert(establishmentInvoice: invoice, authToken: AuthNotifier.instance.accessToken);
  }

  Future<PixResponse> generatePix({required EstablishmentInvoiceEntity invoice}) async {
    final pix = await hipayApi.createPixEstablishmentInvoice(
      amount: invoice.amount,
      description: 'Invoice: ${invoice.dueDate.toIso8601String()}',
      establishmentId: invoice.establishmentId,
    );

    await upsert(invoice.copyWith(transactionId: pix.id));

    return pix;
  }

  Future<PaymentStatusResponse> pixPaymentStatus({required String id}) async {
    return await hipayApi.paymentStatus(id: id);
  }

//********************************************************************************************
// PRIVATE METHODS
//********************************************************************************************
  @visibleForTesting
  Future<EstablishmentInvoiceEntity> buildCurrentInvoice({
    required EstablishmentPlanEntity plan,
    required int dueDay,
    EstablishmentInvoiceEntity? invoice,
  }) async {
    if (shouldCreateNewInvoice(invoice)) {
      final newInvoice = buildInvoiceFromPlan(plan: plan, dueDay: dueDay);
      await upsert(newInvoice);
      return newInvoice;
    }
    return invoice!;
  }

  @visibleForTesting
  bool shouldCreateNewInvoice(EstablishmentInvoiceEntity? invoice) {
    return invoice == null || (invoice.isNotCurrentMounth && invoice.isPaid);
  }

  @visibleForTesting
  EstablishmentInvoiceEntity buildInvoiceFromPlan({required EstablishmentPlanEntity plan, required int dueDay}) {
    return EstablishmentInvoiceEntity(
      amount: plan.buildAmount(),
      createdAt: DateTime.now(),
      dueDate: DateTime.now().copyWith(day: dueDay),
      establishmentId: plan.establishmentId,
      establishmentPlanId: plan.id,
      id: uuid,
    );
  }

  @visibleForTesting
  bool isValidPlanAndInvoice(LastInvoiceAndPlanView? planAndInvoice) {
    return planAndInvoice != null && planAndInvoice.plan != null;
  }

  @visibleForTesting
  Future<LastInvoiceAndPlanView?> getLastInvoiceAndPlan(String establishmentId) async {
    return await establishmentInvoiceRepo.getLastInvoiceAndPlan(establishmentId: establishmentId);
  }

  @visibleForTesting
  Future<void> handleUnpaidInvoice(EstablishmentInvoiceEntity invoice, String establishmentId) async {
    if (invoice.isBlocked()) {
      await closeEstablishment(establishmentId: establishmentId);
    }
  }

  @visibleForTesting
  Future<void> closeEstablishment({required String establishmentId}) async {
    final updatedEstablishment = establishmentProvider.value.copyWith(isOpen: false);
    await establishmentRepository.updateEstablishment(
      establishment: updatedEstablishment,
      authToken: AuthNotifier.instance.accessToken,
    );
  }
}
