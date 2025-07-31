import 'package:flutter/material.dart';
import 'package:manager/src/modules/table/aplication/stores/order_command_store.dart';
import 'package:manager/src/modules/table/presenter/components/edit_order_command_component.dart';
import 'package:paipfood_package/paipfood_package.dart';

class OrderCommandViewComponent extends StatelessWidget {
  final OrderCommandStore store;
  const OrderCommandViewComponent({
    required this.store,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
        listenable: store,
        builder: (context, _) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Padding(
                  padding: PSize.i.paddingAll,
                  child: SingleChildScrollView(
                    child: Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      children: store.orderCommands
                          .map((orderSheet) => Container(
                                height: 150,
                                width: 130,
                                decoration: BoxDecoration(color: PColors.light.neutral600, borderRadius: 0.5.borderRadiusAll),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                              child: ColoredBox(
                                                  color: Colors.white,
                                                  child: Text(
                                                    orderSheet.number.toString(),
                                                    style: context.textTheme.displayLarge?.copyWith(color: Colors.black),
                                                    textAlign: TextAlign.center,
                                                  ))),
                                        ],
                                      ),
                                      PSize.ii.sizedBoxH,
                                      const Icon(
                                        PIcons.strokeRoundedQrCode,
                                        color: Colors.white,
                                        size: 50,
                                      )
                                    ],
                                  ),
                                ),
                              ))
                          .toList(),
                    ),
                  ),
                ),
              ),
              Container(
                color: context.color.neutral50,
                width: 220,
                height: double.infinity,
                child: Padding(
                    padding: PSize.i.paddingAll,
                    child: EditOrderCommandComponent(
                        onNewSheet: () {
                          store.addComand();
                        },
                        onDelete: () {
                          store.deleteComand();
                        },
                        length: store.orderCommands.length)),
              ),
            ],
          );
        });
  }
}
