import 'package:flutter/material.dart';

import 'package:core/core.dart';
import 'package:manager/l10n/i18n_extension.dart';
import 'package:manager/src/core/helpers/assets.dart';
import 'package:manager/src/core/helpers/routes.dart';
import 'package:manager/src/core/components/container_shadow.dart';
import 'package:manager/src/core/components/header_card.dart';

import 'package:manager/src/modules/config/sub_modules/payments/presenters/viewmodels/stripe_card_component_viewmodel.dart';
import 'package:paipfood_package/paipfood_package.dart';

class StripeCardComponent extends StatefulWidget {
  final StripeCardComponentViewmodel viewmodel;

  const StripeCardComponent({required this.viewmodel, super.key});

  @override
  State<StripeCardComponent> createState() => _StripeCardComponentState();
}

class _StripeCardComponentState extends State<StripeCardComponent> {
  late Future<Status> _load;
  @override
  void initState() {
    _load = widget.viewmodel.load();
    super.initState();
  }

  PaymentProviderStripeEntity? get stripe => widget.viewmodel.paymentProvider?.stripe;

  PaymentProviderAccountStatus get status => stripe?.status ?? PaymentProviderAccountStatus.pending;

  Future<void> _onConectStripe() async {
    try {
      Loader.show(context);
      final result = await widget.viewmodel.createAccount();
      final uri = Uri.parse(result);
      await launchUrl(uri);
      if (mounted) {
        await context.push(Routes.aparence);
      }
    } catch (e) {
      toast.showError(e.toString());
    } finally {
      Loader.hide();
    }
  }

  Future<void> _onResolvePendencies() async {
    try {
      Loader.show(context);
      final result = await widget.viewmodel.resolvePendencies();
      final uri = Uri.parse(result);
      await launchUrl(uri);
      if (mounted) {
        await context.push(Routes.aparence);
      }
    } catch (e) {
      toast.showError(e.toString());
    } finally {
      Loader.hide();
    }
  }

  @override
  Widget build(BuildContext context) {
    return CwContainerShadow(
      width: double.infinity,
      child: FutureState(
        future: _load,
        onComplete: (context, data) => Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Material(borderRadius: PSize.i.borderRadiusAll, clipBehavior: Clip.antiAliasWithSaveLayer, child: Image.asset(PImages.logoStripe, height: 50, width: 50, fit: BoxFit.cover)),
            PSize.i.sizedBoxW,
            Expanded(
              child: Column(
                children: [
                  CwHeaderCard(
                    titleLabel: status != PaymentProviderAccountStatus.enable ? context.i18n.conectarStripe : 'Stripe - ${stripe?.accountId}',
                    description: context.i18n.descConectarStripe,
                    actions: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        if (stripe == null) PButton(label: 'Conectar com stripe', onPressed: () async => await _onConectStripe()),
                        if (stripe != null && status == PaymentProviderAccountStatus.pending) CwOutlineButton(label: '⚠ Verificar pendencias', onPressed: () async => await _onResolvePendencies()),
                        if (status != PaymentProviderAccountStatus.pending)
                          PSwicth(
                            value: status == PaymentProviderAccountStatus.enable,
                            onChanged: (value) {
                              setState(() {
                                final status = value ? PaymentProviderAccountStatus.enable : PaymentProviderAccountStatus.disable;
                                widget.viewmodel.toggleStatusStripe(status);
                              });
                            },
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
