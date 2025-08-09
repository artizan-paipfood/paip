import 'package:flutter/material.dart';

import 'package:core/core.dart';
import 'package:paipfood_package/paipfood_package.dart';
import 'package:portal/l10n/i18n_extension.dart';
import 'package:portal/src/modules/register/register/aplication/controllers/register_controller.dart';
import 'package:portal/src/modules/register/register/aplication/stores/register_store.dart';

class AddressPage extends StatefulWidget {
  const AddressPage({super.key});

  @override
  State<AddressPage> createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  late final RegisterController controller;
  late final RegisterStore store;
  late TextEditingController number;
  late TextEditingController complement;
  late TextEditingController neighborhood;
  MenuController menuController = MenuController();

  @override
  void initState() {
    controller = context.read<RegisterController>();
    store = controller.store;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    number = TextEditingController(text: store.address?.number);
    neighborhood = TextEditingController(text: store.address?.neighborhood);
    complement = TextEditingController(text: store.address?.complement);

    return Form(
      key: store.formKeyAddress,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text("${context.i18n.qualEnderecoEstabelecimento} ", style: context.textTheme.titleLarge),
                Text(store.establishment.fantasyName, style: context.textTheme.titleLarge!.copyWith(color: context.color.primaryColor)),
                Text("?", style: context.textTheme.titleLarge),
              ],
            ),
            Text("${context.i18n.vamosLocalizarSeuEstabelecimento}.", style: context.textTheme.bodySmall),
            const SizedBox(height: 70),
            CwSearchAddress(
              addressApi: context.read<IAddressApi>(),
              label: context.i18n.enderecoEstabelecimento,
              country: LocaleNotifier.instance.locale.name,
              onSelectAddress: (address) async {
                setState(() => store.address = address);
              },
            ),
            Visibility(
              visible: store.address?.lat != null,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CwTextFormFild(label: context.i18nCore.numero, controller: number, onChanged: (value) => store.address = store.address?.copyWith(number: value), maskUtils: MaskUtils.cRequired(), expanded: true),
                      PSize.ii.sizedBoxW,
                      CwTextFormFild(controller: neighborhood, label: context.i18nCore.bairro, onChanged: (value) => store.address = store.address?.copyWith(neighborhood: value), maskUtils: MaskUtils.cRequired(), expanded: true, flex: 3),
                    ],
                  ),
                  CwTextFormFild(label: context.i18nCore.complemento, controller: complement, onChanged: (value) => store.address = store.address?.copyWith(complement: value)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
