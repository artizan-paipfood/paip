import 'package:flutter/material.dart';

import 'package:paipfood_package/paipfood_package.dart';
import 'package:portal/l10n/i18n_extension.dart';
import 'package:portal/src/core/helpers/assets_img.dart';
import 'package:portal/src/core/helpers/breakpoints.dart';
import 'package:portal/src/core/helpers/routes.dart';
import 'package:portal/src/modules/home/presenters/components/app_bar_home_widget.dart';
import 'package:portal/src/modules/home/presenters/components/establishment_avaliation_card.dart';
import 'package:portal/src/modules/home/presenters/components/features_card.dart';
import 'package:portal/src/modules/home/presenters/components/plans_component.dart';
import 'package:portal/src/modules/home/presenters/viewmodels/plans_viewmodel.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  late final planStore = context.read<PlansViewmodel>();

  @override
  void initState() {
    _getPlans = planStore.getEnablesByCountry();
    super.initState();
  }

  late Future<List<PlansModel>> _getPlans;
  @override
  Widget build(BuildContext context) {
    final colorScheme = context.artColorScheme;
    return FutureState(
      future: _getPlans,
      ignoreListEmpty: true,
      onComplete: (context, data) => Scaffold(
        key: _scaffoldKey,
        backgroundColor: colorScheme.secondary,
        appBar: PaipBreakpoint.phone.isBreakpoint(context) ? null : const AppBarHomeWidget(),
        body: SingleChildScrollView(
          child: SelectionArea(
            child: Column(
              children: [
                Container(
                  height: 800,
                  width: double.infinity,
                  decoration: BoxDecoration(image: DecorationImage(image: AssetImage(Assets.pdvHome), fit: BoxFit.cover, colorFilter: ColorFilter.mode(Colors.black.withValues(alpha: .35), BlendMode.darken))),
                  child: Stack(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(padding: PSize.v.paddingAll, child: Align(alignment: Alignment.bottomRight, child: SvgPicture.asset(Assets.logoGreenWhite, width: 150))),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: PSize.v.paddingHorizontal,
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 700),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(context.i18n.titleHome, style: context.artTextTheme.h2.copyWith(color: Colors.white, fontSize: 40), textAlign: TextAlign.start),
                                PSize.i.sizedBoxH,
                                Text(context.i18n.subtitleHome, textAlign: TextAlign.start, style: context.artTextTheme.lead.copyWith(color: Colors.white)),
                                PSize.iii.sizedBoxH,
                                SizedBox(
                                  width: 300,
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: ArtButton(
                                          child: Text(Utils.capitalizeWords(context.i18n.comeceGratuitamente)),
                                          onPressed: () {
                                            context.push(Routes.register);
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      // Image.asset(Assets.pcPedidos),
                    ],
                  ),
                ),
                PSize.v.sizedBoxH,
                Text(context.i18n.tituloFeatures, style: context.artTextTheme.h2, textAlign: TextAlign.center),
                PSize.v.sizedBoxH,
                OverflowBar(
                  spacing: 30,
                  overflowSpacing: 12,
                  overflowAlignment: OverflowBarAlignment.center,
                  children: [
                    FeaturesCard(icon: PIcons.strokeRoundedMessage01, title: context.i18n.featureTitleWhatsapp, description: context.i18n.featureDescWhatsapp),
                    FeaturesCard(icon: PIcons.strokeRoundedPrinter, title: context.i18n.featureTitleImpressao, description: context.i18n.featureDescImpressao),
                    FeaturesCard(icon: PIcons.strokeRoundedCashier, title: context.i18n.featureTitlePdv, description: context.i18n.featureDescPdv),
                  ],
                ),
                SizedBox(height: 30),
                OverflowBar(
                  spacing: 30,
                  overflowSpacing: 12,
                  overflowAlignment: OverflowBarAlignment.center,
                  children: [
                    FeaturesCard(icon: PIcons.strokeRoundedTable02, title: context.i18n.featureTitleMesa, description: context.i18n.featureDescMesa),
                    FeaturesCard(icon: PIcons.strokeRoundedSmartPhone01, title: context.i18n.featureTitleAppGarcom, description: context.i18n.featureDescAppGarcom),
                    FeaturesCard(icon: PIcons.strokeRoundedScooter03, title: context.i18n.featureTitleEntregadores, description: context.i18n.featureDescEntregadores),
                  ],
                ),
                PSize.v.sizedBoxH,
                Container(color: Colors.white, width: double.infinity, child: PlansComponent(plans: data, onSelected: (plan) {})),
                Container(
                  width: double.infinity,
                  color: Colors.white,
                  child: Padding(
                    padding: PSize.ii.paddingHorizontal + PSize.v.paddingVertical,
                    child: Column(
                      children: [
                        Text(context.i18n.avaliacoesTitle, style: context.artTextTheme.h2, textAlign: TextAlign.center),
                        SizedBox(height: 30),
                        OverflowBar(
                          spacing: 30,
                          overflowSpacing: 12,
                          overflowAlignment: OverflowBarAlignment.center,
                          children: [
                            EstablishmentAvaliationCard(coment: "A integração com WhatsApp e impressão automática otimizou nossas operações. Estamos atendendo 50% mais pedidos com a mesma equipe.", clientName: "Marco", establishmentName: "Restaurante do Marco"),
                            EstablishmentAvaliationCard(
                              coment: "O app para garçons e integração com PDV transformou nosso atendimento. Nossa equipe adora as ferramentas modernas, e os clientes apreciam o serviço mais rápido.",
                              clientName: "Lisa",
                              establishmentName: "Gerente de Restaurante",
                            ),
                            EstablishmentAvaliationCard(coment: "A rede de entregas foi um divisor de águas. Agora podemos oferecer delivery sem a dor de cabeça de gerenciar entregadores.", clientName: "David", establishmentName: "Pastelaria food-truck"),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  color: Color(0xff12A348),
                  child: Padding(
                    padding: PSize.ii.paddingHorizontal + PSize.v.paddingVertical,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(context.i18n.callTitleAssinar, textAlign: TextAlign.center, style: context.artTextTheme.h2.copyWith(color: Colors.white)),
                        PSize.ii.sizedBoxH,
                        Text(context.i18n.callDescAssinar, textAlign: TextAlign.center, style: context.artTextTheme.muted.copyWith(color: Colors.white)),
                        PSize.iii.sizedBoxH,
                        ArtButton.outline(
                          backgroundColor: Colors.white,
                          foregroundColor: Color(0xff12A348),
                          child: Text(context.i18n.callButtonAssinar),
                          onPressed: () {
                            banner.showSucess('teste');
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                Container(height: 300, width: double.infinity, color: Color(0xff0F1827), child: Row(children: [Flexible(flex: 1, child: Center(child: SvgPicture.asset(Assets.logoWhite, width: 150))), Flexible(flex: 3, child: Column())])),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
