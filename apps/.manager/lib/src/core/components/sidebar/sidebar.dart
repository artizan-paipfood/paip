import 'package:flutter/material.dart';

import 'package:manager/l10n/i18n_extension.dart';
import 'package:manager/src/core/components/sidebar/sidebar_menus.dart';
import 'package:manager/src/core/datasources/data_source.dart';
import 'package:manager/src/core/helpers/assets.dart';
import 'package:manager/src/core/helpers/routes.dart';
import 'package:manager/src/core/services/establishment_service.dart';
import 'package:manager/src/core/services/update_service.dart';
import 'package:manager/src/core/components/dialog_logs.dart';
import 'package:manager/src/core/components/sidebar/card_closed.dart';
import 'package:manager/src/core/components/sidebar/card_open.dart';
import 'package:paipfood_package/paipfood_package.dart';
import '../header_navibar.dart';
part 'sidebar_menu.dart';
part 'sidebar_sub_menu.dart';
part 'sidebar_controller.dart';

class Sidebar extends StatefulWidget {
  final Widget? header;

  final Widget? bottom;
  const Sidebar({super.key, this.header, this.bottom});

  @override
  State<Sidebar> createState() => _SidebarState();
}

class _SidebarState extends State<Sidebar> {
  late final controller = SidebarController.instance;
  final themeNotier = ThemeNotifier.instance;
  final authNotifier = AuthNotifier.instance;
  late final establishmentService = context.read<EstablishmentService>();
  late final updateService = context.read<UpdateService>();
  late final dataSource = context.read<DataSource>();
  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: Listenable.merge([controller, establishmentService]),
      builder: (context, _) {
        if (controller.isHide) return const SizedBox.shrink();
        return Stack(
          alignment: Alignment.topRight,
          children: [
            Container(
              constraints: const BoxConstraints(minWidth: 10, maxWidth: 180),
              decoration: BoxDecoration(color: context.color.primaryBG, boxShadow: [BoxShadow(blurRadius: 5, color: Colors.black.withOpacity(0.1), offset: const Offset(1, 0), spreadRadius: 0.2)]),
              child: Column(
                children: [
                  ValueListenableBuilder(
                    valueListenable: establishmentProvider,
                    builder: (context, _, __) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                        child: controller.isCollapsed
                            ? HeaderNavibar(establishmentService: establishmentService, establishment: establishmentProvider.value)
                            : establishmentProvider.value.isOpen
                                ? CardOpen(establishmentService: establishmentService, establishment: establishmentProvider.value)
                                : CardClosed(establishmentService: establishmentService),
                      );
                    },
                  ),
                  Expanded(child: SizedBox(child: SingleChildScrollView(child: SidebarMenus()))),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Transform.rotate(
                        angle: controller.isCollapsed ? 0 : -1.57,
                        child: CwSwitchLightDark(
                          isDarkMode: context.isDarkTheme,
                          onChanged: (value) {
                            themeNotier.toggleMode();
                          },
                        ),
                      ),
                      PSize.i.sizedBoxH,
                      Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: InkWell(
                          onLongPress: () {
                            showDialog(context: context, builder: (context) => DialogLogs());
                          },
                          child: DecoratedBox(
                            // color: Colors.black,
                            decoration: BoxDecoration(color: context.color.neutral100, borderRadius: PSize.i.borderRadiusAll),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(children: [SvgPicture.asset(PImages.logo, fit: BoxFit.fitHeight, height: 30), 0.5.sizedBoxH, Text(updateService.getCurrentVersion(), style: context.textTheme.bodySmall?.copyWith(fontSize: 10))]),
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        tooltip: context.i18n.sair,
                        icon: const Icon(PaipIcons.logout),
                        onPressed: () async {
                          final logout = await showDialog(
                            context: context,
                            builder: (context) => AlertDialog(title: Text(context.i18n.descDialogLogout), actions: [CwTextButton(label: context.i18n.sim.toUpperCase(), colorText: context.color.primaryColor, onPressed: () => Navigator.of(context).pop(true))]),
                          );
                          if (logout ?? false) {
                            await authNotifier.logout();
                            if (context.mounted) context.go(Routes.login);
                          }
                        },
                      ),
                    ],
                  ),
                  PSize.i.sizedBoxH,
                ],
              ),
            ),
            Align(
              alignment: AlignmentDirectional.topEnd,
              child: Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Builder(
                  builder: (context) {
                    return InkWell(
                      borderRadius: BorderRadius.circular(100),
                      onTap: () => controller.toggleCollapse(),
                      child: DecoratedBox(decoration: const BoxDecoration(shape: BoxShape.circle, color: PColors.primaryColor_), child: Icon(controller.isCollapsed ? PaipIcons.arrowLeft : PaipIcons.arrowRight, color: Colors.white, size: 20)),
                    );
                  },
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
