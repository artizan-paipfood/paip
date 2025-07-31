import 'package:core_flutter/core_flutter.dart';
import 'package:flutter/material.dart';

import 'package:manager/l10n/i18n_extension.dart';
import 'package:manager/src/core/components/sidebar/sidebar.dart';
import 'package:manager/src/core/helpers/routes.dart';
import 'package:paipfood_package/paipfood_package.dart';

class SidebarMenus extends StatefulWidget {
  const SidebarMenus({super.key});

  @override
  State<SidebarMenus> createState() => _SidebarMenusState();
}

class _SidebarMenusState extends State<SidebarMenus> {
  late final controller = SidebarController.instance;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SidebarMenu(
          id: Routes.configModule,
          icon: PaipIcons.bag,
          label: context.i18n.definicoes,
          onTap: () {
            controller.toggleMenu(id: Routes.configModule, containSubmenus: true);
          },
          subMenus: [
            SideBarSubMenu(
              label: context.i18n.aparencia,
              id: Routes.aparence,
              onTap: () {
                context.go(Routes.aparence);
              },
            ),
            SideBarSubMenu(
              label: context.i18n.informacoes,
              id: Routes.information,
              onTap: () {
                context.go(Routes.information);
              },
            ),
            SideBarSubMenu(
              label: context.i18n.horaioFuncionamento,
              id: Routes.openingHours,
              onTap: () {
                context.go(Routes.openingHours);
              },
            ),
            SideBarSubMenu(
              label: context.i18n.formasPagamento,
              id: Routes.paymentTypes,
              onTap: () {
                context.go(Routes.paymentTypes);
              },
            ),
            SideBarSubMenu(
              label: context.i18n.impressao,
              id: Routes.printer,
              onTap: () {
                context.go(Routes.printer);
              },
            ),
            SideBarSubMenu(
              label: context.i18n.preferencias,
              id: Routes.preferences,
              onTap: () {
                context.go(Routes.preferences);
              },
            ),
          ],
        ),
        SidebarMenu(
          id: Routes.reportsModule,
          icon: PaipIcons.analytics,
          label: context.i18n.relatorios,
          onTap: () => controller.toggleMenu(id: Routes.reportsModule, containSubmenus: true),
          subMenus: [
            SideBarSubMenu(
              label: context.i18n.vendasDoDia,
              id: Routes.reports,
              onTap: () {
                context.go(Routes.reports);
              },
            ),
          ],
        ),
        //TODO: PREVENTIVO TRATAR DA MELHOR FORMA POSTERIORMENTE
        if (isDesktop || isWeb)
          SidebarMenu(
            id: Routes.deliveryAreasModule,
            icon: PaipIcons.location,
            label: context.i18n.areasEntrega,
            onTap: () {
              context.go(Routes.deliveryAreas);
              controller.toggleMenu(id: Routes.deliveryAreasModule);
            },
          ),

        SidebarMenu(
          id: Routes.menuModule,
          icon: PaipIcons.book,
          label: context.i18n.menu,
          onTap: () {
            context.go(Routes.menu);
            controller.toggleMenu(id: Routes.menuModule);
          },
        ),
        SidebarMenu(
          id: Routes.robotsModule,
          icon: PaipIcons.whatsApp,
          label: context.i18n.automacoes,
          onTap: () {
            context.go(Routes.robots);
            controller.toggleMenu(id: Routes.robotsModule);
          },
        ),
        SidebarMenu(
          id: Routes.ordersModule,
          icon: PaipIcons.receipt,
          label: context.i18n.pedidos,
          onTap: () {
            context.go(Routes.orders);
            controller.toggleMenu(id: Routes.ordersModule);
          },
        ),
        // MenuNav(
        //   moduleRoute: Routes.deliverymen.moduleR,
        //   icon: PaipIcons.scooter,
        //   label: context.i18n.entregadores,
        //   route: Routes.deliverymen.route,
        // ),
        // MenuNav(
        //   moduleRoute: Routes.pdv.moduleR,
        //   icon: PaipIcons.cashier,
        //   label: context.i18n.pdv,
        //   route: Routes.pdv.route,
        // ),
      ],
    );
  }
}
