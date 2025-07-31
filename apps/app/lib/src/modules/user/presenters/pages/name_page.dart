import 'package:flutter/material.dart';
import 'package:app/l10n/l18n_extension.dart';
import 'package:app/src/core/helpers/execute.dart';
import 'package:paipfood_package/paipfood_package.dart';
import 'package:app/src/core/helpers/routes.dart';
import 'package:app/src/modules/user/presenters/viewmodels/user_store.dart';

class NamePage extends StatefulWidget {
  const NamePage({super.key});

  @override
  State<NamePage> createState() => _NamePageState();
}

class _NamePageState extends State<NamePage> {
  late final authService = context.read<PhoneAuthMicroService>();
  late final userViewmodel = context.read<UserStore>();
  @override
  Widget build(BuildContext context) {
    return NameMicroPage(
      title: context.i18n.qualESeuNome,
      hint: context.i18n.digiteSeuNome,
      initialValue: userViewmodel.userDto.name,
      onSubmit: (name) async {
        authService.setUserName(name);
        userViewmodel.changeName(name);
        if (userViewmodel.navigationMode.isEditName) {
          await execute(context, action: () async => await userViewmodel.userUsecase.update(userViewmodel.userDto), onSuccess: () => userViewmodel.navigateFinish(context));
          return;
        }
        Go.of(context).pushNeglect(Routes.phone);
      },
    );
  }
}
