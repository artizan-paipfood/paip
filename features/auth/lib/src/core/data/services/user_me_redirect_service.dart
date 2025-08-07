import 'package:auth/src/core/data/services/singletons/user_me.dart';
import 'package:auth/src/modules/auth_phone/utils/routes.dart';
import 'package:core_flutter/core_flutter.dart';
import 'package:flutter/cupertino.dart';

class UserMeRedirectService {
  UserMeRedirectService._();

  static Future<String?> call({required BuildContext context, required GoRouterState state}) async {
    if (UserMe.isLoggedIn()) return null;
    return state.namedLocation(Routes.userNameNamed);
  }
}
