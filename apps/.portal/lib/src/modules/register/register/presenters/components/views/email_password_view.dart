import 'package:flutter/material.dart';

import 'package:paipfood_package/paipfood_package.dart';
import 'package:portal/l10n/i18n_extension.dart';
import 'package:portal/src/modules/register/register/aplication/controllers/password_verify_controller.dart';
import 'package:portal/src/modules/register/register/aplication/controllers/register_controller.dart';
import 'package:portal/src/modules/register/register/aplication/stores/register_store.dart';
import 'package:portal/src/modules/register/register/presenters/components/terms_policy.dart';
import 'package:portal/src/modules/register/register/domain/dtos/password_validation_dto.dart';
import 'package:ui/ui.dart';

class EmailPasswordView extends StatefulWidget {
  const EmailPasswordView({super.key});

  @override
  State<EmailPasswordView> createState() => _EmailPasswordViewState();
}

class _EmailPasswordViewState extends State<EmailPasswordView> {
  var passwordVerifyVM = ValueNotifier(PasswordValidationDto());
  final passwordEC = TextEditingController();
  final confirmPasswordEC = TextEditingController();

  late final controller = context.read<RegisterController>();
  @override
  Widget build(BuildContext context) {
    RegisterStore store = controller.store;

    return SingleChildScrollView(
      child: Form(
        key: store.formKeyEmailPassword,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(context.i18n.vendaMuitoMaisComNossasSolucoesDigitais, style: context.textTheme.titleLarge),
            const SizedBox(height: 70),
            ArtTextFormField(
              label: Text(context.i18nCore.email),
              initialValue: store.user.email,
              textCapitalization: TextCapitalization.none,
              onChanged: (value) => store.user = store.user.copyWith(email: value),
              formController: EmailValidator(
                isRequired: true,
                customValidator: (value) {
                  if (store.userExist) return context.i18nCore.validateEmailJaCadastrado;
                  return null;
                },
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            PSize.i.sizedBoxH,
            ArtTextFormField(
              label: Text(context.i18nCore.senha),
              textCapitalization: TextCapitalization.none,
              onChanged: (value) {
                passwordVerifyVM.value = PasswordVerifyController.verify(value);
                store.password = value;
              },
              formController: PasswordValidator(),
              controller: passwordEC,
              keyboardType: TextInputType.visiblePassword,
              obscureText: true,
            ),
            Padding(
              padding: PSize.i.paddingHorizontal + PSize.i.paddingVertical,
              child: ValueListenableBuilder(
                valueListenable: passwordVerifyVM,
                builder: (context, value, _) {
                  return LinearProgressIndicator(value: value.score, backgroundColor: context.artColorScheme.muted, color: value.color, borderRadius: BorderRadius.circular(10));
                },
              ),
            ),
            PSize.i.sizedBoxH,
            ArtTextFormField(
              label: Text(context.i18nCore.confirmeSenha),
              textCapitalization: TextCapitalization.none,
              formController: PasswordValidator(
                customValidator: (value) {
                  if (value != passwordEC.text) return context.i18nCore.validateSenhasNaoConferem;
                  return null;
                },
              ),
              keyboardType: TextInputType.visiblePassword,
              controller: confirmPasswordEC,
              obscureText: true,
            ),
            PSize.ii.sizedBoxH,
            const TermsPolicy(),
            PSize.ii.sizedBoxH,
          ],
        ),
      ),
    );
  }
}
