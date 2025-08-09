import 'package:flutter/material.dart';

import 'package:manager/l10n/i18n_extension.dart';
import 'package:manager/src/core/components/container_shadow.dart';
import 'package:manager/src/core/components/padding_page.dart';
import 'package:manager/src/core/components/header_card.dart';
import 'package:manager/src/modules/config/sub_modules/payments/presenters/components/stripe_card_component.dart';
import 'package:manager/src/modules/config/sub_modules/payments/presenters/viewmodels/payments_viewmodel.dart';
import 'package:manager/src/modules/config/sub_modules/payments/presenters/components/payment_methods_component.dart';
import 'package:manager/src/modules/config/sub_modules/payments/presenters/viewmodels/stripe_card_component_viewmodel.dart';
import 'package:paipfood_package/paipfood_package.dart';

class PaymentsPage extends StatefulWidget {
  const PaymentsPage({super.key});

  @override
  State<PaymentsPage> createState() => _PaymentsPageState();
}

class _PaymentsPageState extends State<PaymentsPage> {
  late final viewmodel = context.read<PaymentsViewmodel>();
  late final mercadoPagoRepo = context.read<MercadoPagoRepository>();
  late final stripeCardComponentViewmodel = context.read<StripeCardComponentViewmodel>();

  late Future<Status> _load;

  @override
  void initState() {
    _load = viewmodel.load();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureState(
      future: _load,
      onComplete: (context, data) => SingleChildScrollView(
        child: CwPaddingPage(
          child: Column(
            children: [
              CwContainerShadow(
                width: double.infinity,
                child: Column(
                  children: [
                    CwHeaderCard(
                      titleLabel: context.i18n.formasPagamento,
                      actions: PButton(
                        label: context.i18n.salvar,
                        onPressed: () async {
                          try {
                            Loader.show(context);
                            await viewmodel.save();
                            if (context.mounted) {
                              toast.showSucess(context.i18n.alteracoesSalvas);
                            }
                          } catch (e) {
                            toast.showError(e.toString());
                          } finally {
                            Loader.hide();
                          }
                        },
                      ),
                    ),
                    PaymentMethodsComponent(store: viewmodel),
                  ],
                ),
              ),
              PSize.iii.sizedBoxH,
              StripeCardComponent(viewmodel: stripeCardComponentViewmodel),
            ],
          ),
        ),
      ),
    );
  }
}
