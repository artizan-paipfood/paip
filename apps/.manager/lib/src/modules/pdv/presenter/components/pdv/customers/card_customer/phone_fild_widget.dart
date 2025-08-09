import 'package:flutter/material.dart';
import 'package:paipfood_package/paipfood_package.dart';

class PhoneFildWidget extends StatefulWidget {
  final String? label;
  final bool expanded;
  final List<Countries>? countries;
  final Function(String countryCode, String phone) onChanged;
  final String? initialCountryCode;
  final String? initialPhone;
  const PhoneFildWidget(
      {required this.onChanged, super.key, this.expanded = false, this.countries, this.initialCountryCode, this.initialPhone, this.label});

  @override
  State<PhoneFildWidget> createState() => _PhoneFildWidgetState();
}

class _PhoneFildWidgetState extends State<PhoneFildWidget> {
  String get _initialPhoneCountryCode {
    if (widget.initialCountryCode != null && widget.initialCountryCode!.isNotEmpty) return widget.initialCountryCode!;
    return LocaleNotifier.instance.locale.dialCode;
  }

  late final phoneEC = TextEditingController(text: widget.initialPhone ?? '');
  late final phoneCountryCodeEC = TextEditingController(text: _initialPhoneCountryCode);
  String _locale = LocaleNotifier.instance.locale.name;

  @override
  void dispose() {
    phoneEC.dispose();
    phoneCountryCodeEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CwTextFormFild(
      label: widget.label,
      expanded: widget.expanded,
      prefixIcon: Padding(
        padding: PSize.i.paddingLeft + PSize.i.paddingRight + const EdgeInsets.only(bottom: 10),
        child: FlagCountrySelector(
          initialPhoneCountryCode: _initialPhoneCountryCode,
          crossAxisAlignment: CrossAxisAlignment.end,
          countries: widget.countries,
          phoneCountryCodeController: phoneCountryCodeEC,
          onCountryChanged: (country) {
            setState(() {
              phoneCountryCodeEC.text = country.dialCode;
              _locale = country.locale;
              phoneEC.clear();
              widget.onChanged(phoneCountryCodeEC.text, phoneEC.text);
            });
          },
        ),
      ),
      controller: phoneEC,
      maskUtils: MaskUtils.phone(
        textEditingController: phoneEC,
        locale: _locale,
      ),
      onChanged: (value) => widget.onChanged(phoneCountryCodeEC.text, phoneEC.text),
    );
  }
}
