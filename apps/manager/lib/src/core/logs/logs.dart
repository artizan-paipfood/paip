import 'package:paipfood_package/paipfood_package.dart';
import 'package:talker_flutter/talker_flutter.dart';

enum LogType {
  client,
  debug;
}

class Logs {
  final LogType type;
  final Talker talker;
  final String displayName;
  Logs({
    required this.type,
    required this.displayName,
  }) : talker = Talker();
  SharedPreferences prefs = LocalStorageSharedPreferences.instance.sharedPreferences;

  static Logs client = Logs(displayName: 'Client', type: LogType.client);
  static Logs auth = Logs(displayName: 'Auth', type: LogType.debug);
  static Logs billing = Logs(displayName: 'Billing', type: LogType.debug);
  static Logs chatbot = Logs(displayName: 'Chatbot', type: LogType.debug);
  static Logs config = Logs(displayName: 'Config', type: LogType.debug);
  static Logs deliveryAreas = Logs(displayName: 'Delivery Areas', type: LogType.debug);
  static Logs driver = Logs(displayName: 'Driver', type: LogType.debug);
  static Logs menu = Logs(displayName: 'Menu', type: LogType.debug);
  static Logs pdv = Logs(displayName: 'Pdv', type: LogType.debug);
  static Logs reports = Logs(displayName: 'Reports', type: LogType.debug);
  static Logs table = Logs(displayName: 'Table', type: LogType.debug);
  static Logs orders = Logs(displayName: 'Orders', type: LogType.debug);
  static Logs wpp = Logs(displayName: 'Wpp', type: LogType.debug);

  static List<Logs> getAll = [
    Logs.client,
    Logs.auth,
    Logs.billing,
    Logs.chatbot,
    Logs.config,
    Logs.deliveryAreas,
    Logs.driver,
    Logs.menu,
    Logs.pdv,
    Logs.reports,
    Logs.table,
    Logs.orders,
    Logs.wpp,
  ];
}
