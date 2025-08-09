import 'package:flutter/material.dart';

import 'package:multiavatar/multiavatar.dart';
import 'package:core/core.dart';
import 'package:manager/l10n/i18n_extension.dart';
import 'package:manager/src/modules/pdv/aplication/stores/customer_store.dart';
import 'package:manager/src/modules/pdv/presenter/components/pdv/customers/card_address_client.dart';
import 'package:manager/src/modules/pdv/presenter/components/pdv/customers/card_customer/phone_fild_widget.dart';
import 'package:manager/src/modules/pdv/presenter/components/pdv/customers/pdv_customer_address_form.dart';
import 'package:paipfood_package/paipfood_package.dart';

class TabInfoCustomer extends StatefulWidget {
  final void Function() onCancel;
  final TabController tabController;
  const TabInfoCustomer({required this.onCancel, required this.tabController, super.key});
  @override
  State<TabInfoCustomer> createState() => _TabInfoCustomerState();
}

class _TabInfoCustomerState extends State<TabInfoCustomer> {
  late final store = context.read<CustomerStore>();

  late CustomerModel _newCustomer;
  final phoneEC = TextEditingController();
  final formKey = GlobalKey<FormState>();
  var name = ValueNotifier('');
  @override
  void initState() {
    _newCustomer = store.selectedCustomer ?? CustomerModel(address: AddressEntity(id: ''), addresses: []);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.i18n.novoCliente), leading: CwIconButtonAppBar(onPressed: widget.onCancel)),
      body: ValueListenableBuilder(
        valueListenable: store.rebuildCustomer,
        builder: (context, _, __) {
          return Form(
            key: formKey,
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ValueListenableBuilder(
                                valueListenable: name,
                                builder: (context, _, __) {
                                  return Padding(padding: PSize.iii.paddingAll, child: CircleAvatar(radius: 70, backgroundColor: context.color.onPrimaryBG, child: _newCustomer.name.isNotEmpty ? SvgPicture.string(multiavatar(_newCustomer.name)) : const SizedBox.shrink()));
                                },
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    CwTextFormFild(
                                      label: "${context.i18n.nomeCompleto}*",
                                      autofocus: true,
                                      initialValue: _newCustomer.name,
                                      onChanged: (value) {
                                        _newCustomer.name = value;
                                        name.value = value;
                                      },
                                      maskUtils: MaskUtils.cRequired(),
                                    ),
                                    PhoneFildWidget(
                                      label: "${context.i18n.telefone}*",
                                      onChanged: (countryCode, phone) {
                                        _newCustomer
                                          ..phone = phone
                                          ..phoneCountryCode = countryCode;
                                      },
                                    ),
                                    CwTextFormFild(
                                      label: "${context.i18n.dataNascimento}🎂",
                                      initialValue: _newCustomer.birthdate != null ? DateFormat('dd/MM/yyyy').format(_newCustomer.birthdate!) : '',
                                      maskUtils: MaskUtils.datePtbr(),
                                      onChanged: (value) {
                                        if (value.length == 10) {
                                          _newCustomer.birthdate = DateFormat('dd/MM/yyyy').parse(value);
                                        }
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          PSize.iii.sizedBoxH,
                          Text(context.i18n.enderecoCliente, style: context.textTheme.bodyLarge),
                          PSize.ii.sizedBoxH,
                          if (_newCustomer.addresses.isEmpty) Center(child: Row(mainAxisSize: MainAxisSize.min, children: [const Icon(PaipIcons.dropBox), PSize.i.sizedBoxW, Text(context.i18n.descEmptyStateEnderecos)])),
                          if (_newCustomer.addresses.isNotEmpty)
                            ..._newCustomer.addresses.map(
                              (e) => Padding(
                                padding: const EdgeInsets.only(top: 4),
                                child: CardAddressClient(
                                  address: e,
                                  customer: _newCustomer,
                                  store: store,
                                  onTap: () {
                                    setState(() {
                                      store.selectedCustomer!.address = e;
                                    });
                                  },
                                ),
                              ),
                            ),
                          PSize.iii.sizedBoxH,
                          const Divider(),
                          PdvCustomerAddressForm(
                            onSave: (address) async {
                              setState(() {
                                _newCustomer
                                  ..addresses.add(address)
                                  ..address = address;
                              });
                            },
                          ),
                          const Divider(),
                        ],
                      ),
                    ),
                  ),
                ),
                Material(
                  elevation: 20,
                  child: Padding(
                    padding: PSize.i.paddingAll,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        PButton(
                          label: context.i18n.salvar,
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              store.saveCustomer(_newCustomer);
                              widget.tabController.animateTo(store.selectAddressTabPage);
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
