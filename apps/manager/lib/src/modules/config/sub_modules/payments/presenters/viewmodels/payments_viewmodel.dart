import 'dart:async';
import 'package:flutter/material.dart';
import 'package:core/core.dart';
import 'package:manager/src/core/datasources/data_source.dart';
import 'package:manager/src/modules/config/sub_modules/payments/domain/usecases/payment_provider_usecase.dart';
import 'package:manager/src/modules/config/aplication/usecases/update_establishment_usecase.dart';
import 'package:paipfood_package/paipfood_package.dart';

class PaymentsViewmodel extends ChangeNotifier {
  final DataSource dataSource;
  final IPaymentMethodRepository paymentMethodRepo;
  final PaymentProviderUsecase paymentProviderUsecase;
  final UpdateEstablishmentUsecase updateEstablishmentUsecase;
  PaymentsViewmodel({
    required this.dataSource,
    required this.paymentMethodRepo,
    required this.paymentProviderUsecase,
    required this.updateEstablishmentUsecase,
  });
  PaymentMethodModel get paymentMethod => establishment.paymentMethod ?? PaymentMethodModel(establishmentId: establishmentProvider.value.id);

  List<PaymentType> get paymentTypes => dataSource.establishments.first.paymentMethod?.getAllPaymentTypes() ?? PaymentType.values.toList();

  EstablishmentModel get establishment => establishmentProvider.value;

  bool paymentIsEnable(PaymentType paymentType) => paymentMethod.getAllPaymentTypes().contains(paymentType);

  Future<Status> load() async {
    if (establishment.paymentProviderId == null) {
      final paymentProvider = await paymentProviderUsecase.createPaymentProvider(PaymentProviderEntity(id: uuid));
      dataSource.setEstablishment(establishment.copyWith(paymentProviderId: paymentProvider.id));
      await updateEstablishmentUsecase.call();
    }
    return Status.complete;
  }

  void switchPaymentType({required PaymentType paymentType, required bool value}) {
    final PaymentMethodModel paymentMethod = this.paymentMethod.switchPaymentType(paymentType: paymentType, value: value);
    dataSource.setEstablishment(establishment.copyWith(paymentMethod: paymentMethod));
    notifyListeners();
  }

  List<OrderTypeEnum> getOrderTypesByPaymentType(PaymentType paymentType) => paymentMethod.getOrderTypesByPaymentType(paymentType);

  Future<void> savePixDto(PixMetadata pixMetadata) async {
    dataSource.setEstablishment(establishment.copyWith(paymentMethod: establishment.paymentMethod?.copyWith(pixMetadata: pixMetadata)));
    notifyListeners();
    await save();
  }

  void updateOrderTypesByPaymentType({required PaymentType paymentType, required List<OrderTypeEnum> orderTypes}) {
    final PaymentMethodModel paymentMethod = this.paymentMethod.updateOrderTypes(paymentType: paymentType, orderTypes: orderTypes);
    dataSource.setEstablishment(establishment.copyWith(paymentMethod: paymentMethod));
    notifyListeners();
  }

  Future<void> save() async {
    await paymentMethodRepo.upsert(paymentMethod: paymentMethod, auth: AuthNotifier.instance.auth);
  }
}
