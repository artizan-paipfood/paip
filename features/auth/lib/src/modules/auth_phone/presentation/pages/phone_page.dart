import 'package:auth/i18n/gen/strings.g.dart';
import 'package:auth/src/domain/models/user_phone_model.dart';
import 'package:auth/src/modules/auth_phone/presentation/viewmodels/auth_phone_viewmodel.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:i18n/i18n.dart';
import 'package:ui/ui.dart';

class AuthPhonePage extends StatefulWidget {
  const AuthPhonePage({
    super.key,
  });

  @override
  State<AuthPhonePage> createState() => _NameState();
}

class _NameState extends State<AuthPhonePage> {
  final formKey = GlobalKey<FormState>();

  late final AuthPhoneViewmodel _viewmodel = context.read<AuthPhoneViewmodel>();
  final numberEC = TextEditingController();
  final numberFN = FocusNode();

  UserPhoneModel get _model => _viewmodel.model;

  String _phone = '';

  Countries? _selectedCountry;

  @override
  void initState() {
    final country = Countries.countries.firstWhere((element) => element.locale.toUpperCase() == LocaleNotifier.instance.locale.name.toUpperCase());
    _selectedCountry = country;
    super.initState();
  }

  @override
  void dispose() {
    numberEC.dispose();
    numberFN.dispose();
    super.dispose();
  }

  void _onSubmit() {
    if (formKey.currentState!.validate()) {
      _viewmodel.setUserData(_model.copyWith(phoneNumber: _phone, phoneDialCode: _selectedCountry!.dialCode));
      Go.of(context).pushNeglect('/phone-confirm');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.artColorScheme.background,
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
                t.title_phone_page,
                style: context.artTextTheme.h3,
              ),
              PSize.ii.sizedBoxH,
              ArtTextFormField(
                padding: EdgeInsets.zero,
                controller: numberEC,
                focusNode: numberFN,
                placeholder: Text(_selectedCountry?.masks.first ?? ''),
                leading: DecoratedBox(
                  decoration: BoxDecoration(
                    border: Border(right: BorderSide(color: context.artColorScheme.border)),
                  ),
                  child: PhoneDialCodeSelector(
                    initialLocale: _selectedCountry?.locale,
                    onCountryChanged: (value) => setState(() {
                      _selectedCountry = value;
                      numberEC.clear();
                      numberFN.requestFocus();
                    }),
                  ),
                ),
                autofocus: true,
                formController: PhoneByCountryValidator(
                  masks: _selectedCountry?.masks ?? [],
                  isRequired: true,
                  minLenght: _selectedCountry?.minLength ?? 8,
                ),
                onChanged: (value) => _phone = value,
                onSubmitted: (value) => _onSubmit(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
