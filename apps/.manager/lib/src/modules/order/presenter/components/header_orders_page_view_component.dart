import 'package:flutter/material.dart';
import 'package:manager/l10n/i18n_extension.dart';
import 'package:manager/src/core/components/button_hide_navbar_widget.dart';
import 'package:manager/src/core/services/real_time/realtime_status_widget.dart';
import 'package:manager/src/core/services/real_time/update_queus_realtime_service.dart';
import 'package:manager/src/modules/order/presenter/orders_page.dart';
import 'package:manager/src/modules/table/presenter/components/p_toggle_nivel_widget.dart';
import 'package:paipfood_package/paipfood_package.dart';

class HeaderOrdersPageViewComponent extends StatefulWidget {
  final void Function() onTapOrders;
  final void Function() onTapTables;
  final void Function() onTapCommand;
  final void Function() onSale;
  final PageViewOrders selectedPage;
  final UpdateQueusRealtimeService? realtimeService;

  const HeaderOrdersPageViewComponent({required this.onTapOrders, required this.onTapTables, required this.onTapCommand, required this.onSale, this.selectedPage = PageViewOrders.orders, this.realtimeService, super.key});

  @override
  State<HeaderOrdersPageViewComponent> createState() => _HeaderOrdersPageViewComponentState();
}

class _HeaderOrdersPageViewComponentState extends State<HeaderOrdersPageViewComponent> {
  PToggleNivelStyle get _headerDarkStyle => PToggleNivelStyle(textColor: PColors.light.white, selectedTextColor: PColors.light.white, backgroundColor: PColors.light.neutral900, selectedBackgroundColor: PColors.light.neutral800, selectedHoverColor: PColors.light.neutral950);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: PColors.light.neutral900,
          width: double.infinity,
          child: Padding(
            padding: PSize.i.paddingHorizontal,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(padding: const EdgeInsets.only(bottom: 8), child: ButtonHideNavbarWidget(backgroundColor: PColors.light.neutral700, iconColor: Colors.white)),
                PSize.ii.sizedBoxW,
                // 🔄 INDICADOR DE STATUS REAL-TIME
                if (widget.realtimeService != null) ...[
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12, right: 12),
                    child: RealtimeStatusIndicator(realtimeService: widget.realtimeService!),
                  ),
                ],
                Padding(padding: const EdgeInsets.only(right: 8), child: PToggleNivelWidget(isSelected: widget.selectedPage == PageViewOrders.orders, label: context.i18n.pedidos, onTap: widget.onTapOrders, style: _headerDarkStyle)),
                Padding(padding: const EdgeInsets.only(right: 8), child: PToggleNivelWidget(isSelected: widget.selectedPage == PageViewOrders.tables, label: context.i18n.mesas, onTap: widget.onTapTables, style: _headerDarkStyle)),
                // Padding(
                //   padding: const EdgeInsets.only(right: 8),
                //   child: PToggleNivelWidget(
                //     isSelected: widget.selectedPage == PageViewOrders.command,
                //     label: context.i18n.comandas,
                //     onTap: widget.onTapCommand,
                //     style: _headerDarkStyle,
                //   ),
                // ),
                PSize.ii.sizedBoxW,
                const Expanded(child: SizedBox()),
                // 📊 WIDGET DE STATUS DETALHADO (opcional)
                if (widget.realtimeService != null && widget.selectedPage == PageViewOrders.orders) ...[
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8, top: 8, right: 12),
                    child: RealtimeStatusWidget(realtimeService: widget.realtimeService!),
                  ),
                ],
                Padding(padding: const EdgeInsets.only(bottom: 8, top: 8), child: PButton(color: Colors.white, label: context.i18n.venda.toUpperCase(), icon: PIcons.strokeRoundedCashier, colorText: Colors.black, onPressed: widget.onSale)),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
