import 'package:flutter/material.dart';

import 'package:app/l10n/l18n_extension.dart';
import 'package:app/src/core/helpers/breakpoints.dart';
import 'package:app/src/core/helpers/routes.dart';
import 'package:app/src/core/web/seo.dart';
import 'package:app/src/core/ui/responsive_temp_page.dart';
import 'package:app/src/modules/menu/presenters/view_models/menu_viewmodel.dart';
import 'package:app/src/modules/menu/presenters/components/info_establishment.dart';
import 'package:app/src/modules/menu/presenters/components/list_categories_menu.dart';
import 'package:app/src/modules/menu/presenters/components/modal_select_order_type.dart';
import 'package:app/src/modules/menu/presenters/components/name_logo_establishment.dart';
import 'package:app/src/modules/user/presenters/viewmodels/user_store.dart';
import 'package:paipfood_package/paipfood_package.dart';

class MenuPage extends StatefulWidget {
  final String establishmentId;
  const MenuPage({super.key, required this.establishmentId});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> with WidgetsBindingObserver {
  late final store = context.read<MenuViewmodel>();
  late final userStore = context.read<UserStore>();
  var innerBoxIsScrolled0 = ValueNotifier(false);
  late final h = MediaQuery.sizeOf(context).height;

  @override
  void initState() {
    _init = store.initializeEstablishment(context, establishmentId: widget.establishmentId);
    WidgetsBinding.instance.addObserver(this);
    loadSeo(description: 'PaipFood - Menu', ogTitle: 'PaipFood - Menu');
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  late Future<StateData> _init;

  @override
  Widget build(BuildContext context) {
    final w = PaipBreakpoint.phone.isBreakpoint(context) ? context.w : responsiveTempWidth;
    return Scaffold(
      backgroundColor: context.color.primaryBG,
      body: FutureState(
        future: _init,
        onError: (context, error) => CwErrorWidget(details: FlutterErrorDetails(exception: error as StateError), messageError: 'Load menu error ${widget.establishmentId} \n\n$error'),
        onComplete: (context, data) => NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            innerBoxIsScrolled0.value = innerBoxIsScrolled;
            return [
              SliverAppBar(
                expandedHeight: 255 + w * 0.5,
                pinned: true,
                floating: true,
                forceElevated: true,
                automaticallyImplyLeading: false,
                leading: (!innerBoxIsScrolled && context.canPop()) ? const CwIconButtonAppBar() : null,
                title: innerBoxIsScrolled
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 0),
                            child: Material(
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              borderRadius: 100.0.borderRadiusAll,
                              child: Visibility(
                                visible: store.establishment.logo != null,
                                replacement: ColoredBox(color: context.color.black),
                                child: CachedNetworkImage(cacheKey: store.establishment.cacheKeyLogo, imageUrl: store.establishment.logoPath?.buildPublicUriBucket ?? '', fit: BoxFit.cover, height: 40, width: 40),
                              ),
                            ),
                          ).animate().scale(),
                          Text(store.establishment.fantasyName),
                          const SizedBox.shrink(),
                        ],
                      )
                    : null,
                flexibleSpace: FlexibleSpaceBar(
                  stretchModes: const [StretchMode.zoomBackground],
                  background: Stack(
                    children: [
                      if (store.establishment.bannerPath != null) CachedNetworkImage(cacheKey: store.establishment.cacheKeybanner, fit: BoxFit.cover, imageUrl: store.establishment.bannerPath?.buildPublicUriBucket ?? PImageBucket.emptyBanner, height: w / 3),
                      Padding(padding: EdgeInsets.only(top: w / 3 * 0.5), child: Column(children: [NameLogoEstablishment(store: store, imageSize: w * 0.35), InfoEstablishment(store: store), PSize.ii.sizedBoxH])),
                    ],
                  ),
                ),
              ),
            ];
          },
          body: Column(
            children: [
              Expanded(
                child: CustomScrollView(
                  slivers: [
                    SliverList(
                      delegate: SliverChildBuilderDelegate((context, index) {
                        final category = store.categories[index];
                        if (category.products.isEmpty) return const SizedBox.shrink();
                        return ListCategoriesMenu(categoryModel: category);
                      }, childCount: store.categories.length),
                    ),
                  ],
                ),
              ),
              ListenableBuilder(
                listenable: store,
                builder: (context, _) {
                  if (store.orderViewmodel.qtyCartProduct < 1) return const SizedBox.shrink();
                  return Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Hero(
                            tag: context.i18n.total,
                            child: PButton(
                              label: "${context.i18n.qtyMaisLabelBotaoVerCarrinho(store.orderViewmodel.qtyCartProduct).toUpperCase()} | ${store.orderViewmodel.order.getSubTotal.toStringCurrency}",
                              onPressed: () {
                                if (store.minimumOrderNotReached) {
                                  banner.showError(context.i18n.pedidoMinimoNaoAtingido(store.establishment.minimunOrder.toStringCurrency).toUpperCase());
                                  return;
                                }
                                if (!store.establishment.isOpen) {
                                  banner.showInfo(context.i18n.estabelecimentoNaoEstaAbertoNoMomento);
                                  return;
                                }
                                if (AuthNotifier.instance.auth.user != null) {
                                  context.push(Routes.cart(establishmentId: store.establishment.id));
                                  return;
                                }
                                showModalBottomSheet(context: context, builder: (context) => ModalSelectOrderType(menuViewmodel: store, userStore: userStore));
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
