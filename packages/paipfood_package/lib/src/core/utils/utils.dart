import 'dart:math';
import 'package:core_flutter/core_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:core/core.dart';
import 'package:paipfood_package/paipfood_package.dart';

class Utils {
  static double _stringToDouble(String text) {
    if (text != "") {
      text = text.replaceAll(".", "");
      text = text.replaceFirst(",", ".");
      return double.parse(text);
    } else {
      return 0.0;
    }
  }

  static String buildNavigateWaze(String address) {
    final encodedAddress = Uri.encodeComponent(address);
    return 'https://waze.com/ul?q=$encodedAddress';
  }

  static double converMetersInMilesOrKm({required DbLocale locale, required double distance}) {
    if (locale == DbLocale.br) {
      return distance / 1000;
    }
    return distance / 1609.34;
  }

  // static double calculateDeliveryTax({
  //   DeliveryAreaPerMileEntity? deliveryAreaPerMile,
  //   double? distance,
  //   double? straightDistance,
  //   double? price,
  //   double roundTo = 0.5,
  // }) {
  //   if (price != null) return price;
  //   if (deliveryAreaPerMile == null) throw const FormatException("DeliveryAreaPerMileEntity is null");

  //   final pricePerMile = deliveryAreaPerMile.pricePerMile;
  //   final minPrice = deliveryAreaPerMile.minPrice;
  //   final distanceInPreferredUnit = isGb ? (straightDistance ?? 0.0) / 1609.34 : (distance ?? 0.0) / 1000;
  //   final minDistance = isGb ? deliveryAreaPerMile.minDistance / 1609.34 : deliveryAreaPerMile.minDistance / 1000;

  //   if (distanceInPreferredUnit < minDistance) return 0;

  //   final calculatedPrice = distanceInPreferredUnit * pricePerMile;

  //   final result = calculatedPrice < minPrice ? minPrice : calculatedPrice;
  //   return (result / roundTo).ceil() * roundTo;
  // }

  static String buildNavigateGoogleMaps(String address) {
    final encodedAddress = Uri.encodeComponent(address);
    return 'https://www.google.com/maps/search/?api=1&query=$encodedAddress';
  }

  static bool isUuidV4(String text) {
    final list = text.split('-');
    return list.length == 5;
  }

  static double stringToDouble(String text) {
    return double.tryParse(text) ?? _stringToDouble(text);
  }

  static String capitalizeWords(String str) {
    // Divida a string em palavras usando espaço como delimitador
    final List<String> words = str.split(' ');

    // Mapeie cada palavra para uma nova string com a primeira letra em maiúscula
    final List<String> capitalizedWords = words.map((word) {
      if (word.isEmpty) {
        return word;
      }
      return word[0].toUpperCase() + word.substring(1).toLowerCase();
    }).toList();

    return capitalizedWords.join(' ');
  }

  static DateTime dateParseToNow(DateTime date) {
    return DateTime(date.year, date.month, date.day, date.hour, date.minute, date.second);
  }

  static String doubleToStringDecimal(double value, {int digitis = 2}) {
    if (value == 0.0 || value == 0) {
      return '0';
    }
    return value.toStringAsFixed(digitis);
  }

  static String doubleToString(double value) {
    if (value == 0.0) {
      return " -- ";
    } else {
      return value.toString();
    }
  }

  static double calculateDistance({required double lat1, required double lon1, required double lat2, required double lon2}) {
    const double earthRadiusMeters = 6371000.0; // Raio da Terra em metros

    final double dLat = _degreesToRadians(lat2 - lat1);
    final double dLon = _degreesToRadians(lon2 - lon1);

    final double a = sin(dLat / 2) * sin(dLat / 2) + cos(_degreesToRadians(lat1)) * cos(_degreesToRadians(lat2)) * sin(dLon / 2) * sin(dLon / 2);
    final double c = 2 * atan2(sqrt(a), sqrt(1 - a));
    final double distance = earthRadiusMeters * c;

    return distance; // Distância em metros
  }

  static double _degreesToRadians(double degrees) {
    return degrees * pi / 180.0;
  }

  static String? getPathParam({required String url, required String param}) {
    final Uri uri = Uri.parse(url);
    return uri.queryParameters[param];
  }

  static double metersToMilhas(double metros) {
    return metros / 1609.34;
  }

  (double heidth, double width) getAspectRatio(double size, double ratio) {
    final h = size * ratio;
    final w = size;
    return (h, w);
  }

  static String generateUuid() {
    String uuid = "";
    uuid += generateRandomString(8);
    uuid += "-";
    uuid += generateRandomString(4);
    uuid += "-";
    uuid += generateRandomString(4);
    uuid += "-";
    uuid += generateRandomString(4);
    uuid += "-";
    uuid += generateRandomString(12);
    return uuid;
  }

  static Map<String, dynamic>? mapToMapStringDynamic(Map<dynamic, dynamic>? map) {
    if (map == null) return null;
    return Map<String, dynamic>.from(map).cast<String, dynamic>();
  }

  static String generateRandomString(int length) {
    final random = Random();
    const chars = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    String result = '';

    for (int i = 0; i < length; i++) {
      result += chars[random.nextInt(chars.length)];
    }

    return result;
  }

  static String generateRandomLetter(int length) {
    final random = Random();
    const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    String result = '';

    for (int i = 0; i < length; i++) {
      result += chars[random.nextInt(chars.length)];
    }

    return result;
  }

