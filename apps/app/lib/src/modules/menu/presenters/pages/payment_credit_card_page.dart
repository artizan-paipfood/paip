import 'package:flutter/material.dart';
import 'package:paipfood_package/paipfood_package.dart';

class PaymentCreditCardPage extends StatelessWidget {
  const PaymentCreditCardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('CREDIT CARD'),
        ),
        body: Padding(
          padding: PSize.ii.paddingAll,
          child: Column(
            children: [
              const CwTextFormFild(
                label: "E-MAIL",
                hintText: "name@email.com",
              ),
              PSize.i.sizedBoxH,
              const CwTextFormFild(
                label: "NUMERO DO CARTÃO",
                hintText: "XXXX XXXX XXXX XXXX",
              ),
              PSize.i.sizedBoxH,
              const CwTextFormFild(
                label: "NOME DO TITULAR",
                hintText: "",
              ),
              PSize.i.sizedBoxH,
              Row(
                children: [
                  const CwTextFormFild(
                    label: "DATA DE EXPIRAÇÃO",
                    hintText: "MM/YY",
                    expanded: true,
                  ),
                  PSize.iii.sizedBoxW,
                  const CwTextFormFild(
                    label: "CODIGO DE SEGURANÇA",
                    hintText: "XXX",
                    expanded: true,
                  )
                ],
              ),
              PSize.iii.sizedBoxH,
              const Row(
                children: [
                  Expanded(
                    child: PButton(
                      label: "PAGAR",
                      icon: PIcons.strokeRoundedLock,
                    ),
                  )
                ],
              )
            ],
          ),
        ));
  }
}
