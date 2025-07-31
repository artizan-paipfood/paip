import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ui/ui.dart';

import '../../domain/dtos/phone_micro_dto.dart';
import 'package:paipfood_package/paipfood_package.dart';

class PhoneConfirmMicroPage extends StatefulWidget {
  final PhoneMicroDto phone;
  final Function(String code) loginAndConfirmVerifyCode;
  final Function(String code) onUpdateNumber;
  final Function() onBackPage;
  final Function() onResendCodeWpp;
  final Function() onResendCodeSms;
  final bool isEdit;
  const PhoneConfirmMicroPage({
    super.key,
    required this.phone,
    required this.loginAndConfirmVerifyCode,
    required this.onUpdateNumber,
    required this.onBackPage,
    required this.onResendCodeWpp,
    required this.onResendCodeSms,
    this.isEdit = false,
  });

  @override
  State<PhoneConfirmMicroPage> createState() => _PhoneConfirmMicroPageState();
}

class _PhoneConfirmMicroPageState extends State<PhoneConfirmMicroPage> {
  String code = "";
  bool enable = false;
  DateTime date = DateTime.now().add(60.seconds);
  final ValueNotifier<bool> _isMessageVisible = ValueNotifier(false);

  late Timer timer = Timer(const Duration(seconds: 60), () {
    enable = true;
  });

  void _submit(String code) {
    widget.isEdit ? widget.onUpdateNumber.call(code) : widget.loginAndConfirmVerifyCode.call(code);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.color.primaryBG,
      floatingActionButton: FloatingActionButton(
        onPressed: () => _submit(code),
        child: const Icon(Icons.arrow_forward),
      ),
      appBar: AppBar(),
      body: Padding(
        padding: PSize.ii.paddingHorizontal,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Insira o código que enviamos para o seu whatsapp",
              style: context.textTheme.titleLarge,
            ),
            RichText(
              text: TextSpan(text: "Enviamos o código para o numero ", children: [TextSpan(text: widget.phone.phone, style: context.textTheme.bodySmall)], style: context.textTheme.bodySmall?.muted(context)),
            ),
            PSize.iii.sizedBoxH,
            PinCodeTextField(
              appContext: context,
              autoFocus: true,
              length: 4,
              cursorColor: context.color.primaryColor,
              keyboardType: TextInputType.number,
              onChanged: (value) => code = value,
              onCompleted: (value) async => _submit(code),
              pinTheme: PinTheme(
                selectedColor: context.color.tertiaryColor,
                activeColor: context.color.primaryColor,
                disabledColor: Colors.amber,
                inactiveColor: context.color.neutral500,
              ),
            ),
            PSize.i.sizedBoxH,
            Center(
                child: Column(
              children: [
                CwTextButton(
                  label: "Deseja editar o numero?",
                  onPressed: () => widget.onBackPage.call(),
                ),
                StreamBuilder(
                  stream: Stream.periodic(1.seconds, (computationCount) {}),
                  builder: (context, snapshot) {
                    final diference = date.difference(DateTime.now()).inSeconds;

                    if (diference < 1) {
                      if (_isMessageVisible.value == false) {
                        Future.delayed(200.milliseconds, () {
                          _isMessageVisible.value = true;
                        });
                      }
                      return const SizedBox.shrink();
                    }

                    return Text(
                      "🕒 $diference",
                      textAlign: TextAlign.center,
                      style: context.textTheme.titleLarge,
                    );
                  },
                ),
                ValueListenableBuilder(
                    valueListenable: _isMessageVisible,
                    builder: (context, _, __) {
                      if (!_isMessageVisible.value) return const SizedBox.shrink();
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CwTextButton(
                            icon: PIcons.strokeRoundedWhatsapp,
                            label: "Reenviar via whatsapp",
                            onPressed: () {
                              if (mounted) {
                                date = DateTime.now().add(60.seconds);
                                widget.onResendCodeWpp.call();
                                _isMessageVisible.value = false;
                              }
                            },
                          ),
                          CwTextButton(
                            icon: PIcons.strokeRoundedMessage01,
                            label: "Reenviar via sms",
                            onPressed: () {
                              date = DateTime.now().add(60.seconds);
                              widget.onResendCodeSms.call();
                              _isMessageVisible.value = false;
                            },
                          ),
                        ],
                      );
                    }),
              ],
            ))
          ],
        ),
      ),
    );
  }
}
