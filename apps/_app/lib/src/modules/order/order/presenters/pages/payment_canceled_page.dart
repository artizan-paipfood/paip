import 'package:flutter/material.dart';

import 'package:app/src/core/helpers/routes.dart';
import 'package:app/src/modules/order/order/aplication/stores/order_status_store.dart';
import 'package:paipfood_package/paipfood_package.dart';

class PaymentCanceledPage extends StatefulWidget {
  const PaymentCanceledPage({super.key});

  @override
  State<PaymentCanceledPage> createState() => _PaymentCanceledPageState();
}

class _PaymentCanceledPageState extends State<PaymentCanceledPage> {
  late final store = context.read<OrderStatusStore>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(color: context.color.errorColor, shape: BoxShape.circle),
            ),
          ).animate().scale(begin: const Offset(1, 1), end: const Offset(13, 13), duration: 3.seconds, curve: Curves.easeInOutQuart),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Container(
                  height: 100,
                  width: 100,
                  decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                  child: const Icon(PIcons.strokeRoundedCancel01, color: PColors.errorColorD_, size: 80),
                ),
              ).animate().scale(begin: const Offset(0, 0), end: const Offset(1, 1), curve: Curves.easeInOutBack, delay: 2.seconds),
              PSize.iii.sizedBoxH,
              Text('Erro ao efetuar pagamento', style: context.textTheme.titleLarge?.copyWith(color: Colors.white)).animate().fadeIn(delay: 2.5.seconds),
              PSize.iii.sizedBoxH,
              PButton(
                color: Colors.white,
                colorText: Colors.black,
                label: 'Voltar para o carrinho',
                onPressed: () {
                  Go.of(context).go(Routes.menu(establishmentId: store.establishment.companySlug));
                },
              ).animate().fadeIn(delay: 2.5.seconds)
            ],
          )
        ],
      ),
    );
  }
}
