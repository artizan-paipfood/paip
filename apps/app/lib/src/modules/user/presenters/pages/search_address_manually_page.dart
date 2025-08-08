import 'package:app/src/core/notifiers/delivery_area_notifier.dart';
import 'package:flutter/material.dart';

import 'package:app/l10n/l18n_extension.dart';
import 'package:app/src/core/helpers/command.dart';

import 'package:app/src/core/helpers/routes.dart';
import 'package:app/src/modules/user/presenters/viewmodels/user_store.dart';
import 'package:paipfood_package/paipfood_package.dart';

class SearchAddressManuallyPage extends StatefulWidget {
  const SearchAddressManuallyPage({super.key});

  @override
  State<SearchAddressManuallyPage> createState() => _SearchAddressManuallyPageState();
}

class _SearchAddressManuallyPageState extends State<SearchAddressManuallyPage> {
  late final userViewmodel = context.read<UserStore>();
  final formKey = GlobalKey<FormState>();
  final focusNodeNumber = FocusNode();
  late final streetEC = TextEditingController(text: userViewmodel.userDto.address?.street);
  late final neighborhoodEC = TextEditingController(text: userViewmodel.userDto.address?.neighborhood);
  late final postalCodeEC = TextEditingController(text: userViewmodel.userDto.address?.zipCode);
  late final _deliveryAreaNotifier = context.read<DeliveryAreaNotifier>();
  String _number = '';
  String _complement = '';

  @override
  void initState() {
    super.initState();
    // Carregar o cache para garantir que o endereço seja inicializado
    userViewmodel.loadCache();
  }

  @override
  void dispose() {
    streetEC.dispose();
    neighborhoodEC.dispose();
    focusNodeNumber.dispose();
    postalCodeEC.dispose();
    super.dispose();
  }

