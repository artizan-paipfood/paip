abstract class ICacheService {
  Future<void> save({required String box, required Map<String, dynamic> data, DateTime? expiresAt});
  Future<Map<String, dynamic>?> get({required String box});
  Future<void> delete({required String box});
  Future<void> clear();
}
