import 'package:flutter/material.dart';

import 'package:manager/l10n/i18n_extension.dart';
import 'package:manager/src/core/components/container_shadow.dart';
import 'package:manager/src/core/components/header_card.dart';
import 'package:manager/src/core/components/inner_container.dart';
import 'package:manager/src/modules/config/aplication/stores/information_store.dart';
import 'package:manager/src/modules/config/presenters/information/components/information_trafic.dart';
import 'package:paipfood_package/paipfood_package.dart';
import 'components/address_establishment.dart';
import 'components/principal_information.dart';
import 'components/social_media.dart';
import 'components/store.dart';

class InformationPage extends StatelessWidget {
  const InformationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.read<InformationStore>();

    return CwContainerShadow(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          CwHeaderCard(
            titleLabel: context.i18n.informacoes,
            actions: PButton(
              label: context.i18n.salvar,
              onPressedFuture: () async {
                await controller.save();
                if (context.mounted) {
                  toast.showSucess(context.i18n.alteracoesSalvas);
                }
              },
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: CwInnerContainer(
                child: Form(
                  key: controller.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [const PrincipalInformation(), PSize.iii.sizedBoxH, const AddressEstablishment(), PSize.iii.sizedBoxH, const Store(), PSize.iii.sizedBoxH, const SocialMedia(), PSize.iii.sizedBoxH, const InformationTrafic(), PSize.iii.sizedBoxH],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
