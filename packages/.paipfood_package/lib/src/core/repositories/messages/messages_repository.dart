import 'package:core/core.dart';
import 'package:paipfood_package/paipfood_package.dart';

abstract interface class IMessagesRepository {
  Future<List<MessageModel>> getByEstablishmentId(String id, {bool? visible});
  Future<List<MessageModel>> upsert({required List<MessageModel> messages, required AuthModel auth});
  Future<void> delete({required String id, required AuthModel auth, bool isDeleted});
}

class MessagesRepository implements IMessagesRepository {
  final IClient http;
  MessagesRepository({required this.http});
  static const String table = 'messages';
  @override
  Future<List<MessageModel>> getByEstablishmentId(String establishmentId, {bool? visible}) async {
    String filterVisbile = "";
    if (visible != null) filterVisbile = HttpUtils.filterVisible(visible);
    final request = await http.get("/rest/v1/$table?establishment_id=eq.$establishmentId$filterVisbile&select=*");
    final List list = request.data;
    return list.map<MessageModel>((product) {
      return MessageModel.fromMap(product);
    }).toList();
  }

  @override
  Future<List<MessageModel>> upsert({required List<MessageModel> messages, required AuthModel auth}) async {
    final request = await http.post(
      "/rest/v1/$table",
      headers: HttpUtils.headerUpsertAuth(auth),
      data: messages.map((e) => e.toMap()).toList(),
    );
    final List list = request.data;
    return list.map<MessageModel>((product) {
      return MessageModel.fromMap(product);
    }).toList();
  }

  @override
  Future<void> delete({required String id, required AuthModel auth, bool isDeleted = false}) async {
    String query = "id=eq.$id";
    if (isDeleted) query = HttpUtils.queryIsDeleted(isDeleted);
    await http.delete(
      "/rest/v1/$table?$query",
      headers: {"Authorization": "Bearer ${auth.accessToken}"},
    );
  }
}
