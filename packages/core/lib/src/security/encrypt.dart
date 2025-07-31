import 'package:core/core.dart';

class Encrypt {
  static String encodePasswordPhone({required PhoneNumber phoneNumber, required String key}) {
    //! DONT TOUCH HERE
    phoneNumber.validate();

    if (key.trim().isEmpty) throw ArgumentError('encryptKey is required');

    final dialCode = phoneNumber.dialCode.onlyNumbers();
    final phone = phoneNumber.number.onlyNumbers();
    final String phoneDigitsOnly = "$dialCode$phone";

    int sum = 0;
    for (int i = 0; i < phoneDigitsOnly.length; i++) {
      sum += int.parse(phoneDigitsOnly[i]);
    }

    final int n = (sum % 7) + 3;

    final text = "$key$phoneDigitsOnly";
    final List<String> matriz = List.filled(n, "");
    int rail = 0;
    int step = 1;
    for (int i = 0; i < text.length; i++) {
      final String c = text[i];
      matriz[rail] = matriz[rail] + c;
      if (rail == n - 1) {
        step = -1;
      } else if (rail == 0) {
        step = 1;
      }
      rail += step;
    }
    return matriz.join();
  }
}
