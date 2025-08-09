import 'package:flutter/material.dart';

import 'package:app/src/core/helpers/routes.dart';
import 'package:app/src/modules/company/presenters/viewmodels/company_page_viewmodel.dart';
import 'package:paipfood_package/paipfood_package.dart';

class CompanyPage extends StatefulWidget {
  final String slug;
  const CompanyPage({
    super.key,
    this.slug = '',
  });

  @override
  State<CompanyPage> createState() => _CompanyPageState();
}

class _CompanyPageState extends State<CompanyPage> {
  late final Future<List<ShortEstablishmentDto>> _initialize;
  late final viewModel = context.read<CompanyPageViewmodel>();

  @override
  void initState() {
    _initialize = viewModel.getShorEstablishmentsBySlug(widget.slug);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureState(
            future: _initialize,
            onComplete: (context, data) {
              // Navegação movida para fora do build usando WidgetsBinding
              if (data.length == 1) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  Go.of(context).go(Routes.menu(establishmentId: data[0].id));
                });
              }
              return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(data[index].fantasyName),
                    subtitle: Text(data[index].address.formattedAddress(LocaleNotifier.instance.locale)),
                  );
                },
              );
            }));
  }
}
