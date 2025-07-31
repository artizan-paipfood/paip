import 'package:flutter/material.dart';

import 'package:core/core.dart';
import 'package:paipfood_package/paipfood_package.dart';
import 'package:portal/l10n/i18n_extension.dart';
import 'package:portal/src/modules/register/register/aplication/controllers/register_controller.dart';
import 'package:portal/src/modules/register/register/aplication/stores/register_store.dart';
import 'package:ui/ui.dart';

class NamePhoneView extends StatefulWidget {
  const NamePhoneView({super.key});

  @override
  State<NamePhoneView> createState() => _NamePhoneViewState();
}

class _NamePhoneViewState extends State<NamePhoneView> {
  late final controller = context.read<RegisterController>();
  late RegisterStore store = controller.store;
  late final phoneEC = TextEditingController(text: store.user.phone);
  String phoneCountryCode = LocaleNotifier.instance.locale.dialCode;
  String initialValuePhone = "";

  late final initialCountry = Countries.countriesAllowOnboarding.firstWhere((country) {
    final c = country.locale.toLowerCase();
    final i = Intl.shortLocale(Intl.systemLocale).toLowerCase();
    return c == i;
  }, orElse: () => Countries.countriesAllowOnboarding.firstWhere((country) => country.locale.toLowerCase() == "br"));

  late PhoneByCountryValidator phoneValidator = PhoneByCountryValidator(isRequired: true, masks: initialCountry.masks, minLenght: initialCountry.minLength);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: store.formKeyNamePhone,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(context.i18n.olaBoasVindasPaip, style: context.textTheme.titleLarge),
            Text(context.i18n.vamosConfigurarSuaConta, style: context.textTheme.bodySmall),
            const SizedBox(height: 70),
            ArtTextFormField(
              label: Text(context.i18n.nomeCompleto),
              initialValue: store.user.name,
              onChanged: (value) => store.user = store.user.copyWith(name: value),
              keyboardType: TextInputType.name,
              formController: ObrigatoryValidator(),
            ),
            PSize.i.sizedBoxH,
            ArtTextFormField(
              label: Text(context.i18n.telefoneContato),
              onChanged: (value) {
                store.user = store.user.copyWith(phone: value, phoneCountryCode: phoneCountryCode);
                store.establishment = store.establishment.copyWith(phone: value, phoneCountryCode: phoneCountryCode);
              },
              keyboardType: TextInputType.phone,
              controller: phoneEC,
              formController: phoneValidator,
              trailing: FlagCountrySelector(
                initialLocale: LocaleNotifier.instance.locale.name,
                countries: Countries.countriesAllowOnboarding,
                enabled: true,
                onCountryChanged: (country) {
                  setState(() {
                    phoneCountryCode = country.dialCode;
                    LocaleNotifier.instance.setLocale(DbLocale.fromMap(country.locale));
                    phoneValidator = PhoneByCountryValidator(masks: country.masks, isRequired: true, minLenght: country.minLength);
                    phoneEC.clear();
                  });
                },
              ),
            ),
            PSize.iii.sizedBoxH,
            Text(context.i18n.paisesAtuamos, style: context.artTextTheme.muted),
            PSize.i.sizedBoxH,
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: Countries.countriesAllowOnboarding
                  .map(
                    (e) => Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset('assets/flags/${e.locale.toUpperCase()}.png', package: 'paipfood_package', width: 32),
                        PSize.i.sizedBoxW,
                        Text(e.name, style: context.artTextTheme.muted),
                      ],
                    ),
                  )
                  .toList(),
            ),
            ArtButton.link(padding: EdgeInsets.zero, child: Text(context.i18n.solicitarAtendimentoPaises)),
          ],
        ),
      ),
    );
  }
}
