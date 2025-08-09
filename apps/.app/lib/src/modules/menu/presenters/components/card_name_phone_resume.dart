import 'package:flutter/material.dart';

import 'package:app/l10n/l18n_extension.dart';
import 'package:app/src/core/helpers/routes.dart';
import 'package:app/src/modules/menu/presenters/view_models/menu_viewmodel.dart';
import 'package:app/src/modules/menu/presenters/components/base_card_menu.dart';
import 'package:app/src/modules/user/presenters/viewmodels/user_store.dart';
import 'package:app/src/modules/user/domain/enums/user_navigation_mode.dart';
import 'package:paipfood_package/paipfood_package.dart';

class CardNamePhoneResume extends StatefulWidget {
  final MenuViewmodel menuViewmodel;
  const CardNamePhoneResume({super.key, required this.menuViewmodel});

  @override
  State<CardNamePhoneResume> createState() => _CardNamePhoneResumeState();
}

class _CardNamePhoneResumeState extends State<CardNamePhoneResume> {
  late final userStore = context.read<UserStore>();
  @override
  Widget build(BuildContext context) {
    return BaseCardMenu(
      children: [
        Text(context.i18n.dadosContato, style: context.textTheme.titleMedium),
        Padding(
          padding: PSize.i.paddingHorizontal,
          child: Column(
            children: [
              _buildRowEdit(
                context,
                label: context.i18n.nome,
                content: AuthNotifier.instance.auth.user?.name ?? '-',
                onEdit: () {
                  userStore
                    ..setFinishRouteName(Routes.cart(establishmentId: widget.menuViewmodel.establishment.id))
                    ..setNavigationMode(UserNavigationMode.editName);
                  context.push(Routes.name);
                },
              ),
              _buildRowEdit(
                context,
                label: context.i18n.telefone,
                content: AuthNotifier.instance.auth.user?.phone ?? '-',
                onEdit: () {
                  userStore
                    ..setFinishRouteName(Routes.cart(establishmentId: widget.menuViewmodel.establishment.id))
                    ..setNavigationMode(UserNavigationMode.editPhone);
                  context.push(Routes.phone);
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRowEdit(BuildContext context, {required String label, required String content, required void Function() onEdit}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(label, style: context.textTheme.bodyMedium?.muted(context)), Text(content, style: context.textTheme.titleMedium)]),
        IconButton(onPressed: onEdit, icon: const Icon(PIcons.strokeRoundedPencilEdit01)),
      ],
    );
  }
}
