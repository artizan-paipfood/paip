import 'package:auth/src/_i18n/gen/strings.g.dart';
import 'package:auth/src/core/domain/models/user_phone_model.dart';

import 'package:auth/src/core/domain/events/events.dart';
import 'package:auth/src/modules/auth_phone/presentation/viewmodels/auth_phone_viewmodel.dart';
import 'package:core_flutter/core_flutter.dart';
import 'package:flutter/material.dart';
import 'package:ui/ui.dart';

class AuthPhoneConfirmPage extends StatefulWidget {
  const AuthPhoneConfirmPage({
    super.key,
  });

  @override
  State<AuthPhoneConfirmPage> createState() => _NameState();
}

class _NameState extends State<AuthPhoneConfirmPage> {
  late final AuthPhoneViewmodel _viewmodel = context.read<AuthPhoneViewmodel>();

  final _numberFN = FocusNode();

  UserPhoneModel get _model => _viewmodel.model;

  String _verificationCode = '';

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _numberFN.requestFocus();
    });
    super.initState();
  }

  @override
  void dispose() {
    _numberFN.dispose();
    super.dispose();
  }

  Future<void> _onSubmit() async {
    await Command0.executeWithLoader(
      context,
      () async => await _viewmodel.loginOrSignUp(phoneNumber: _viewmodel.model.buildPhoneNumber(), fullName: _viewmodel.model.name),
      onSuccess: (r) => ModularEvent.fire(LoginUserEvent(authenticatedUser: r)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.artColorScheme.background,
      floatingActionButton: FloatingActionButton(
        onPressed: _verificationCode.trim().length == 4 ? () => _onSubmit() : null,
        backgroundColor: _verificationCode.trim().length == 4 ? context.artColorScheme.primary : context.artColorScheme.muted,
        child: const Icon(Icons.arrow_forward),
      ),
      appBar: AppBar(),
      body: Padding(
        padding: PSize.spacer.paddingHorizontal,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              t.title_phone_confirm_page,
              style: context.artTextTheme.h3,
            ),
            PSize.ii.sizedBoxH,
            OverflowBar(
              children: [
                Text('${t.subtitle_phone_confirm_page}   ', style: context.artTextTheme.muted),
                ArtButton.link(
                  padding: EdgeInsets.zero,
                  foregroundColor: context.artColorScheme.foreground,
                  child: Text(_model.phoneNumber),
                  onPressed: () => context.pop(),
                )
              ],
            ),
            PSize.ii.sizedBoxH,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ArtInputOtp(
                  maxLength: 4,
                  onChanged: (value) {
                    setState(() => _verificationCode = value);
                    if (value.trim().length == 4) _onSubmit();
                  },
                  children: [
                    ArtInputOtpGroup(
                      children: [
                        ArtInputOtpSlot(
                          height: 50,
                          width: 50,
                          style: context.artTextTheme.h3,
                          padding: EdgeInsets.symmetric(vertical: 7),
                          focusNode: _numberFN,
                        ),
                        ArtInputOtpSlot(
                          height: 50,
                          width: 50,
                          style: context.artTextTheme.h3,
                          padding: EdgeInsets.symmetric(vertical: 7),
                        ),
                        ArtInputOtpSlot(
                          height: 50,
                          width: 50,
                          style: context.artTextTheme.h3,
                          padding: EdgeInsets.symmetric(vertical: 7),
                        ),
                        ArtInputOtpSlot(
                          height: 50,
                          width: 50,
                          style: context.artTextTheme.h3,
                          padding: EdgeInsets.symmetric(vertical: 7),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
