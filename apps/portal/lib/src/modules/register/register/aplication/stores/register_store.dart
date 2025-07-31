import 'package:flutter/material.dart';
import 'package:core/core.dart';

import 'package:paipfood_package/paipfood_package.dart';

class RegisterStore extends ChangeNotifier {
  RegisterStore();

  final pageIndexVN = ValueNotifier(0);
  final pageController = PageController(initialPage: 0);
  bool userExist = true;
  bool slugExist = true;
  bool register = true;

  AddressEntity? address;
  EstablishmentModel establishment = EstablishmentModel(id: uuid, companySlug: '');
  CompanyModel company = CompanyModel(paymentFlagsApp: [], slug: '');
  UserModel user = UserModel(id: null, permissions: [Permissions.admin], addresses: []);
  String password = "";

  //formkey
  final formKeyEmailPassword = GlobalKey<FormState>();
  final formKeyNamePhone = GlobalKey<FormState>();
  final formKeyDataEstablishment = GlobalKey<FormState>();
  final formKeyAddress = GlobalKey<FormState>();
  final formKeySlug = GlobalKey<FormState>();
}
