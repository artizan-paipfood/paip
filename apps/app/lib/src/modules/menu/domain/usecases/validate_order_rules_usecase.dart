import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:app/l10n/l18n_extension.dart';
import 'package:app/src/core/errors/generic_error.dart';
import 'package:app/src/modules/menu/domain/usecases/verify_is_open_establishment_usecase.dart';
import 'package:app/src/core/notifiers/delivery_area_notifier.dart';
import 'package:paipfood_package/paipfood_package.dart';

class ValidateOrderRulesUsecase {
  final VerifyIsOpenEstablishmentUsecase verifyIsOpenEstablishmentUsecase;

  ValidateOrderRulesUsecase({required this.verifyIsOpenEstablishmentUsecase});

  bool maxDistance(BuildContext context, {required double distance, required double maxDistance}) {
    final distanceResult = Utils.converMetersInMilesOrKm(locale: LocaleNotifier.instance.locale, distance: distance);

    final isValid = maxDistance >= distanceResult;
    if (isValid) return true;
    throw GenericError(message: context.i18n.distanciaMaximaExcedida);
  }

  bool orderType(BuildContext context, {required OrderTypeEnum orderType}) {
    if (orderType == OrderTypeEnum.undefined) {
      throw GenericError(message: context.i18n.erroOrderTypeVazio);
    }
    return true;
  }

  /// NOVA VALIDAÇÃO: Garante que pedidos delivery tenham taxa válida
  bool deliveryTax(BuildContext context, {required OrderTypeEnum orderType, required DeliveryAreaNotifier deliveryAreaNotifier}) {
    if (!orderType.isDelivery) {
      return true; // Não é delivery, não precisa validar taxa
    }

    final deliveryTax = deliveryAreaNotifier.deliveryTax;

    if (deliveryTax == null) {
      // CORREÇÃO: Não lança exceção imediatamente, permite que o sistema tente carregar
      if (kDebugMode) {
        print('⚠️ Validação: Taxa de entrega não encontrada para pedido delivery');
      }
      throw GenericError(message: 'Por favor, selecione um endereço de entrega válido para continuar.');
    }

    if (deliveryTax.price < 0) {
      throw GenericError(message: 'Taxa de entrega inválida. Por favor, tente novamente.');
    }

    return true;
  }

  Future<bool> isOpen(BuildContext context, {required String establishmentId}) async {
    final isOpen = await verifyIsOpenEstablishmentUsecase.call(establishmentId);
    if (!isOpen) {
      if (context.mounted) throw GenericError(message: context.i18n.infelizmenteOEstabelecimentoEstaFechado);
    }
    return true;
  }
}
