abstract interface class IMessageRepository {
  Future<void> sendMessage({required String phone, required String message});
}
