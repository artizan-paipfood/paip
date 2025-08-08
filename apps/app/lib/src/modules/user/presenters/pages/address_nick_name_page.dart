import 'package:flutter/material.dart';
import 'package:app/l10n/l18n_extension.dart';
import 'package:app/src/core/helpers/routes.dart';
import 'package:app/src/core/notifiers/delivery_area_notifier.dart';
import 'package:app/src/modules/user/presenters/viewmodels/user_store.dart';
import 'package:paipfood_package/paipfood_package.dart';

class AddressNickNamePage extends StatefulWidget {
  const AddressNickNamePage({super.key});

  @override
  State<AddressNickNamePage> createState() => _AddressNickNamePageState();
}

class _AddressNickNamePageState extends State<AddressNickNamePage> {
  late final userViewmodel = context.read<UserStore>();
  late final deliveryAreaNotifier = context.read<DeliveryAreaNotifier>();
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    // Carregar o cache para garantir que o endereço seja inicializado
    userViewmodel.loadCache();
  }

  Future<void> _onSubmit() async {
    if (formKey.currentState?.validate() ?? false) {
      if (userViewmodel.navigationMode.isEditAddress) {
        try {
          Loader.show(context);
          final address = await userViewmodel.userAddressUsecase.saveNewAddress(address: userViewmodel.userDto.address!);
          userViewmodel.updateUserDto(userViewmodel.userDto.copyWith(address: address));

          await deliveryAreaNotifier.loadDeliveryTax(address: userViewmodel.userDto.address!, establishmentAddress: userViewmodel.establishmentAdress!, deliveryMethod: deliveryAreaNotifier.deliveryMethod!);

          if (mounted) {
            userViewmodel.navigateFinish(context);
          }
        } catch (e) {
          e.catchInternalError((e) {
            final message = InternalExceptionHelper.getMessage(code: e.code, language: LocaleNotifier.instance.language);
            return banner.showError(message);
          });
        } finally {
          Loader.hide();
        }

        return;
      }
      Go.of(context).pushNeglect(Routes.name);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.color.primaryBG,
      floatingActionButton: FloatingActionButton(onPressed: () => _onSubmit(), child: const Icon(Icons.arrow_forward)),
      appBar: AppBar(),
      body: Form(
        key: formKey,
        child: Padding(
          padding: PSize.ii.paddingHorizontal,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(context.i18n.deUmApelidoParaSeuEndereco, style: context.textTheme.titleLarge),
              CwTextFormFild.underlinded(
                hintText: context.i18n.apelidoEnderecoHint,
                style: context.textTheme.titleLarge,
                initialValue: userViewmodel.userDto.address?.nickName,
                autofocus: true,
                autocorrect: true,
                maskUtils: MaskUtils.cRequired(),
                keyboardType: TextInputType.name,
                onChanged: (value) {
                  userViewmodel.updateUserDto(userViewmodel.userDto.copyWith(address: userViewmodel.userDto.address!.copyWith(nickName: value)));
                },
                onFieldSubmitted: (value) => _onSubmit(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
