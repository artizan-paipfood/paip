import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:manager/l10n/i18n_extension.dart';
import 'package:manager/src/core/components/container_shadow.dart';
import 'package:manager/src/core/components/inner_container.dart';
import 'package:manager/src/modules/config/aplication/stores/aparence_store.dart';
import 'package:manager/src/modules/config/presenters/appearance/components/colors_app.dart';
import 'package:manager/src/modules/config/presenters/appearance/components/images_app.dart';
import 'package:paipfood_package/paipfood_package.dart';
import '../../../../core/components/header_card.dart';

class AppearancePage extends StatefulWidget {
  const AppearancePage({super.key});

  @override
  State<AppearancePage> createState() => _AppearancePageState();
}

class _AppearancePageState extends State<AppearancePage> {
  late final store = context.read<AparenceStore>();

  Future<void> _save(BuildContext context) async {
    try {
      Loader.show(context);
      await store.save();
      if (context.mounted) {
        toast.showSucess(context.i18n.alteracoesSalvas);
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
      child: Column(
        children: [
          CwHeaderCard(titleLabel: context.i18n.aparencia, actions: PButton(label: context.i18n.salvar, onPressedFuture: () async => await _save(context))),
          Expanded(
            child: CwInnerContainer(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const ColorsApp(),
                    const SizedBox(height: 20),
                    ValueListenableBuilder(
                      valueListenable: store.rebuildImages,
                      builder: (context, _, __) {
                        return ImagesApp(store: store);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
