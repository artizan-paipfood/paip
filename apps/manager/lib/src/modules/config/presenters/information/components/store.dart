import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:manager/l10n/i18n_extension.dart';
import 'package:manager/src/core/datasources/data_source.dart';
import 'package:manager/src/core/components/container_shadow.dart';
import 'package:manager/src/core/components/header_card.dart';
import 'package:paipfood_package/paipfood_package.dart';

class Store extends StatefulWidget {
  const Store({super.key});

  @override
  State<Store> createState() => _StoreState();
}

class _StoreState extends State<Store> {
  late final company = context.read<DataSource>().company;
  late final slugEC = TextEditingController(text: company.slug);
  @override
  Widget build(BuildContext context) {
    return CwContainerShadow(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CwHeaderCard(titleLabel: context.i18n.loja, description: context.i18n.descLoja),
          CwTextFormFild(
            controller: slugEC,
            onChanged: (value) {
              slugEC.text = company.slug;
            },
            label: context.i18n.linkLoja,
            prefixText: "${LocaleNotifier.instance.baseUrl}/menu/",
            suffixIcon: IconButton(
              onPressed: () {
                Clipboard.setData(ClipboardData(text: "${LocaleNotifier.instance.baseUrl}/menu/${slugEC.text}"));
                toast.showSucess(context.i18n.copiadoParaAreaTransferencia, alignment: Alignment.bottomRight);
              },
              icon: const Icon(Icons.copy),
            ),
            helperText: context.i18n.descLinkLoja,
          ),
          const CwSizedBox(),
        ],
      ),
    );
  }
}
