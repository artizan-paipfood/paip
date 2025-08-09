import 'package:flutter/material.dart';

import 'package:paipfood_package/paipfood_package.dart';
import 'package:portal/src/modules/register/register/aplication/controllers/register_controller.dart';
import 'package:portal/src/modules/register/register/aplication/stores/register_store.dart';

class OperationModelPage extends StatefulWidget {
  const OperationModelPage({super.key});

  @override
  State<OperationModelPage> createState() => _OperationModelPageState();
}

class _OperationModelPageState extends State<OperationModelPage> {
  late final controller = context.read<RegisterController>();
  @override
  Widget build(BuildContext context) {
    RegisterStore store = controller.store;
    return SingleChildScrollView(
      child: Padding(
        padding: PSize.ii.paddingHorizontal,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text("Qual os modos de operação do ", style: context.textTheme.titleLarge),
                Text(store.establishment.fantasyName, style: context.textTheme.titleLarge!.copyWith(color: context.color.primaryColor)),
                Text("?", style: context.textTheme.titleLarge),
              ],
            ),
            Text("", style: context.textTheme.bodySmall),
            const SizedBox(height: 70),
            const CwTextFormFild(
              expanded: true,
              label: "Endereço do estabelecimento",
              prefixIcon: Icon(Icons.search),
            ),
            const CwTextFormFild(
              label: "Numero",
            ),
            const CwTextFormFild(
              expanded: true,
              label: "Complemento",
            ),
          ],
        ),
      ),
    );
  }
}
