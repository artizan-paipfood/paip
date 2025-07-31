// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:paipfood_package/paipfood_package.dart';
import '../../aplication/stores/register_store.dart';
import '../../aplication/controllers/register_controller.dart';

class SlugPage extends StatefulWidget {
  const SlugPage({super.key});

  @override
  State<SlugPage> createState() => _SlugPageState();
}

class _SlugPageState extends State<SlugPage> {
  late final controller = context.read<RegisterController>();
  @override
  void initState() {
    controller.slugExist();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    RegisterStore store = controller.store;
    return Padding(
      padding: PSize.ii.paddingHorizontal,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 80),
          Row(
            children: [
              Text(store.user.name, style: context.textTheme.titleLarge!.copyWith(color: context.color.primaryColor)),
              Text(" chegamos no ultimo passo.", style: context.textTheme.titleLarge),
            ],
          ),
          Text("Basta informar um apelido que vai aparecer no final do seu link e pronto, sua loja estará cadastrada.", style: context.textTheme.bodySmall),
          Expanded(
            child: Center(
              child: Form(
                key: store.formKeySlug,
                child: CwTextFormFild(
                  maskUtils: MaskUtils.cRequired(customValidate: (value) {
                    if (store.slugExist) {
                      return "Já existe um restaurante com esse apelido, tente outro.";
                    }
                    return null;
                  }),
                  onChanged: (value) {
                    store.company = store.company.copyWith(slug: value);
                    store.establishment = store.establishment.copyWith(companySlug: value);
                  },
                  autofocus: true,
                  textCapitalization: TextCapitalization.none,
                  inputFormatters: [AlphaNumericInputFormatter()],
                  prefixText: "${LocaleNotifier.instance.baseUrl}/menu/",
                  label: "Defina a url para acessar sua loja",
                  helperText: 'Obs: Somente letras minusculas, numeros e _ são aceitos.',
                  initialValue: store.establishment.companySlug,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
