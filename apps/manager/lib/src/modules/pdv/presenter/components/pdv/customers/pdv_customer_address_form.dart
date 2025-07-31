import 'package:flutter/material.dart';

import 'package:core/core.dart';
import 'package:manager/l10n/i18n_extension.dart';
import 'package:manager/src/core/datasources/data_source.dart';
import 'package:manager/src/modules/pdv/aplication/stores/address_customer_store.dart';
import 'package:paipfood_package/paipfood_package.dart';

class PdvCustomerAddressForm extends StatefulWidget {
  final Future<void> Function(AddressEntity address) onSave;
  const PdvCustomerAddressForm({required this.onSave, super.key});

  @override
  State<PdvCustomerAddressForm> createState() => _PdvCustomerAddressFormState();
}

class _PdvCustomerAddressFormState extends State<PdvCustomerAddressForm> {
  late final addressCustomerStore = context.read<AddressCustomerStore>();
  late final addressApi = context.read<IAddressApi>();
  final streetEC = TextEditingController();
  final neighborhoodEC = TextEditingController();
  final numberFN = FocusNode();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    streetEC.dispose();
    neighborhoodEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          if (LocaleNotifier.instance.locale == DbLocale.gb)
            CwSearchAddress(
              country: LocaleNotifier.instance.locale.name,
              establishmentAddress: establishmentProvider.value.address,
              addressApi: addressApi,
              onSelectAddress: (value) {
                addressCustomerStore.setAddress(value);
                neighborhoodEC.text = addressCustomerStore.address.neighborhood;
                streetEC.text = addressCustomerStore.address.street;
                numberFN.requestFocus();
              },
              neighborhoodEC: neighborhoodEC,
            ),
          if (LocaleNotifier.instance.locale == DbLocale.br) ...[
            Row(
              children: [
                SizedBox(
                  width: 130,
                  child: CwTextFormFild(
                    label: context.i18n.cep,
                    autofocus: true,
                    maskUtils: MaskUtils.cep(),
                    onChanged: (value) async {
                      if (value.length == 9) {
                        await addressCustomerStore.searchByZipcode(value);
                        neighborhoodEC.text = addressCustomerStore.address.neighborhood;
                        streetEC.text = addressCustomerStore.address.street;
                        numberFN.requestFocus();
                      }
                    },
                  ),
                ),
                PSize.ii.sizedBoxW,
                CwTextFormFild(label: "${context.i18n.enderecoCliente}*", controller: streetEC, expanded: true, onChanged: (value) => addressCustomerStore.address = addressCustomerStore.address.copyWith(street: value), maskUtils: MaskUtils.cRequired()),
              ],
            ),
            PSize.i.sizedBoxH,
            Row(
              children: [
                SizedBox(width: 130, child: CwTextFormFild(label: "${context.i18n.numero}*", initialValue: "", focusNode: numberFN, onChanged: (value) => addressCustomerStore.address = addressCustomerStore.address.copyWith(number: value), maskUtils: MaskUtils.cRequired())),
                PSize.ii.sizedBoxW,
                CwTextFormFild(
                  label: "${context.i18n.bairro}*",
                  onChanged: (value) {
                    addressCustomerStore.address = addressCustomerStore.address.copyWith(neighborhood: value, lat: 0, long: 0);
                  },
                  maskUtils: MaskUtils.cRequired(),
                  controller: neighborhoodEC,
                  expanded: true,
                ),
              ],
            ),
          ],
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              CwTextFormFild(expanded: true, label: context.i18n.complemento, initialValue: addressCustomerStore.address.complement, onChanged: (value) => addressCustomerStore.address = addressCustomerStore.address.copyWith(complement: value)),
              PSize.ii.sizedBoxW,
              Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: PButton(
                  label: context.i18n.adicionarEndereco,
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      await addressCustomerStore.getAddress().then((value) => widget.onSave.call(value));
                    }
                  },
                ),
              ),
            ],
          ),
          PSize.ii.sizedBoxH,
        ],
      ),
    );
  }
}
