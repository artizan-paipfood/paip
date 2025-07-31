import 'package:talker/talker.dart';

abstract interface class IPersistentHistory implements TalkerHistory {
  Future<void> initialize();
  Future<void> dispose();
  Future<void> saveHistory();
  Future<void> loadHistory();
}
