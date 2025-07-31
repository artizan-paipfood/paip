// import 'dart:convert';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:talker/talker.dart';
// import 'i_persistent_history.dart';
// import 'talker_data_serializer.dart';

// class TalkerHistorySharedPrefs implements IPersistentHistory {
//   TalkerHistorySharedPrefs({
//     required this.talkerId,
//     this.maxHistorySize = 1000,
//   }) {
//     loadHistory();
//   }

//   final String talkerId;
//   final int maxHistorySize;
//   final List<TalkerData> _history = [];

//   static const String _keyPrefix = 'talker_history_';

//   String get _storageKey => '$_keyPrefix$talkerId';

//   @override
//   Future<void> initialize() async {
//     await loadHistory();
//   }

//   @override
//   Future<void> dispose() async {
//     // Não é necessário fazer nada aqui
//   }

//   @override
//   Future<void> saveHistory() async {
//     final prefs = await SharedPreferences.getInstance();
//     final jsonList = _history.map((data) => TalkerDataSerializer.toJson(data)).toList();
//     await prefs.setString(_storageKey, jsonEncode(jsonList));
//   }

//   @override
//   Future<void> loadHistory() async {
//     final prefs = await SharedPreferences.getInstance();
//     final jsonString = prefs.getString(_storageKey);

//     if (jsonString != null) {
//       final jsonList = jsonDecode(jsonString) as List;
//       _history.clear();
//       _history.addAll(jsonList.map((json) => TalkerDataSerializer.fromJson(json as Map<String, dynamic>)));
//     }
//   }

//   @override
//   void write(TalkerData data) {
//     _history.add(data);
//     if (_history.length > maxHistorySize) {
//       _history.removeAt(0);
//     }
//     saveHistory();
//   }

//   @override
//   void clean() async {
//     _history.clear();
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.remove(_storageKey);
//   }

//   @override
//   List<TalkerData> get history => List.unmodifiable(_history);
// }
