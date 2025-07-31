import 'package:flutter/material.dart';

import 'package:paipfood_package/paipfood_package.dart';
import 'package:portal/l10n/i18n_extension.dart';
import 'package:portal/src/core/helpers/breakpoints.dart';
import 'package:portal/src/modules/register/register/aplication/controllers/register_controller.dart';
import 'package:portal/src/modules/register/register/aplication/stores/register_store.dart';
import 'package:ui/ui.dart';

class DataEstablishmentView extends StatefulWidget {
  const DataEstablishmentView({super.key});

  @override
  State<DataEstablishmentView> createState() => _DataEstablishmentViewState();
}

class _DataEstablishmentViewState extends State<DataEstablishmentView> {
  late final controller = context.read<RegisterController>();
  late RegisterStore store = controller.store;

  String _searchCulinary = '';

  List<CulinaryStyleEnum> get _styles {
    if (_searchCulinary.isEmpty) {
      return CulinaryStyleEnum.values;
    }
    return CulinaryStyleEnum.values.where((element) => element.name.i18n().toLowerCase().contains(_searchCulinary.toLowerCase())).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: store.formKeyDataEstablishment,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [Text("${context.i18n.prazer}, ", style: context.textTheme.titleLarge), Text(store.user.name, style: context.textTheme.titleLarge!.copyWith(color: context.artColorScheme.primary)), Text("!", style: context.textTheme.titleLarge)]),
            Text("${context.i18n.conteUmPoucoSobreSeuEstabelecimento}.", style: context.textTheme.bodySmall),
            SizedBox(height: !PaipBreakpoint.phone.isBreakpoint(context) ? 70 : 20),
            ArtTextFormField(label: Text(context.i18n.nomeEstabelecimento), initialValue: store.establishment.fantasyName, onChanged: (value) => store.establishment = store.establishment.copyWith(fantasyName: value), formController: ObrigatoryValidator()),
            PSize.i.sizedBoxH,
            ArtTextFormField(
              label: Text("CPF"),
              initialValue: store.establishment.personalDocument,
              onChanged: (value) => store.establishment = store.establishment.copyWith(personalDocument: value),
              formController: CpfValidator(isRequired: true),
              keyboardType: TextInputType.number,
            ),
            PSize.i.sizedBoxH,
            // UiInputFormField(
            //   label: Text("CNPJ"),
            //   initialValue: store.establishment.businessDocument,
            //   formController: CnpjValidator(isRequired: false),
            //   onChanged: (value) => store.establishment = store.establishment.copyWith(businessDocument: value),
            //   validator: (_) {
            //     return null;
            //   },
            //   keyboardType: TextInputType.number,
            // ),
            PSize.i.sizedBoxH,
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return ArtSelectWithSearch<CulinaryStyleEnum>(
                        maxWidth: constraints.maxWidth,
                        minWidth: constraints.maxWidth,
                        label: Text(context.i18n.estiloCulinario),
                        initialValue: store.establishment.culinaryStyle,
                        shrinkWrap: true,
                        validator: (value) {
                          if (value == null) {
                            return context.i18nCore.validateSelecioneUmEstiloCulinario;
                          }
                          return null;
                        },
                        onSearchChanged: (value) {
                          setState(() {
                            _searchCulinary = value;
                          });
                        },
                        selectedOptionBuilder: (context, value) => Text(value.name.i18n()),
                        onChanged: (value) => store.establishment = store.establishment.copyWith(culinaryStyle: value),
                        options: _styles.map((e) => ArtOption(value: e, child: Text(e.name.i18n()))).toList(),
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
