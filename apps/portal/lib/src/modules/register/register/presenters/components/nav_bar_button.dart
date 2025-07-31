import 'package:flutter/material.dart';

import 'package:paipfood_package/paipfood_package.dart';
import 'package:portal/l10n/i18n_extension.dart';
import 'package:portal/src/modules/register/register/aplication/controllers/register_controller.dart';
import 'package:portal/src/modules/register/register/aplication/stores/register_store.dart';
import 'package:portal/src/modules/register/register/presenters/components/login_support_button.dart';

class NavBarButton extends StatefulWidget {
  const NavBarButton({super.key});

  @override
  State<NavBarButton> createState() => _NavBarButtonState();
}

class _NavBarButtonState extends State<NavBarButton> {
  late final RegisterController controller = context.read<RegisterController>();
  @override
  Widget build(BuildContext context) {
    final RegisterStore store = controller.store;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        PSize.i.sizedBoxH,
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ValueListenableBuilder(
              valueListenable: controller.store.pageIndexVN,
              builder: (context, pageIndex, __) {
                return Visibility(
                  visible: pageIndex != 0,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: ExcludeFocus(
                      child: ArtButton.outline(
                        onPressed: () {
                          controller.backPage();
                        },
                        leading: Icon(PIcons.strokeRoundedArrowLeft02),
                        child: Text(context.i18n.voltar),
                      ),
                    ),
                  ),
                );
              },
            ),
            Expanded(
              child: ArtButton(
                onPressed: () async {
                  controller.nextPage(context);
                },
                child: Text(store.pageIndexVN.value < 1 ? context.i18n.cadastrar : context.i18n.proximo),
              ),
            ),
          ],
        ),
        PSize.i.sizedBoxH,
        if (controller.store.pageIndexVN.value == 0) const LoginSupportButton(),
      ],
    );
  }
}
