import 'package:auth/src/_i18n/gen/strings.g.dart';
import 'package:auth/src/core/domain/models/user_phone_model.dart';
import 'package:auth/src/modules/auth_phone/presentation/viewmodels/auth_phone_viewmodel.dart';
import 'package:auth/src/modules/auth_phone/utils/routes.dart';
import 'package:core_flutter/core_flutter.dart';
import 'package:flutter/material.dart';
import 'package:ui/ui.dart';

class AuthUserNamePage extends StatefulWidget {
  const AuthUserNamePage({
    super.key,
  });

  @override
  State<AuthUserNamePage> createState() => _NameState();
}

class _NameState extends State<AuthUserNamePage> {
  final formKey = GlobalKey<FormState>();

  late final AuthPhoneViewmodel _viewmodel = context.read<AuthPhoneViewmodel>();

  UserPhoneModel get _model => _viewmodel.model;

  String _name = '';

  void _onSubmit(String value) {
    if (formKey.currentState!.validate()) {
      _viewmodel.setUserData(_model.copyWith(name: value));
      Go.of(context).pushNamedNeglect(Routes.phoneNamed);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.artColorScheme.background,
      floatingActionButton: FloatingActionButton(
        onPressed: () => _onSubmit(_name),
        child: const Icon(Icons.arrow_forward),
      ),
      appBar: AppBar(),
      body: Form(
        key: formKey,
        child: Padding(
          padding: PSize.spacer.paddingHorizontal,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                t.title_name_page,
                style: context.artTextTheme.h3,
              ),
              PSize.ii.sizedBoxH,
              ArtTextFormField(
                placeholder: Text(t.placeholder_input_name),
                initialValue: _model.name,
                autofocus: true,
                formController: ObrigatoryValidator(),
                keyboardType: TextInputType.name,
                textCapitalization: TextCapitalization.words,
                onChanged: (value) => _name = value,
                onSubmitted: (value) => _onSubmit(value),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