  static String generateRandomCodeOtp() {
    final random = Random();
    const chars = '0123456789';
    String result = '';

    for (int i = 0; i < 4; i++) {
      result += chars[random.nextInt(chars.length)];
    }

    return result;
  }

  static List<Map> listDynamicToListMap(List<dynamic> list) {
    return list.map((e) => e as Map<String, dynamic>).toList();
  }

  static List<T> convertListDynamicT<T>(List list) {
    return list.map((e) => e as T).toList();
  }

  static String maskToString(String value, TextInputFormatter textInputFormatter) {
    final ec = TextEditingController(text: value);
    ec.value = textInputFormatter.formatEditUpdate(ec.value, ec.value);
    final result = ec.text;
    ec.dispose();
    return result;
  }

  static String maskUltisToString(String value, MaskInputController mask) {
    if (mask.inpuFormatters == null) return value;
    TextInputFormatter? textInputFormatter;
    // final lenght = value.length;
    textInputFormatter = mask.inpuFormatters![0];
    // try {
    //   if (mask.onlenghtMaskChange != null && lenght >= mask.onlenghtMaskChange!) textInputFormatter = mask.inpuFormatters![1];
    // } catch (_) {
    //   textInputFormatter = mask.inpuFormatters![0];
    // }
    final ec = TextEditingController(text: value);
    ec.value = textInputFormatter.formatEditUpdate(ec.value, ec.value);
    final result = ec.text;
    ec.dispose();
    return result;
  }

  static String onlyNumbersRgx(String text) {
    return text.replaceAll(RegExp(r'\D'), '');
  }

  static bool rgxHasMatch(RegExp regex, {required String value}) {
    return regex.hasMatch(value);
  }

  static bool validatePassword(String value) {
    final RegExp regex = RegExp(r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[!@#\$%^&*(),.?":{}|<>]).{7,}$');
    return regex.hasMatch(value);
  }

  static String onlyAlphanumeric(String value, {bool undereline = false}) {
    if (undereline) return value.replaceAll(RegExp(r'[^a-zA-Z0-9_]'), '').toLowerCase();
    return value.replaceAll(RegExp(r'[^a-zA-Z0-9]'), '').toLowerCase();
  }

  static Map<String, dynamic> convertMapKeysToCamelCase(Map<String, dynamic> input) {
    final Map<String, dynamic> map = Map.from(input);
    final List<String> keys = map.keys.toList();
    for (String key in keys) {
      final String keyCamelCase = key.replaceAllMapped(
        RegExp(r'_[a-z]'),
        (match) => match[0]![1].toUpperCase(),
      );
      map[keyCamelCase] = map[key];
      map.remove(key);
    }
    return map;
  }

  String lastPurchase(DateTime purchaseDate) {
    final now = DateTime.now();
    final difference = now.difference(purchaseDate);

    if (difference.inDays >= 365) {
      final years = (difference.inDays / 365).floor();
      return years == 1 ? 'purchased 1 year ago' : 'purchased $years years ago';
    }
    if (difference.inDays >= 30) {
      final months = (difference.inDays / 30).floor();
      return months == 1 ? 'purchased 1 month ago' : 'purchased $months months ago';
    }
    if (difference.inDays >= 7) {
      final weeks = (difference.inDays / 7).floor();
      return weeks == 1 ? 'purchased 1 week ago' : 'purchased $weeks weeks ago';
    }
    if (difference.inDays >= 1) {
      return difference.inDays == 1 ? 'purchased 1 day ago' : 'purchased ${difference.inDays} days ago';
    }

    final hours = difference.inHours;
    return hours == 1 ? 'purchased 1 hour ago' : 'purchased $hours hours ago';
  }

  static String encodePasswordPhone({required String countryCode, required String phone}) {
    //! DONT TOUCH HERE
    final code = Utils.onlyNumbersRgx(countryCode);
    final phoneNumber = Utils.onlyNumbersRgx(phone);
    if (code.length > 4 || phoneNumber.length < 5) throw Exception("Invalid phone number");
    final String phoneDigitsOnly = Utils.onlyNumbersRgx("$code$phoneNumber");

    int sum = 0;
    for (int i = 0; i < phoneDigitsOnly.length; i++) {
      sum += int.parse(phoneDigitsOnly[i]);
    }

    final int n = (sum % 7) + 3;

    final text = "${Env.encryptKey}$phoneDigitsOnly";
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

  // double calculateDistance(double lat1, double long1, double lat2, double long2) {
  //   // Convertendo graus para radianos
  //   lat1 = _degreesToRadians(lat1);
  //   long1 = _degreesToRadians(long1);
  //   lat2 = _degreesToRadians(lat2);
  //   long2 = _degreesToRadians(long2);

  //   // Diferenças de latitude e longitude
  //   final double dlat = lat2 - lat1;
  //   final double dlon = long2 - long1;

  //   // Fórmula de Haversine
  //   final double a = pow(sin(dlat / 2), 2) + cos(lat1) * cos(lat2) * pow(sin(dlon / 2), 2);
  //   final double c = 2 * atan2(sqrt(a), sqrt(1 - a));
  //   const double R = 6371; // Raio da Terra em quilômetros
  //   final double distance = R * c;

  //   return distance;
  // }

  // double _degreesToRadians(double degrees) {
  //   return degrees * pi / 180;
  // }
}
