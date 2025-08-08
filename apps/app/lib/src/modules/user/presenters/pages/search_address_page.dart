import 'package:app/src/core/helpers/command.dart';
import 'package:app/src/core/notifiers/delivery_area_notifier.dart';
import 'package:flutter/material.dart';
import 'package:app/l10n/l18n_extension.dart';
import 'package:app/src/core/helpers/routes.dart';
import 'package:app/src/modules/user/presenters/components/address_result_list.dart';
import 'package:app/src/modules/user/presenters/viewmodels/search_address_viewmodel.dart';
import 'package:app/src/modules/user/presenters/viewmodels/user_store.dart';
import 'package:paipfood_package/paipfood_package.dart';

class SearchAddressPage extends StatefulWidget {
  const SearchAddressPage({super.key});

  @override
  State<SearchAddressPage> createState() => _SearchAddressPageState();
}

class _SearchAddressPageState extends State<SearchAddressPage> {
  late final _userViewmodel = context.read<UserStore>();
  late final _viewmodel = context.read<SearchAddressViewmodel>();
  final _formKey = GlobalKey<FormState>();
  final _focusNodeNumber = FocusNode();
  final _searchFN = FocusNode();
  late final _streetEC = TextEditingController(text: _userViewmodel.userDto.address?.street);
  late final _numberEC = TextEditingController(text: _userViewmodel.userDto.address?.number);
  late final _neighborhoodEC = TextEditingController(text: _userViewmodel.userDto.address?.neighborhood);
  late final _zipCode = TextEditingController(text: _userViewmodel.userDto.address?.zipCode);
  final _searchEC = TextEditingController();
  bool get _hasFocus => _viewmodel.isSearchingAddress;
  late final _deliveryAreaNotifier = context.read<DeliveryAreaNotifier>();

  @override
  void initState() {
    super.initState();
    // Carregar o cache para garantir que o endereço seja inicializado
    _userViewmodel.loadCache();
  }

  @override
  void dispose() {
    _searchEC.dispose();
    _streetEC.dispose();
    _neighborhoodEC.dispose();
    _focusNodeNumber.dispose();
    super.dispose();
  }

