import 'package:core_flutter/core_flutter.dart';
import 'package:flutter/material.dart';
import 'package:store/src/presentation/viewmodels/store_viewmodel.dart';
import 'package:store/src/utils/routes.dart';

class EmptyStoreRedirect {
  EmptyStoreRedirect._();

  static Future<String?> redirect(BuildContext context, GoRouterState state) async {
    final establishmentId = state.pathParameters['establishment_id'];
    if (establishmentId == null) return state.namedLocation('explore');

    final bool parentViewmodelIsInitialized = context.read<StoreViewmodel>().isInitialized;
    if (parentViewmodelIsInitialized == false) return state.namedLocation(Routes.storeNamed, pathParameters: Routes.storeNamedParams(establishmentId));

    return null;
  }
}
