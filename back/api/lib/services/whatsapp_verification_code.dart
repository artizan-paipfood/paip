import 'dart:math';

import 'package:collection/collection.dart';
import 'package:core/core.dart';

import 'package:api/l10n/i18n.dart';
import 'package:api/constants/base_url.dart';
import 'package:api/extensions/db_locale_extension.dart';

class WhatsappVerificationCode {
  static WhatsappVerificationCode? _instance;
  // Avoid self instance
  WhatsappVerificationCode._();
  static WhatsappVerificationCode get instance => _instance ??= WhatsappVerificationCode._();

  final IEvolutionApi _evolutionApi = EvolutionApiV1(client: ClientDio(baseOptions: DioBaseOptions.evolutionApi));

  Map<String, WppNumber> _wppNumbers = {AppLocaleCode.br.name: WppNumber(id: 'paip_br', notificationSent: false), AppLocaleCode.gb.name: WppNumber(id: 'paip_gb', notificationSent: false)};

  WppNumber getNumberAvaliable(AppLocaleCode locale) {
    final wpp = _wppNumbers[locale.name]!;
    if (wpp.enable) return wpp;
    final result = _wppNumbers.values.firstWhereOrNull((element) => element.enable);
    if (result == null) throw Exception('No wpp number enabled');
    return result;
  }

  Future<String> sendCode({required AppLocaleCode locale, required String phone}) async {
    final wppNumber = getNumberAvaliable(locale);
    final code = _generateCode();
    try {
      await _evolutionApi.sendText(instance: wppNumber.id, phone: phone, text: I18n.yourVerificationCodeIs(locale.language, code: code));
      if (wppNumber.errorCount > 0) _wppNumbers[locale.name] = wppNumber.copyWith(errorCount: 0);
    } catch (e) {
      await _onErrorSendCode(locale: locale, phone: phone);
      final newNumber = getNumberAvaliable(locale);
      await _evolutionApi.sendText(instance: newNumber.id, phone: phone, text: I18n.yourVerificationCodeIs(locale.language, code: code));
    }
    return code;
  }

  Future<void> _onErrorSendCode({required AppLocaleCode locale, required String phone}) async {
    final wppNumber = getNumberAvaliable(locale);
    final hasOtherAvaliable = _wppNumbers.values.any((element) => element.enable);
    if (!hasOtherAvaliable) throw Exception('No wpp number enabled');

    _wppNumbers[locale.name] = wppNumber.copyWith(notificationSent: true, errorCount: wppNumber.errorCount + 1);
    if (_wppNumbers[locale.name]!.enable == false) {
      final newWppNumber = getNumberAvaliable(locale);
      await _evolutionApi.sendText(instance: newWppNumber.id, phone: "5535984091567", text: '⚠️❌ WPP DESCONECTADO ${locale.name} ❌⚠️');
      await _evolutionApi.sendText(instance: newWppNumber.id, phone: "447387663483", text: '⚠️❌ WPP DESCONECTADO ${locale.name} ❌⚠️');
    }
  }

  String _generateCode() {
    final random = Random();
    final code = random.nextInt(9000) + 1000;
    return code.toString();
  }
}

class WppNumber {
  final String id;
  final bool notificationSent;
  final int errorCount;
  WppNumber({required this.id, required this.notificationSent, this.errorCount = 0});

  WppNumber copyWith({String? id, bool? notificationSent, int? errorCount}) {
    return WppNumber(id: id ?? this.id, notificationSent: notificationSent ?? this.notificationSent, errorCount: errorCount ?? this.errorCount);
  }

  bool get enable => errorCount < 5;
}
