import 'package:flutter/material.dart';

import 'package:core/core.dart';
import 'package:manager/l10n/i18n_extension.dart';
import 'package:manager/src/core/components/header_card.dart';
import 'package:paipfood_package/paipfood_package.dart';
import '../../../../../core/components/container_shadow.dart';
import '../../../aplication/stores/information_store.dart';

class PrincipalInformation extends StatefulWidget {
  const PrincipalInformation({super.key});

  @override
  State<PrincipalInformation> createState() => _PrincipalInformationState();
}

class _PrincipalInformationState extends State<PrincipalInformation> {
  final phoneCountryCodeEC = TextEditingController();
  late var controller = context.read<InformationStore>();
  late final phoneEC = TextEditingController(text: controller.establishment.phone);
  String _locale = LocaleNotifier.instance.locale.name;

  final languageNofier = LanguageNotifier.instance;

  @override
  void dispose() {
    phoneCountryCodeEC.dispose();
    phoneEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CwContainerShadow(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CwHeaderCard(
            titleLabel: context.i18n.informacoesPrincipais,
            description: context.i18n.descInformacoesPrincipais,
            actions: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(context.i18n.idioma, style: context.textTheme.titleMedium),
                PSize.i.sizedBoxW,
                DropButtonLocale(
                  initialLocale: languageNofier.locale,
                  onChanged: (locale) async {
                    languageNofier.change(locale);
                  },
                ),
              ],
            ),
          ),
          CwTextFormFild(initialValue: controller.establishment.fantasyName, maskUtils: MaskUtils.cRequired(), label: context.i18n.nomeLoja, onChanged: (value) => controller.establishment = controller.establishment.copyWith(fantasyName: value)),
          CwTextFormFild(initialValue: controller.establishment.description, label: context.i18n.descricao, maxLines: 2, minLines: 1, onChanged: (value) => controller.establishment = controller.establishment.copyWith(description: value)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Expanded(child: SizedBox()),
              // CwTextFormFild(
              //   initialValue: controller.establishment.businessDocument,
              //   label: context.i18n.cnpj,
              //   maskUtils: MaskUtils.cnpj( ),
              //   expanded: true,
              //   onChanged: (value) {
              //     controller.establishment = controller.establishment.copyWith(businessDocument: value);
              //   },
              // ),
              PSize.iii.sizedBoxW,
              CwTextFormFild(
                initialValue: controller.establishment.corporateName,
                label: context.i18n.razaoSocial,
                expanded: true,
                onChanged: (value) {
                  controller.establishment = controller.establishment.copyWith(corporateName: value);
                },
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CwTextFormFild(
                initialValue: controller.establishment.phone,
                expanded: true,
                prefixIcon: Padding(
                  padding: PSize.i.paddingLeft + PSize.i.paddingRight + const EdgeInsets.only(bottom: 6),
                  child: FlagCountrySelector(
                    initialPhoneCountryCode: controller.establishment.phoneCountryCode,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    countries: Countries.countriesAllowOnboarding,
                    phoneCountryCodeController: phoneCountryCodeEC,
                    onCountryChanged: (country) {
                      setState(() {
                        controller.establishment = controller.establishment.copyWith(phoneCountryCode: country.dialCode);
                        _locale = country.locale;
                        LocaleNotifier.instance.setLocale(DbLocale.fromMap(country.locale));
                        phoneCountryCodeEC.text = country.dialCode;
                        phoneEC.clear();
                      });
                    },
                  ),
                ),
                maskUtils: MaskUtils.phone(textEditingController: phoneEC, locale: _locale, isRequired: true),
                onChanged: (value) {
                  controller.establishment = controller.establishment.copyWith(phone: value, phoneCountryCode: controller.establishment.phoneCountryCode);
                },
              ),
              // CwTextFormFild(
              //   initialValue: controller.establishment.phone.replaceFirst(controller.establishment.phoneCountryCode, ''),
              //   label: context.i18n.telefone,
              //   maskUtils: MaskUtils.phonePtBr(textEditingController: phoneEC, minLenght: 10),
              //   expanded: true,
              //   onChanged: (value) {
              //     controller.establishment = controller.establishment.copyWith(phone: controller.establishment.phoneCountryCode + value);
              //   },
              // ),
              PSize.iii.sizedBoxW,
              CwTextFormFild(
                initialValue: controller.establishment.minimunOrder.toStringAsFixed(2),
                label: context.i18n.pedidoMin,
                maskUtils: MaskUtils.currencyRequired(),
                expanded: true,
                onChanged: (value) => controller.establishment = controller.establishment.copyWith(minimunOrder: Utils.stringToDouble(value)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
