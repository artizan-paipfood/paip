import 'package:flutter/material.dart';

import 'package:manager/l10n/i18n_extension.dart';
import 'package:manager/src/core/datasources/data_source.dart';
import 'package:manager/src/core/helpers/breakpoints.dart';
import 'package:manager/src/core/models/sync_model.dart';
import 'package:manager/src/core/components/container_shadow.dart';
import 'package:manager/src/core/components/header_card.dart';
import 'package:manager/src/core/components/inner_container.dart';
import 'package:manager/src/modules/menu/aplication/stores/menu_store.dart';
import 'package:manager/src/core/components/button_play_animated.dart';
import 'package:manager/src/modules/menu/presenters/components/categories/list_categories.dart';
import 'package:manager/src/modules/menu/presenters/components/complements/end_drawer_complement.dart';
import 'package:manager/src/modules/menu/presenters/components/complements/list_complements.dart';
import 'package:manager/src/modules/menu/presenters/components/categories/end_drawer_category.dart';
import 'package:paipfood_package/paipfood_package.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    final store = context.read<MenuStore>();

    return FutureState(
      future: store.init(),
      onComplete: (context, data) => CwContainerShadow(
        child: Column(
          children: [
            CwHeaderCard(
              actions: Row(
                children: [
                  ValueListenableBuilder(
                    valueListenable: syncRequest,
                    builder: (context, syncRequest, __) {
                      if (!syncRequest.menu) return const SizedBox.shrink();
                      return PButton(
                        icon: PaipIcons.refresh,
                        label: context.i18n.sincronizar,
                        color: context.color.tertiaryColor,
                        colorText: context.color.primaryBG,
                        onPressedFuture: () async {
                          Loader.show(context);
                          try {
                            await store.syncMenu();
                          } finally {
                            await Future.delayed(3.seconds, () => Loader.hide());
                          }
                        },
                      );
                    },
                  ),
                  PSize.i.sizedBoxW,
                  const ButtonPlayAnimated(),
                ],
              ),
              titleLabel: context.i18n.menu,
              description: context.i18n.descMenu,
            ),
            Expanded(
              child: CwInnerContainer(
                child: Row(
                  children: [
                    Expanded(
                      child: CwContainerShadow(
                        height: double.infinity,
                        child: Column(
                          children: [
                            CwHeaderCard(
                              titleLabel: context.i18n.categorias,
                              description: context.i18n.addCategoria,
                              actions: CwOutlineButton(
                                onPressed: () {
                                  final category = CategoryModel(id: uuid, index: store.categories.length, establishmentId: establishmentProvider.value.id, products: []);
                                  showDialog(context: context, builder: (context) => EndDrawerCategory(category: category));
                                },
                                label: context.i18n.adicionar,
                              ),
                            ),
                            ValueListenableBuilder(
                              valueListenable: store.rebuildCategories,
                              builder: (context, _, __) {
                                if (store.categories.where((element) => element.isDeleted == false).isEmpty) {
                                  return Expanded(child: CwInnerContainer(child: Center(child: CwEmptyState(size: 100, icon: PaipIcons.dropBox, bgColor: false, label: context.i18n.emptySateteCategorias))));
                                }
                                // ignore: prefer_const_constructors
                                return Expanded(child: ListCategories());
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    const CwSizedBox(),
                    CwContainerShadow(
                      width: PaipBreakpoint.desk.isBreakpoint(context) ? 400 : 350,
                      height: double.infinity,
                      child: Column(
                        children: [
                          CwHeaderCard(
                            titleLabel: context.i18n.complementos,
                            actions: CwOutlineButton(
                              onPressed: () {
                                store.complementSelected = ComplementModel(id: uuid, index: store.categories.length, establishmentId: establishmentProvider.value.id, items: []);
                                showDialog(context: context, builder: (context) => EndDrawerComplement(complement: store.complementSelected!));
                              },
                              label: context.i18n.adicionar,
                            ),
                          ),
                          ValueListenableBuilder(
                            valueListenable: store.rebuildComplements,
                            builder: (context, _, __) {
                              if (store.complements.where((element) => element.isDeleted == false && element.complementType == ComplementType.item).isEmpty) {
                                return Expanded(child: CwInnerContainer(child: Center(child: CwEmptyState(size: 100, icon: PaipIcons.dropBox, bgColor: false, label: context.i18n.emptySateteComplementos))));
                              }
                              // ignore: prefer_const_constructors
                              return Expanded(child: ListComplements());
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
