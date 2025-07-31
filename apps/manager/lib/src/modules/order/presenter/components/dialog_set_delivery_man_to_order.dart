import 'package:flutter/material.dart';
import 'package:multiavatar/multiavatar.dart';
import 'package:manager/l10n/i18n_extension.dart';
import 'package:paipfood_package/paipfood_package.dart';

class DialogSetDriverToOrder extends StatelessWidget {
  final List<DriverAndUserAdapter> deliveryMen;
  final Function(DriverAndUserAdapter driver) onSelected;
  const DialogSetDriverToOrder({required this.deliveryMen, required this.onSelected, super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(context.i18n.selecionarEntregador),
      content: ConstrainedBox(
        constraints: BoxConstraints(maxHeight: MediaQuery.sizeOf(context).height * 0.8),
        child: SingleChildScrollView(
          child: Column(
            children: [
              if (deliveryMen.isEmpty) CwEmptyState(size: 150, icon: PaipIcons.dropBox, bgColor: false, label: context.i18n.voceNaoPossuiEntregadores),
              ...deliveryMen.map(
                (driver) => ListTile(
                  onTap: () => {Navigator.pop(context), onSelected(driver)},
                  leading: CircleAvatar(backgroundColor: context.color.onPrimaryBG, child: driver.user.name.isNotEmpty ? SvgPicture.string(multiavatar(driver.user.name)) : const SizedBox.shrink()),
                  title: Text(driver.user.name),
                  subtitle: Text(driver.user.phone!, style: context.textTheme.bodyMedium?.muted(context)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
