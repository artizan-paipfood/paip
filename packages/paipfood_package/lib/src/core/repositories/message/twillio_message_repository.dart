import 'dart:convert';

import 'package:core/core.dart';
import 'package:paipfood_package/paipfood_package.dart';

class TwillioMessageRepository implements IMessageRepository {
  final IClient http;
  TwillioMessageRepository({
    required this.http,
  });
  @override
  Future<void> sendMessage({required String phone, required String message}) async {
    await http.post(
      "https://api.twilio.com/2010-04-01/Accounts/AC07a25cd2854b938ccf24dcc621020d3c/Messages.json",
      headers: {"Content-Type": "application/x-www-form-urlencoded", "Authorization": "Basic ${base64.encode(utf8.encode("AC07a25cd2854b938ccf24dcc621020d3c:d8304882b1bbdf2208a120b1164dd637"))}"},
      data: {"To": Utils.onlyNumbersRgx(phone), "From": "14242066727", "Body": message},
    );
  }
}
