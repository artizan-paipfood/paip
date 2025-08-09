import 'package:flutter/material.dart';

import 'package:manager/l10n/i18n_extension.dart';
import 'package:manager/src/core/components/container_shadow.dart';
import 'package:manager/src/core/components/header_card.dart';
import 'package:paipfood_package/paipfood_package.dart';
import '../../../aplication/stores/information_store.dart';

class SocialMedia extends StatelessWidget {
  const SocialMedia({super.key});

  @override
  Widget build(BuildContext context) {
    CompanyModel company = context.read<InformationStore>().company;
    return CwContainerShadow(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CwHeaderCard(titleLabel: context.i18n.redesSociais, description: context.i18n.descredesSociais),
          CwTextFormFild(label: "Facebook", initialValue: company.facebook, onChanged: (value) => company = company.copyWith(facebook: value)),
          CwTextFormFild(label: "Instagram", initialValue: company.instagram, onChanged: (value) => company = company.copyWith(instagram: value)),
        ],
      ),
    );
  }
}
