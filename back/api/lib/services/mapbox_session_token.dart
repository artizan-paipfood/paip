import 'package:hive_ce/hive.dart';
import 'package:api/dtos/mapbox_sessiontoken.dart';
import 'package:uuid/uuid.dart';

class MapboxSessionToken {
  static MapboxSessionToken? _instance;
  MapboxSessionToken._();
  static MapboxSessionToken get instance => _instance ??= MapboxSessionToken._();

  static const int _inactivityTimeoutInMinutes = 5;
  static const int _tokenExpirationInMinutes = 60;

  MapboxSessiontoken? _sessionToken;
  DateTime? _lastAccessTime;

  Future<String> generate() async {
    final now = DateTime.now();
    if ((_sessionToken != null && _lastAccessTime != null) && now.difference(_lastAccessTime!).inMinutes < _inactivityTimeoutInMinutes) {
      _lastAccessTime = now;
      return _sessionToken!.token;
    }

    await _getSessiontoken();
    _lastAccessTime = now;
    return _sessionToken!.token;
  }

  Future<MapboxSessiontoken> generateNew() async {
    try {
      final box = await Hive.openBox<MapboxSessiontoken>('mapbox');
      final sessionToken = await _createSessiontoken(box);
      await box.close();
      _lastAccessTime = DateTime.now();
      return sessionToken;
    } catch (e) {
      _lastAccessTime = DateTime.now();
      return MapboxSessiontoken(
        token: Uuid().v4(),
        expiresAt: DateTime.now().add(Duration(minutes: _tokenExpirationInMinutes)),
      );
    }
  }

  Future<MapboxSessiontoken> _getSessiontoken() async {
    try {
      final box = await Hive.openBox<MapboxSessiontoken>('mapbox');
      _sessionToken = await _createSessiontoken(box);
      await box.close();
      return _sessionToken!;
    } catch (e) {
      _sessionToken = MapboxSessiontoken(
        token: Uuid().v4(),
        expiresAt: DateTime.now().add(Duration(minutes: _tokenExpirationInMinutes)),
      );
      return _sessionToken!;
    }
  }

  Future<MapboxSessiontoken> _createSessiontoken(Box<MapboxSessiontoken> box) async {
    try {
      final sessionToken = MapboxSessiontoken(
        token: Uuid().v4(),
        expiresAt: DateTime.now().add(Duration(minutes: _tokenExpirationInMinutes)),
      );
      await box.put('sessiontoken', sessionToken);
      return sessionToken;
    } catch (e) {
      return MapboxSessiontoken(
        token: Uuid().v4(),
        expiresAt: DateTime.now().add(Duration(minutes: _tokenExpirationInMinutes)),
      );
    }
  }
}
