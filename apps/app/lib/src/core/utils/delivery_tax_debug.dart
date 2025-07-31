import 'package:flutter/foundation.dart';
import 'package:core/core.dart';
import 'package:paipfood_package/paipfood_package.dart';
import 'package:app/src/core/notifiers/delivery_area_notifier.dart';

class DeliveryTaxDebug {
  static void logDeliveryState({
    required DeliveryAreaNotifier deliveryAreaNotifier,
    required OrderTypeEnum orderType,
    AddressEntity? userAddress,
    AddressEntity? establishmentAddress,
    String? context,
  }) {
    if (!kDebugMode) return;

    print('🐛 DELIVERY TAX DEBUG ${context != null ? "($context)" : ""}:');
    print('   📍 Order Type: ${orderType.name}');
    print('   👤 User Address: ${userAddress?.id ?? "null"} (${userAddress?.formattedAddress(LocaleNotifier.instance.locale) ?? "não encontrado"})');
    print('   🏪 Establishment Address: ${establishmentAddress?.id ?? "null"}');
    print('   💰 Delivery Tax: ${deliveryAreaNotifier.deliveryTax?.price ?? "null"}');
    print('   🚚 Delivery Method: ${deliveryAreaNotifier.deliveryMethod?.name ?? "null"}');
    print('   ⚡ Auth User: ${AuthNotifier.instance.auth.user?.id ?? "null"}');
    print('   ⚡ Auth User Address: ${AuthNotifier.instance.auth.user?.getAddress?.id ?? "null"}');

    if (deliveryAreaNotifier.deliveryTax != null) {
      final tax = deliveryAreaNotifier.deliveryTax!;
      print('   📊 Tax Details:');
      print('      - Price: R\$ ${tax.price}');
      print('      - Distance: ${tax.distance}m');
      print('      - Straight Distance: ${tax.straightDistance}m');
    }

    // Identifica possíveis problemas
    final problems = <String>[];

    if (orderType.isDelivery && userAddress == null) {
      problems.add('Tipo de pedido é entrega mas não há endereço do usuário');
    }

    if (orderType.isDelivery && deliveryAreaNotifier.deliveryTax == null) {
      problems.add('Tipo de pedido é entrega mas taxa não foi carregada');
    }

    if (orderType.isDelivery && deliveryAreaNotifier.deliveryMethod == null) {
      problems.add('Tipo de pedido é entrega mas método de entrega não definido');
    }

    if (AuthNotifier.instance.auth.user == null) {
      problems.add('Usuário não está autenticado');
    }

    if (AuthNotifier.instance.auth.user?.getAddress == null && orderType.isDelivery) {
      problems.add('Usuário autenticado mas sem endereço principal');
    }

    // NOVOS CHECKS DE SEGURANÇA
    if (orderType.isDelivery && deliveryAreaNotifier.deliveryTax?.price == 0) {
      problems.add('⚠️ CRÍTICO: Taxa de entrega é R\$ 0,00 para pedido delivery');
    }

    if (orderType.isDelivery && deliveryAreaNotifier.deliveryTax != null && deliveryAreaNotifier.deliveryTax!.price < 0) {
      problems.add('❌ ERRO: Taxa de entrega negativa detectada');
    }

    // Verificação de consistência de endereços será implementada futuramente

    if (problems.isNotEmpty) {
      print('   ⚠️ PROBLEMAS IDENTIFICADOS:');
      for (int i = 0; i < problems.length; i++) {
        print('      ${i + 1}. ${problems[i]}');
      }
    } else {
      print('   ✅ Nenhum problema óbvio identificado');
    }

    print(''); // Linha em branco para separar logs
  }

  static void logOrderCalculation({
    required double subtotal,
    required double deliveryTax,
    required double discount,
    required double total,
    required OrderTypeEnum orderType,
  }) {
    if (!kDebugMode) return;

    print('🧮 CÁLCULO DO PEDIDO:');
    print('   💵 Subtotal: R\$ ${subtotal.toStringAsFixed(2)}');
    print('   🚚 Taxa de Entrega: R\$ ${deliveryTax.toStringAsFixed(2)} (${orderType.name})');
    print('   🎫 Desconto: R\$ ${discount.toStringAsFixed(2)}');
    print('   💰 Total: R\$ ${total.toStringAsFixed(2)}');
    print('   📝 Fórmula: $subtotal + $deliveryTax - $discount = $total');

    if (orderType.isDelivery && deliveryTax == 0) {
      print('   ⚠️ ATENÇÃO: Pedido é entrega mas taxa é R\$ 0,00');
    }

    print('');
  }
}