  Future<void> _onSubmit(BuildContext context) async {
    Command0.executeWithLoader(
      context,
      () async {
        if (formKey.currentState!.validate()) {
          final result = await userViewmodel.userAddressUsecase.searchByPostalCode(
            userVm: userViewmodel.userDto,
            value: postalCodeEC.text,
          );

          final address = AddressEntity(
            id: uuid,
            street: streetEC.text,
            neighborhood: neighborhoodEC.text,
            zipCode: postalCodeEC.text,
            number: _number,
            complement: _complement,
            address: '${streetEC.text}, ${neighborhoodEC.text}, $_number, $_complement - ${postalCodeEC.text}',
            lat: result.lat,
            long: result.long,
          );
          userViewmodel.updateUserDto(userViewmodel.userDto.copyWith(address: address));
          await _deliveryAreaNotifier.loadDeliveryTax(
            address: address,
            establishmentAddress: userViewmodel.establishmentAdress!,
            deliveryMethod: _deliveryAreaNotifier.deliveryMethod!,
          );
          if (context.mounted) Go.of(context).pushNeglect(Routes.addressNickname);

          // if (store.addressIsValid) {
          //   Go.of(context).pushNamedNeglect(Routes.addressNickname.name);
          //   return;
          // }
          // Loader.show(context);
          // try {
          //   await store.userAddressUsecase.getAddress(userVm: store.userDto, establishmentAddress: store.establishmentAdress);
          //   Loader.hide();
          //   if (context.mounted) {
          //     Go.of(context).pushNamedNeglect(Routes.addressNickname.name);
          //   }
          // } catch (e) {
          //   banner.showInfo("Por favor tente colocar o seu CEP, para que possamos encontrar seu endereço mais facilmente.",
          //       title: "Endereço não encontrado");
          //   Loader.hide();
          // }
        }
      },
      onError: (e, s) => banner.showError(context.i18n.erroBuscaCep),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.color.primaryBG,
      floatingActionButton: FloatingActionButton(onPressed: () => _onSubmit(context), child: const Icon(Icons.arrow_forward)),
      appBar: AppBar(),
      body: Form(
        key: formKey,
        child: ListenableBuilder(
          listenable: userViewmodel,
          builder: (context, _) {
            return Padding(
              padding: PSize.ii.paddingHorizontal,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(context.i18n.digiteSeuEnderecoEntrega, style: context.textTheme.titleLarge),
                  // Text(
                  //   "Se você souber seu cep preenchemos seu endereço automaticamente.",
                  //   style: context.textTheme.bodyMedium?.muted(context),
                  // ),
                  PSize.i.sizedBoxH,
                  Row(
                    children: [
                      SizedBox(
                        width: 150,
                        child: CwTextFormFild.underlinded(
                          label: "${context.i18n.cep}*",
                          autofocus: true,
                          maskUtils: isBr ? MaskUtils.cep(isRequired: true) : MaskUtils.cRequired(),
                          style: context.textTheme.titleLarge,
                          keyboardType: TextInputType.number,
                          controller: postalCodeEC,
                          // onChanged: (value) async {
                          //   if (value.length >= 9) {
                          //     Command0.executeWithLoader(
                          //       context,
                          //       () async {
                          //         final result = await userViewmodel.userAddressUsecase.searchByPostalCode(
                          //           userVm: userViewmodel.userDto,
                          //           value: value,
                          //         );
                          //         userViewmodel.updateUserDto(userViewmodel.userDto.copyWith(address: result));
                          //         streetEC.text = userViewmodel.userDto.address!.street;
                          //         neighborhoodEC.text = userViewmodel.userDto.address!.neighborhood;
                          //         focusNodeNumber.requestFocus();
                          //       },
                          //       onError: (e, s) => banner.showError(context.i18n.erroBuscaCep),
                          //     );
                          //   }
                          // },
                          onFieldSubmitted: (value) => _onSubmit(context),
                        ),
                      ),
                    ],
                  ),
                  PSize.ii.sizedBoxH,
                  CwTextFormFild.underlinded(
                    label: "${context.i18n.endereco}*",
                    style: context.textTheme.titleLarge,
                    autocorrect: true,
                    controller: streetEC,
                    maskUtils: MaskUtils.cRequired(),
                    autovalidateMode: AutovalidateMode.disabled,
                    keyboardType: TextInputType.text,
                    // onChanged: (value) {

                    // },
                    onFieldSubmitted: (value) => _onSubmit(context),
                  ),
                  PSize.ii.sizedBoxH,
                  Column(
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: 90,
                            child: CwTextFormFild.underlinded(
                              label: "Nº*",
                              style: context.textTheme.titleLarge,
                              focusNode: focusNodeNumber,
                              initialValue: userViewmodel.userDto.address?.number,
                              onChanged: (value) {
                                _number = value;
                              },
                              maskUtils: MaskUtils.cRequired(),
                              autovalidateMode: AutovalidateMode.disabled,
                              onFieldSubmitted: (value) => _onSubmit(context),
                            ),
                          ),
                          PSize.iii.sizedBoxW,
                          CwTextFormFild.underlinded(
                            label: "${context.i18n.bairro}*",
                            style: context.textTheme.titleLarge,
                            controller: neighborhoodEC,
                            expanded: true,
                            // onChanged: (value) {

                            // },
                            maskUtils: MaskUtils.cRequired(),
                            autovalidateMode: AutovalidateMode.disabled,
                            onFieldSubmitted: (value) => _onSubmit(context),
                          ),
                        ],
                      ),
                      PSize.ii.sizedBoxH,
                      CwTextFormFild.underlinded(
                        label: context.i18n.complemento,
                        style: context.textTheme.titleLarge,
                        initialValue: userViewmodel.userDto.address?.complement,
                        onChanged: (value) {
                          _complement = value;
                          // userViewmodel.updateUserDto(userViewmodel.userDto.copyWith(address: userViewmodel.userDto.address!.copyWith(complement: value)));
                        },
                        onFieldSubmitted: (value) => _onSubmit(context),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
