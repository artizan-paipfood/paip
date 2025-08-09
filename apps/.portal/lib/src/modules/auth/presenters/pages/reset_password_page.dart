import 'package:flutter/material.dart';
import 'package:paipfood_package/paipfood_package.dart';
import 'package:portal/l10n/i18n_extension.dart';
import 'package:portal/src/core/helpers/assets_img.dart';
import 'package:portal/src/core/helpers/routes.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  String? token;
  String password = '';
  String confirmPassword = '';

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    final url = Modular.getCurrentPathOf(context);
    token = Utils.getPathParam(url: url, param: 'token');
    super.initState();
  }

  Future<void> _onSubmit() async {
    if (_formKey.currentState!.validate()) {
      Future.delayed(5.seconds, () {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(decoration: BoxDecoration(image: DecorationImage(image: AssetImage(Assets.bannerResetPassword), fit: BoxFit.cover, colorFilter: ColorFilter.mode(Colors.black.withValues(alpha: .3), BlendMode.darken))), width: context.w, height: double.infinity),
          Padding(padding: PSize.v.paddingAll, child: Align(alignment: Alignment.topLeft, child: GestureDetector(onTap: () => context.go(Routes.home), child: SvgPicture.asset(Assets.logoGreenWhite, width: 150)))),
          Align(
            alignment: Alignment.centerRight,
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 500, minWidth: 300),
              child: Padding(
                padding: PSize.ii.paddingAll,
                child: Form(
                  key: _formKey,
                  child: ArtCard(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(context.i18n.troqueSuaSenha, style: context.textTheme.titleLarge),
                        PSize.ii.sizedBoxH,
                        ArtTextFormField(label: Text(context.i18n.novaSenha), obscureText: true, onChanged: (value) => password = value),
                        PSize.spacer.sizedBoxH,
                        ArtTextFormField(label: Text(context.i18n.confirmeNovaSenha), obscureText: true, onChanged: (value) => confirmPassword = value, onSubmitted: (value) async => await _onSubmit()),
                        PSize.spacer.sizedBoxH,
                        Row(children: [Expanded(child: ArtButton(child: Text(context.i18n.confirmar.toUpperCase()), onPressed: () async => await _onSubmit()))]),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
