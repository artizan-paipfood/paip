import 'package:flutter/material.dart';
import 'package:paipfood_package/paipfood_package.dart';
import 'package:portal/l10n/i18n_extension.dart';

class PlansDto {
  final BuildContext context;
  final PlansModel plan;
  PlansDto({required this.context, required this.plan});

  String get title => Utils.capitalizeWords(plan.plan.name.i18n());

  String get description => '';

  String get price => plan.price.toStringCurrency;

  List<Widget> buildFeatures(BuildContext context) {
    if (plan.plan == Plans.standard) return _buildPlanStandard(context);
    if (plan.plan == Plans.pro) return _buildPlanPro(context);
    if (plan.plan == Plans.plus) return _buildPlanPlus(context);
    return [];
  }

  List<Widget> _buildDefaultFeatures(BuildContext context) => [
        _buildFeature(context, icon: Icons.check_circle, iconColor: context.color.primaryColor, text: context.i18n.automacaoComWhatsApp),
        _buildFeature(context, icon: Icons.check_circle, iconColor: context.color.primaryColor, text: context.i18n.aplicativoDelivery),
        _buildFeature(context, icon: Icons.check_circle, iconColor: context.color.primaryColor, text: context.i18n.relatorios),
      ];

  List<Widget> _buildPlanStandard(BuildContext context) => [
        ..._buildDefaultFeatures(context),
        _buildFeature(context, icon: Icons.info, iconColor: Colors.amber, text: context.i18n.atePedidosMes(40)),
        _buildFeature(context, icon: Icons.cancel, iconColor: Colors.red, text: context.i18n.pdv.toUpperCase()),
        _buildFeature(context, icon: Icons.cancel, iconColor: Colors.red, text: context.i18n.appEntregador),
        _buildFeature(context, icon: Icons.cancel, iconColor: Colors.red, text: context.i18n.facebookPixel),
      ];
  List<Widget> _buildPlanPro(BuildContext context) => [
        ..._buildDefaultFeatures(context),
        _buildFeature(context, icon: Icons.check_circle, iconColor: context.color.primaryColor, text: context.i18n.pedidosIlimitados),
        _buildFeature(context, icon: Icons.check_circle, iconColor: context.color.primaryColor, text: context.i18n.pdv),
        _buildFeature(context, icon: Icons.cancel, iconColor: Colors.red, text: context.i18n.appEntregador),
        _buildFeature(context, icon: Icons.cancel, iconColor: Colors.red, text: context.i18n.facebookPixel),
      ];
  List<Widget> _buildPlanPlus(BuildContext context) => [
        ..._buildDefaultFeatures(context),
        _buildFeature(context, icon: Icons.check_circle, iconColor: context.color.primaryColor, text: context.i18n.pedidosIlimitados),
        _buildFeature(context, icon: Icons.check_circle, iconColor: context.color.primaryColor, text: context.i18n.pdv),
        _buildFeature(context, icon: Icons.check_circle, iconColor: context.color.primaryColor, text: context.i18n.appEntregador),
        _buildFeature(context, icon: Icons.check_circle, iconColor: context.color.primaryColor, text: context.i18n.facebookPixel),
      ];
}

Widget _buildFeature(BuildContext context, {required IconData icon, required Color iconColor, required String text}) {
  return RichText(text: TextSpan(children: [WidgetSpan(child: Icon(icon, color: iconColor, size: 14)), TextSpan(text: " $text", style: context.textTheme.bodyMedium?.muted(context))]));
}
