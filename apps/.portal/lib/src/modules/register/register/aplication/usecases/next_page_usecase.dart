import 'package:flutter/material.dart';

import 'package:paipfood_package/paipfood_package.dart';
import 'package:portal/src/core/helpers/routes.dart';

import '../stores/register_store.dart';
import '../controllers/register_controller.dart';
import 'navigation_to_usecase.dart';

class NextPageUsecase {
  RegisterStore store;
  RegisterController controller;
  NextPageUsecase({required this.store, required this.controller});

  call(BuildContext context) async {
    final navigationTo = NavigationToUsecase(pageController: store.pageController);
    if (store.pageIndexVN.value == 0) {
      await controller.userExist();
      bool valid = store.formKeyEmailPassword.currentState?.validate() ?? false;
      if (valid) {
        navigationTo.call(index: 1);
        controller;
        store.pageIndexVN.value = 1;
      }
    } else if (store.pageIndexVN.value == 1) {
      bool valid = store.formKeyNamePhone.currentState?.validate() ?? false;
      if (valid) {
        navigationTo.call(index: 2);
        store.pageIndexVN.value = 2;
      }
    } else if (store.pageIndexVN.value == 2) {
      bool valid = store.formKeyDataEstablishment.currentState?.validate() ?? false;
      if (valid) {
        navigationTo.call(index: 3);
        store.pageIndexVN.value = 3;
      }
    } else if (store.pageIndexVN.value == 3) {
      if (store.address?.lat == null) {
        banner.showError("Você deve informar um endereço para prosseguir.", subtitle: "Endereço obrigatório");
        return;
      }
      bool valid = store.formKeyAddress.currentState?.validate() ?? false;
      if (valid) {
        store.company = store.company.copyWith(slug: Utils.onlyAlphanumeric(store.establishment.fantasyName, undereline: true));
        store.establishment = store.establishment.copyWith(companySlug: store.company.slug);
        navigationTo.call(index: 4);
        store.pageIndexVN.value = 4;
      }
    } else if (store.pageIndexVN.value == 4) {
      await controller.slugExist();
      bool valid = store.formKeySlug.currentState?.validate() ?? false;
      if (valid) {
        store.register = true;
        if (context.mounted) context.go(Routes.createEstablishmentStatus);
      }
    }
  }
}
