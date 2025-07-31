import 'package:flutter/material.dart';

import 'package:core/core.dart';
import 'package:manager/l10n/i18n_extension.dart';
import 'package:manager/src/core/datasources/data_source.dart';

import 'package:manager/src/core/components/base_page.dart';
import 'package:manager/src/core/components/container_shadow.dart';
import 'package:manager/src/core/components/header_card.dart';
import 'package:manager/src/core/helpers/command.dart';
import 'package:manager/src/modules/config/domain/dtos/user_preferences_dto.dart';
import 'package:manager/src/modules/config/presenters/preferences/components/card_envoriments.dart';
import 'package:manager/src/modules/config/presenters/preferences/components/card_switch.dart';
import 'package:manager/src/modules/config/presenters/viewmodels/establishment_preferences_viewmodel.dart';
import 'package:manager/src/modules/config/presenters/viewmodels/user_preferences_viewmode.dart';
import 'package:paipfood_package/paipfood_package.dart';
import 'package:ui/ui.dart';

class PreferencesPage extends StatefulWidget {
  const PreferencesPage({super.key});

  @override
  State<PreferencesPage> createState() => _PreferencesPageState();
}

class _PreferencesPageState extends State<PreferencesPage> {
  late final userPreferencesviewmodel = Modular.get<UserPreferencesViewmodel>();
  late final establishmentPreferencesviewmodel = Modular.get<EstablishmentPreferencesViewmodel>();

  UserPreferencesDto get _userPreferences => userPreferencesviewmodel.userPreferences;

  EstablishmentPreferencesEntity get _establishmentPrefs => establishmentPreferencesviewmodel.prefences!;

  @override
  void initState() {
    establishmentPreferencesviewmodel.initalizeEstablishment(establishmentProvider.value);
    super.initState();
  }

  Future<void> _onSave(BuildContext context) async {
    Command0.executeWithLoader(
      context,
      () async {
        await userPreferencesviewmodel.save();
        await establishmentPreferencesviewmodel.save();
      },
      analyticsDesc: 'Save preferences _onSave()',
      onSuccess: (r) => toast.showSucess(context.i18n.salvoComSucesso, alignment: Alignment.topRight),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(header: buildHeader(context), child: buildChild(context));
  }

  Widget buildHeader(BuildContext context) {
    return CwHeaderCard(titleLabel: context.i18n.preferencias, actions: PButton(label: context.i18n.salvar, onPressed: () async => await _onSave(context)));
  }

  //
  Widget buildChild(BuildContext context) {
    return ListenableBuilder(
      listenable: userPreferencesviewmodel,
      builder: (context, _) {
        return SingleChildScrollView(child: Column(children: [buildUserPreferences(context), PSize.spacer.sizedBoxH, buildEstablishmentPreferences(context)]));
      },
    );
  }

  //
  Widget buildUserPreferences(BuildContext context) {
    return CwContainerShadow(
      borderRadius: PSize.i.borderRadiusAll,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(context.i18n.preferenciasDoUsuario, style: context.textTheme.titleLarge),
          PSize.spacer.sizedBoxH,
          Wrap(
            children: [
              CardSwitch(
                label: context.i18n.destro,
                value: _userPreferences.handMode == HandMode.rightHanded,
                description: context.i18n.descDestro,
                onChanged: (value) {
                  userPreferencesviewmodel.edit(_userPreferences.copyWith(handMode: value ? HandMode.rightHanded : HandMode.leftHanded));
                },
              ),
              CardSwitch(
                label: context.i18n.telefoneClienteAvulsoObrigatorio,
                description: '.',
                value: _userPreferences.isPhoneRequiredForGuestClient,
                onChanged: (value) {
                  userPreferencesviewmodel.edit(_userPreferences.copyWith(isPhoneRequiredForGuestClient: value));
                },
              ),
              CardSwitch(
                label: context.i18n.terminalPrincipal,
                description: '.',
                value: _userPreferences.isPrimaryTerminal,
                onChanged: (value) {
                  userPreferencesviewmodel.edit(_userPreferences.copyWith(isPrimaryTerminal: value));
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  //
  Widget buildEstablishmentPreferences(BuildContext context) {
    return CwContainerShadow(
      borderRadius: PSize.i.borderRadiusAll,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(context.i18n.preferenciasDoEstabelecimento, style: context.textTheme.titleLarge),
          PSize.spacer.sizedBoxH,
          Wrap(
            children: [
              CardEnvoriments(
                label: context.i18n.contagemPedidos,
                description: context.i18n.descContagemPedidos,
                child: SizedBox(
                  width: 100,
                  child: CwTextFormFild(
                    initialValue: _establishmentPrefs.resetOrderNumberReference.toString(),
                    maskUtils: MaskUtils.onlyInt(isRequired: true),
                    onChanged: (value) {
                      if (value.isEmpty) return;
                      establishmentPreferencesviewmodel.edit(_establishmentPrefs.copyWith(resetOrderNumberReference: int.parse(value)));
                    },
                  ),
                ),
              ),
              CardEnvoriments(
                label: context.i18n.resetContagemPedidos,
                description: context.i18n.periodo,
                child: PDropMenuForm<ResetOrderNumberPeriod>(
                  initialSelection: _establishmentPrefs.resetOrderNumberPeriod,
                  dropdownMenuEntries: [...ResetOrderNumberPeriod.values.map((r) => DropdownMenuEntry(label: r.i18n(context), value: r))],
                  onSelected: (value) {
                    if (value == null) return;
                    establishmentPreferencesviewmodel.setResetOrderNumberPeriod(value);
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  //
}
