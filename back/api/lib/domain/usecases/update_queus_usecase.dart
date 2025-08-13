import 'package:core/core.dart';

class UpdateQueusUsecase {
  final UpdateQueusApi api;

  UpdateQueusUsecase({required this.api});

  Future<void> call(UpdateQueusEntity updateQueus) async {
    await api.upsert(queus: [updateQueus]);
  }
}
