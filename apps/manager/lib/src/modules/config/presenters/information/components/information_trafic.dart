import 'package:flutter/material.dart';

import 'package:manager/l10n/i18n_extension.dart';
import 'package:manager/src/core/components/container_shadow.dart';
import 'package:manager/src/core/components/header_card.dart';
import 'package:paipfood_package/paipfood_package.dart';
import '../../../aplication/stores/information_store.dart';

class InformationTrafic extends StatelessWidget {
  const InformationTrafic({super.key});

  @override
  Widget build(BuildContext context) {
    late final InformationStore viewmodel = context.read<InformationStore>();
    return CwContainerShadow(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CwHeaderCard(
            titleLabel: context.i18n.trafegoPago,
            // description: context.i18n.descredesSociais,
          ),
          CwTextFormFild(
            label: "Facebook Pixel",
            prefixIcon: const Icon(PaipIcons.facebookPixel),
            initialValue: viewmodel.establishment.facebookPixel,
            validator: (value) {
              if (value != null && value.isNotEmpty) {
                if (value.length > 50) return context.i18n.trafegoPagoHandleErrorCode;
              }
              return null;
            },
            onChanged: (value) => viewmodel.establishment = viewmodel.establishment.copyWith(facebookPixel: value),
          ),
        ],
      ),
    );
  }
}