  Future<void> onSubmit(BuildContext context) async {
    if (_userViewmodel.userDto.address == null || _userViewmodel.userDto.address!.isNotValid()) {
      banner.showError(context.i18n.enderecoInvalido);
      return;
    }
    if (_formKey.currentState!.validate()) {
      if (isGb) {
        final address = _userViewmodel.userDto.address;
        _userViewmodel.updateUserDto(_userViewmodel.userDto.copyWith(
            address: address!.copyWith(
          street: address.street.contains(address.zipCode) ? address.street : '${address.street} - ${address.zipCode}',
        )));
      }
      Go.of(context).pushNeglect(Routes.addressNickname);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.color.primaryBG,
      floatingActionButton: FloatingActionButton(onPressed: () => onSubmit(context), child: const Icon(Icons.arrow_forward)),
      appBar: AppBar(),
      body: Form(
        key: _formKey,
        child: ListenableBuilder(
          listenable: _userViewmodel,
          builder: (context, _) {
            return Padding(
              padding: PSize.ii.paddingHorizontal,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListenableBuilder(
                    listenable: _viewmodel,
                    builder: (context, child) {
                      if (!_hasFocus) return buildHeader(context);
                      return const SizedBox.shrink();
                    },
                  ),
                  buildSearchAddress(context),
                  Expanded(
                    child: ListenableBuilder(
                        listenable: _viewmodel,
                        builder: (context, child) {
                          return Column(
                            children: [
                              if (!_hasFocus && _userViewmodel.userDto.address?.lat != null) //
                                buildFormAddress(context),
                              if (_hasFocus)
                                Expanded(
                                  child: AddressResultsList(
                                    searchViewModel: _viewmodel,
                                    latReference: _userViewmodel.establishmentAdress?.lat,
                                    lonReference: _userViewmodel.establishmentAdress?.long,
                                    onSelect: (address) async {
                                      await Command0.executeWithLoader(
                                        context,
                                        () async {
                                          await _deliveryAreaNotifier.loadDeliveryTax(
                                            address: address,
                                            establishmentAddress: _userViewmodel.establishmentAdress!,
                                            deliveryMethod: _deliveryAreaNotifier.deliveryMethod!,
                                          );
                                          final number = _numberEC.text.isNotEmpty ? _numberEC.text : address.number;
                                          final neighborhood = _neighborhoodEC.text.isNotEmpty ? _neighborhoodEC.text : address.neighborhood;
                                          _userViewmodel.updateUserDto(_userViewmodel.userDto.copyWith(
                                              address: address.copyWith(
                                            number: number,
                                            neighborhood: neighborhood,
                                            zipCode: address.zipCode.replaceIfEmpty(_zipCode.text),
                                          )));
                                          _searchFN.unfocus();
                                          _searchEC.text = address.mainText(LocaleNotifier.instance.locale);
                                          _numberEC.text = number;
                                          _zipCode.text = address.zipCode;
                                          _neighborhoodEC.text = neighborhood;
                                          _streetEC.text = address.street;
                                          _focusNodeNumber.requestFocus();
                                          setState(() {});
                                        },
                                        onError: (e, s) {
                                          e.catchInternalError((e) {
                                            final message = InternalExceptionHelper.getMessage(code: e.code, language: LocaleNotifier.instance.language);
                                            return banner.showError(message);
                                          });
                                        },
                                      );
                                    },
                                  ),
                                ),
                              // if (_searchEC.text.isEmpty || !(_userViewmodel.userDto.address?.isValid() ?? false) && !isGb) //
                              //   buildButtonAddressManually(context),
                            ],
                          );
                        }),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget buildHeader(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(context.i18n.digiteSeuEnderecoEntrega, style: context.textTheme.titleLarge),
        Text(context.i18n.naoAbrevieSeuEnderecoParaEvitarErros, style: context.textTheme.bodyMedium?.muted(context)),
      ],
    );
  }

  Widget buildSearchAddress(BuildContext context) {
    return CwTextFormFild.underlinded(
      label: context.i18n.endereco,
      hintText: context.i18n.hintBuscarEndereco,
      hintStyle: context.textTheme.titleMedium?.muted(context),
      style: context.textTheme.titleLarge,
      suffixIcon: IconButton(
          icon: Icon(_hasFocus ? PaipIcons.close : PaipIcons.search),
          onPressed: () {
            _searchEC.clear();
            _searchFN.unfocus();
            _viewmodel.reset();
            _userViewmodel.updateUserDto(_userViewmodel.userDto.copyWith(address: AddressEntity.empty()));
          }),
      focusNode: _searchFN,
      controller: _searchEC,
      onChanged: (value) {
        _viewmodel.autoComplete(query: value, latReference: _userViewmodel.establishmentAdress?.lat, lonReference: _userViewmodel.establishmentAdress?.long);
      },
      maskUtils: MaskUtils.cRequired(),
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }

  Widget buildFormAddress(BuildContext context) {
    return Column(
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (isGb) ...[
              PSize.ii.sizedBoxH,
              CwTextFormFild.underlinded(
                label: "Street*",
                style: context.textTheme.titleLarge,
                controller: _streetEC,
                onChanged: (value) {
                  _userViewmodel.updateUserDto(_userViewmodel.userDto.copyWith(address: _userViewmodel.userDto.address!.copyWith(street: value)));
                },
                maskUtils: MaskUtils.cRequired(),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                onFieldSubmitted: (value) => onSubmit(context),
              ),
            ],
            PSize.ii.sizedBoxH,
            Row(
              children: [
                SizedBox(
                  width: 90,
                  child: CwTextFormFild.underlinded(
                    label: "${context.i18n.numero}*",
                    style: context.textTheme.titleLarge,
                    focusNode: _focusNodeNumber,
                    controller: _numberEC,
                    onChanged: (value) {
                      _userViewmodel.updateUserDto(_userViewmodel.userDto.copyWith(address: _userViewmodel.userDto.address!.copyWith(number: value)));
                    },
                    maskUtils: MaskUtils.cRequired(),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    onFieldSubmitted: (value) => onSubmit(context),
                  ),
                ),
                PSize.iii.sizedBoxW,
                Expanded(
                  child: Visibility(
                    visible: isBr,
                    replacement: CwTextFormFild.underlinded(
                      label: "${context.i18n.cep}*",
                      style: context.textTheme.titleLarge,
                      controller: _zipCode,
                      onChanged: (value) {
                        _userViewmodel.updateUserDto(_userViewmodel.userDto.copyWith(address: _userViewmodel.userDto.address!.copyWith(zipCode: value)));
                      },
                      maskUtils: MaskUtils.cRequired(),
                      autovalidateMode: AutovalidateMode.disabled,
                      onFieldSubmitted: (value) => onSubmit(context),
                    ),
                    child: CwTextFormFild.underlinded(
                      label: "${context.i18n.bairro}*",
                      style: context.textTheme.titleLarge,
                      controller: _neighborhoodEC,
                      onChanged: (value) {
                        _userViewmodel.updateUserDto(_userViewmodel.userDto.copyWith(address: _userViewmodel.userDto.address!.copyWith(neighborhood: value)));
                      },
                      maskUtils: MaskUtils.cRequired(),
                      autovalidateMode: AutovalidateMode.disabled,
                      onFieldSubmitted: (value) => onSubmit(context),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        Column(
          children: [
            PSize.ii.sizedBoxH,
            CwTextFormFild.underlinded(
              label: context.i18n.complemento,
              hintText: context.i18n.hintComplementoEndereco,
              style: context.textTheme.titleLarge,
              initialValue: _userViewmodel.userDto.address?.complement,
              onChanged: (value) {
                _userViewmodel.updateUserDto(_userViewmodel.userDto.copyWith(address: _userViewmodel.userDto.address!.copyWith(complement: value)));
              },
              onFieldSubmitted: (value) => onSubmit(context),
            ),
          ],
        ),
        PSize.spacer.sizedBoxH,
      ],
    );
  }

  // Widget buildButtonAddressManually(BuildContext context) {
  //   return Padding(
  //     padding: PSize.iii.paddingVertical,
  //     child: Row(
  //       children: [
  //         Expanded(
  //           child: CwOutlineButton(
  //             label: context.i18n.inserirEnderecoManualmente.toUpperCase(),
  //             onPressed: () {
  //               Go.of(context).pushNeglect(Routes.searchAddressManually);
  //             },
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }
}
