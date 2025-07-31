import 'package:artizan_ui/artizan_ui.dart';
import 'package:flutter/material.dart';
import 'package:multiavatar/multiavatar.dart';
import 'package:core/core.dart';
import 'package:manager/l10n/i18n_extension.dart';
import 'package:manager/src/core/components/tag_widget.dart';
import 'package:manager/src/modules/order/aplication/stores/order_store.dart';
import 'package:manager/src/modules/order/presenter/components/details_card_order.dart';
import 'package:manager/src/modules/order/presenter/components/dialog_cancel_order.dart';
import 'package:manager/src/modules/order/presenter/components/dialog_set_delivery_man_to_order.dart';
import 'package:paipfood_package/paipfood_package.dart';

class CardOrder extends StatefulWidget {
  final OrderModel order;
  final Color color;
  final OrderStore store;
  final int index;
  final bool? isExpanded;
  final DriverAndUserAdapter? driver;
  final BillModel? bill;

  const CardOrder({required this.order, required this.color, required this.store, required this.index, this.isExpanded, this.driver, this.bill, super.key});

  @override
  State<CardOrder> createState() => _CardOrderState();
}

class _CardOrderState extends State<CardOrder> {
  late bool _isExpanded = widget.isExpanded ?? false;

  bool _isPressed = false;
  late DriverAndUserAdapter? _driver = widget.driver;

  @override
  Widget build(BuildContext context) {
    return ArtCard(
      padding: PSize.i.paddingAll,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: InkWell(
        borderRadius: PSize.i.borderRadiusAll,
        hoverColor: context.color.primaryBG,
        onTap: () => setState(() => _isExpanded = !_isExpanded),
        child: Ink(
          child: Column(
            children: [
              Row(
                children: [
                  Container(decoration: BoxDecoration(color: widget.color, borderRadius: PSize.i.borderRadiusAll), width: 8, height: 90),
                  PSize.i.sizedBoxW,
                  Expanded(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                if (widget.bill != null) TagWidget(label: '${context.i18n.mesa} ${widget.bill!.tableNumber}'.toUpperCase(), colorSelected: Colors.red),
                                if (widget.bill == null) TagWidget(label: widget.order.orderType!.i18nText.i18n().toUpperCase(), colorSelected: widget.order.orderType!.color),
                                PSize.i.sizedBoxW,
                              ],
                            ),
                            Text("${context.i18n.pedido} #${widget.order.getOrderNumber}"),
                          ],
                        ),
                        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text(widget.order.customer.name.toUpperCase(), style: context.textTheme.bodySmall), Text(widget.order.amount.toStringCurrency)]),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                "${context.i18n.telefone.toUpperCase()}: ${widget.order.customer.phone}\n${widget.order.orderType == OrderTypeEnum.delivery ? widget.order.customer.address?.formattedAddress(LocaleNotifier.instance.locale) ?? ' -- ' : " -- "}",
                                style: context.textTheme.bodySmall,
                              ),
                            ),
                            PSize.i.sizedBoxW,
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                if (widget.bill != null) const CircleAvatar(backgroundColor: Colors.red, child: Icon(PIcons.strokeRoundedTable02, color: Colors.white)),
                                0.5.sizedBoxH,
                                if (widget.order.paymentType != null) TagWidget(label: widget.order.paymentType!.name.i18n().toUpperCase(), colorSelected: context.color.neutral500),
                              ],
                            ),
                          ],
                        ),
                        PSize.i.sizedBoxH,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(widget.order.createdAtFormated, style: context.textTheme.labelLarge),
                                PSize.i.sizedBoxW,
                                if (widget.order.charge != null && widget.order.charge!.status == ChargeStatus.paid) TagWidget(label: context.i18n.pago.toUpperCase(), colorSelected: Colors.green),
                                PSize.i.sizedBoxW,
                                if (widget.order.isScheduling)
                                  Tooltip(
                                    message: "${context.i18nCore.agendadoPara} \n${widget.order.buildScheduleTimeFormated(context)}",
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        DecoratedBox(decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(100)), child: const Padding(padding: EdgeInsets.all(3), child: Icon(PIcons.strokeRoundedAlarmClock, color: Colors.white, size: 16))),
                                        PSize.i.sizedBoxW,
                                        TagWidget(label: widget.order.buildScheduleTimeFormated(context).toUpperCase(), colorSelected: context.color.neutral500),
                                      ],
                                    ),
                                  ),
                              ],
                            ),
                            Row(
                              children: [
                                if (widget.order.status != OrderStatusEnum.canceled && widget.order.status != OrderStatusEnum.losted && widget.order.status != OrderStatusEnum.delivered)
                                  Visibility(
                                    visible: _isPressed == false,
                                    child: ArtIconButton.secondary(
                                      onPressed: () async {
                                        if (_isPressed) return;
                                        if (widget.order.dontSchedulingAllowNextStatus) {
                                          toast.showInfo(context.i18n.infoPedidoForaPeriodoAgendamento);
                                          return;
                                        }

                                        _isPressed = true;
                                        await widget.store.nextStatus(order: widget.order);
                                        _isPressed = false;
                                      },
                                      icon: const Icon(Icons.arrow_forward),
                                    ),
                                    // style: IconButton.styleFrom(backgroundColor: context.color.surface.withOpacity(0.5))),
                                  ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              if (_isExpanded)
                DetailsCardOrder(
                  order: widget.order,
                  onPrintOrder: () {
                    setState(() {
                      widget.store.printerViewmodel.printOrder(order: widget.order);
                      _isExpanded = false;
                    });
                  },
                  onCancelOrder: () {
                    showDialog(context: context, builder: (context) => DialogCancelOrder(order: widget.order, store: widget.store));
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildDriver(BuildContext context) {
    if (_driver == null) {
      return IconButton(
        tooltip: context.i18n.selecionarEntregador.toUpperCase(),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => DialogSetDriverToOrder(
              deliveryMen: widget.store.getDeliveryMen,
              onSelected: (driver) async {
                setState(() => _driver = driver);
                Loader.show(context);
                await widget.store.setDriverToOrder(order: widget.order, driver: driver);
                Loader.hide();
              },
            ),
          );
        },
        icon: const Icon(PaipIcons.scooter),
      );
    }
    return Tooltip(message: _driver!.user.name, child: CircleAvatar(radius: 16.0, backgroundColor: context.color.onPrimaryBG, child: _driver!.user.name.isNotEmpty ? SvgPicture.string(multiavatar(_driver!.user.name)) : const SizedBox.shrink()));
  }

  // Widget buildDeliveryWaiter(BuildContext context) {
  //   return IconButton(
  //     onPressed: () {
  //       showDialog(
  //           context: context,
  //           builder: (context) => DialogCourierStatus(
  //                 store: widget.store,
  //                 order: widget.order,
  //               ));
  //     },
  //     icon: const Icon(PaipIcons.scooter),
  //   );
  // }
}
