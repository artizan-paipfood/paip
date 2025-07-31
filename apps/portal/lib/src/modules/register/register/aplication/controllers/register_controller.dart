import 'package:flutter/material.dart';
import 'package:paipfood_package/paipfood_package.dart';
import 'package:portal/src/modules/register/register/aplication/usecases/insert_user_company_establishment_usecase.dart';
import '../stores/register_store.dart';
import '../usecases/back_page_usecase.dart';
import '../usecases/next_page_usecase.dart';

class RegisterController {
  IAuthRepository authRepository;
  IEstablishmentRepository establishmentRepository;
  RegisterStore store;
  InsertUserCompanyEstablishmentUsecase insertCompanyUsecase;
  RegisterController({
    required this.authRepository,
    required this.establishmentRepository,
    required this.store,
    required this.insertCompanyUsecase,
  });

  void nextPage(BuildContext context) => NextPageUsecase(store: store, controller: this).call(context);

  Future<void> userExist() async {
    store.userExist = store.user.email != null ? await authRepository.userExistsByEmail(value: store.user.email!) : false;
  }

  Future<bool?> slugExist() async {
    if (store.company.slug.isEmpty) return null;
    store.slugExist = await establishmentRepository.slugExists(store.company.slug);
    return store.slugExist;
  }

  Future<void> insertCompany() async {
    store.company = store.company.copyWith(establishments: [store.establishment]);
    await insertCompanyUsecase.call(user: store.user, password: store.password, company: store.company, address: store.address!, establishment: store.establishment);
  }

  backPage() => BackPageUsecase(store: store).call();

  FormFieldValidator validatorConfirmPassword(String confirmPassword) {
    return (value) {
      if (value == null || value.isEmpty) {
        return "Confirmação de senha Obrigatória";
      }
      if (value != confirmPassword) {
        return "As senhas não coincidem";
      }
      return null;
    };
  }
}
