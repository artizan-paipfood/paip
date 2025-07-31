import 'package:app/src/core/helpers/command.dart';
import 'package:flutter/material.dart';
import 'package:app/l10n/l18n_extension.dart';

import 'package:app/src/core/helpers/routes.dart';
import 'package:app/src/core/notifiers/delivery_area_notifier.dart';
import 'package:app/src/modules/user/presenters/viewmodels/user_store.dart';
import 'package:app/src/modules/user/presenters/components/dialog_delete_address.dart';
import 'package:app/src/modules/user/presenters/components/list_tile_address.dart';

import 'package:paipfood_package/paipfood_package.dart';

class ListAdressPage extends StatefulWidget {
  const ListAdressPage({super.key});

  @override
  State<ListAdressPage> createState() => _ListAdressPageState();
}

class _ListAdressPageState extends State<ListAdressPage> {
  final formKey = GlobalKey<FormState>();
  late final userViewmodel = context.read<UserStore>();
  late final deliveryAreaNotifier = context.read<DeliveryAreaNotifier>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(elevation: 8, shadowColor: Colors.black.withOpacity(0.3), title: Text(context.i18n.meusEnderecos), centerTitle: true),
      body: Form(
        key: formKey,
        child: ValueListenableBuilder<AuthModel>(
          valueListenable: AuthNotifier.authNotifer,
          builder: (context, auth, _) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PSize.ii.sizedBoxH,
                Expanded(
                  child: ListView.builder(
                    itemCount: auth.user?.addresses.length ?? 0,
                    itemBuilder: (context, index) {
                      if (auth.user?.addresses == null || auth.user!.addresses.isEmpty) {
                        return const SizedBox.shrink();
                      }
                      bool isSelected = auth.user!.currentAddressId == auth.user!.addresses[index].id;
                      return Padding(
                        padding: PSize.ii.paddingHorizontal + PSize.spacer.paddingBottom,
                        child: ListTileAddress(
                          address: auth.user!.addresses[index],
                          isSelected: isSelected,
                          onTap: () async {
                            Command0.executeWithLoader(
                              context,
                              () async {
                                await deliveryAreaNotifier.loadDeliveryTax(
                                  address: auth.user!.addresses[index],
                                  establishmentAddress: userViewmodel.establishmentAdress!,
                                  deliveryMethod: deliveryAreaNotifier.deliveryMethod!,
                                );
                                await userViewmodel.userAddressUsecase.updatePrincipalAddress(auth.user!.addresses[index].id);

                                if (context.mounted) {
                                  Go.of(context).go(Routes.cart(establishmentId: userViewmodel.establishmentId!));
                                }
                              },
                              onError: (e, s) {
                                e.catchInternalError((e) {
                                  final message = InternalExceptionHelper.getMessage(code: e.code, language: LocaleNotifier.instance.language);
                                  return banner.showError(message);
                                });
                              },
                            );
                          },
                          onDelete: () {
                            showDialog(
                              context: context,
                              builder: (context) => DialogDeleteAddress(
                                onDelete: () async {
                                  try {
                                    Loader.show(context);
                                    await userViewmodel.userAddressUsecase.deleteAddress(auth.user!.addresses[index]);
                                  } catch (e) {
                                    banner.showError(e.toString());
                                  } finally {
                                    Loader.hide();
                                  }
                                },
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),
                ColoredBox(
                  color: context.color.primaryBG,
                  child: Padding(
                    padding: PSize.ii.paddingAll,
                    child: Row(
                      children: [
                        Expanded(
                          child: PButton(
                            label: context.i18n.adicionarEndereco.toUpperCase(),
                            onPressed: () {
                              Go.of(context).pushNeglect(Routes.searchAddress);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
