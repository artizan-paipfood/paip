import 'package:flutter/material.dart';
import 'package:ui/ui.dart';

import '../../domain/dtos/phone_micro_dto.dart';
import 'package:paipfood_package/paipfood_package.dart';

class PhoneLoginMicroPage extends StatefulWidget {
  final Function(PhoneMicroDto phoneModel) onSubmit;
  final String? initialValue;
  final String title;
  final String description;
  final List<Countries> countries;
  final String initialLocale;
  const PhoneLoginMicroPage({
    required this.title,
    required this.onSubmit,
    required this.countries,
    required this.initialLocale,
    super.key,
    this.initialValue,
    this.description = '',
  });

  @override
  State<PhoneLoginMicroPage> createState() => _PhoneLoginMicroPageState();
}

class _PhoneLoginMicroPageState extends State<PhoneLoginMicroPage> {
  late final phoneEC = TextEditingController(text: widget.initialValue);
  late final phoneCountryCodeEC = TextEditingController(text: widget.initialLocale);
  final formKey = GlobalKey<FormState>();
  late String _initialLocale = widget.initialLocale;

  @override
  void dispose() {
    phoneEC.dispose();
    phoneCountryCodeEC.dispose();
    super.dispose();
  }

  void _onSubmit() {
    if (formKey.currentState!.validate()) {
      final phone = PhoneMicroDto(phone: phoneEC.text, countryCode: phoneCountryCodeEC.text);
      widget.onSubmit.call(phone);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.color.primaryBG,
      floatingActionButton: FloatingActionButton(
        onPressed: () => _onSubmit(),
        child: const Icon(Icons.arrow_forward),
      ),
      appBar: AppBar(),
      body: Form(
        key: formKey,
        child: Padding(
          padding: PSize.ii.paddingHorizontal,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.title,
                style: context.textTheme.titleLarge,
              ),
              Text(
                widget.description,
                style: context.textTheme.bodySmall?.muted(context),
              ),
              PSize.i.sizedBoxH,
              CwTextFormFild.underlinded(
                prefixIcon: Padding(
                  padding: PSize.i.paddingLeft + PSize.i.paddingRight + const EdgeInsets.only(bottom: 6),
                  child: FlagCountrySelector(
                    initialLocale: widget.initialLocale,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    enabled: true,
                    countries: widget.countries,
                    phoneCountryCodeController: phoneCountryCodeEC,
                    onCountryChanged: (country) {
                      setState(() {
                        _initialLocale = country.locale;
                        phoneCountryCodeEC.text = country.dialCode;
                        phoneEC.clear();
                      });
                    },
                  ),
                ),
                maskUtils: MaskUtils.phone(
                  textEditingController: phoneEC,
                  locale: _initialLocale,
                  isRequired: true,
                ),
                controller: phoneEC,
                style: context.textTheme.titleLarge,
                autofocus: true,
                onFieldSubmitted: (value) => _onSubmit(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
