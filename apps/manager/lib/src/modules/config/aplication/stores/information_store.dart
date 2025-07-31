import 'package:flutter/widgets.dart';
import 'package:core/core.dart';
import 'package:manager/src/core/datasources/data_source.dart';
import 'package:manager/src/modules/config/aplication/usecases/save_information_establishment_usecase.dart';
import 'package:paipfood_package/paipfood_package.dart';

class InformationStore {
  final DataSource dataSource;
  final SaveInformationEstablishmentUsecase saveInformationEstablishmentUsecase;
  InformationStore({
    required this.dataSource,
    required this.saveInformationEstablishmentUsecase,
  });

  late EstablishmentModel establishment = establishmentProvider.value.copyWith();
  late CompanyModel company = dataSource.company.copyWith();
  late AddressEntity address = establishment.address!;
  final formKey = GlobalKey<FormState>();

  Future<void> save() async {
    if (formKey.currentState!.validate()) {
      establishment.address = address;
      establishmentProvider.value = establishment;
      dataSource.company = company;
      await saveInformationEstablishmentUsecase.call();
    }
  }
}
