import 'package:flutter/foundation.dart';
import 'package:core/core.dart';
import 'package:paipfood_package/paipfood_package.dart';

/// Gerencia o cache e carregamento de taxas de entrega
///
/// Implementa cache inteligente para evitar chamadas desnecessárias à API
/// e garante consistência de dados quando endereços são alterados.
class DeliveryAreaNotifier extends ChangeNotifier {
  IAddressApi searchAddressRepository;
  DeliveryAreaNotifier({required this.searchAddressRepository});

  DeliveryTaxResponse? _deliveryTaxResponse;
  DeliveryTaxResponse? get deliveryTax => _deliveryTaxResponse;

  DeliveryMethod? _deliveryMethod;
  DeliveryMethod? get deliveryMethod => _deliveryMethod;

  void setDeliveryMethod(DeliveryMethod deliveryMethod) {
    _deliveryMethod = deliveryMethod;
  }

  String _untilAddressRequested = '';
  String _untilEstablishmentAddressRequested = '';

  /// Limpa o cache da taxa de entrega
  ///
  /// Deve ser chamado sempre que o endereço do usuário for alterado
  /// para garantir que uma nova taxa seja calculada
  void clearDeliveryTaxCache() {
    _deliveryTaxResponse = null;
    _untilAddressRequested = '';
    _untilEstablishmentAddressRequested = '';
    notifyListeners();
  }

  /// NOVA FUNCIONALIDADE: Verifica se é necessário recarregar a taxa
  /// quando há mudanças de endereço ou estabelecimento
  bool needsReload({
    required AddressEntity userAddress,
    required AddressEntity establishmentAddress,
  }) {
    final bool establishmentAddressEquals = (_untilEstablishmentAddressRequested == establishmentAddress.id);
    final bool userAddressEquals = (_untilAddressRequested == userAddress.id);

    return _deliveryTaxResponse == null || !establishmentAddressEquals || !userAddressEquals;
  }

  /// NOVA FUNCIONALIDADE: Força recarregamento da taxa quando necessário
  Future<void> ensureDeliveryTaxLoaded({
    required AddressEntity userAddress,
    required AddressEntity establishmentAddress,
    required DeliveryMethod deliveryMethod,
  }) async {
    if (needsReload(userAddress: userAddress, establishmentAddress: establishmentAddress)) {
      await loadDeliveryTax(
        address: userAddress,
        establishmentAddress: establishmentAddress,
        deliveryMethod: deliveryMethod,
        forceReload: true,
      );
    }
  }

  /// Carrega a taxa de entrega com cache inteligente
  ///
  /// [userAddress] - Endereço de entrega do usuário
  /// [establishmentAddress] - Endereço do estabelecimento
  /// [deliveryMethod] - Método de entrega configurado
  /// [forceReload] - Se true, ignora cache e força nova consulta
  ///
  /// Retorna [DeliveryTaxResponse] com o valor da taxa calculada
  Future<DeliveryTaxResponse> loadDeliveryTax({
    required AddressEntity address,
    required AddressEntity establishmentAddress,
    required DeliveryMethod deliveryMethod,
    bool forceReload = false,
  }) async {
    final bool establishmentAddressEquals = (_untilEstablishmentAddressRequested == establishmentAddress.id);
    final bool userAddressEquals = (_untilAddressRequested == address.id);

    bool addressCreated = AuthNotifier.instance.auth.user?.addresses.any((element) => element.id == address.id) ?? false;

    // Log de debug para identificar problemas (apenas em desenvolvimento)
    if (kDebugMode) {
      print('🚚 DeliveryAreaNotifier.loadDeliveryTax:');
      print('   - Address ID: ${address.id}');
      print('   - Establishment Address ID: ${establishmentAddress.id}');
      print('   - Cache User Address: $_untilAddressRequested');
      print('   - Cache Establishment Address: $_untilEstablishmentAddressRequested');
      print('   - Has Cache: ${_deliveryTaxResponse != null}');
      print('   - Force Reload: $forceReload');
    }

    // Verifica se pode usar cache (com verificação mais rigorosa)
    if (!forceReload && _deliveryTaxResponse != null && establishmentAddressEquals && userAddressEquals && _deliveryTaxResponse!.price >= 0) {
      if (kDebugMode) {
        print('   ✅ Usando cache - Taxa: R\$ ${_deliveryTaxResponse!.price}');
      }
      return _deliveryTaxResponse!;
    }

    try {
      if (kDebugMode) {
        print('   🔄 Carregando nova taxa de entrega...');
      }

      // DEBUG: Adiciona print para identificar chamadas múltiplas
      if (kDebugMode) {
        print('🔥🔥🔥 FAZENDO CHAMADA API DELIVERY TAX 🔥🔥🔥');
        print('   ⏰ Timestamp: ${DateTime.now().toIso8601String()}');
        print('   📍 User Address: ${address.id} (${address.street})');
        print('   🏪 Establishment: ${establishmentAddress.id}');
        print('   🚚 Delivery Method: ${deliveryMethod.name}');
        print('   💰 Cache atual: ${_deliveryTaxResponse?.price ?? "null"}');
        print('🔥🔥🔥 ============================= 🔥🔥🔥');
      }

      // Adiciona timeout para evitar requests eternos
      _deliveryTaxResponse = await searchAddressRepository
          .deliveryTax(
        request: DeliveryTaxRequest(
          locale: LocaleNotifier.instance.locale,
          deliveryMethod: deliveryMethod,
          establishmentAddressId: establishmentAddress.id,
          userAddessId: addressCreated ? address.id : null,
          establishmentId: establishmentAddress.establishmentId!,
          establishmentLat: establishmentAddress.lat!,
          establishmentLong: establishmentAddress.long!,
          lat: address.lat!,
          long: address.long!,
        ),
      )
          .timeout(
        const Duration(seconds: 30),
        onTimeout: () {
          throw Exception('Timeout ao carregar taxa de entrega');
        },
      );

      _untilAddressRequested = address.id;
      _untilEstablishmentAddressRequested = establishmentAddress.id;

      if (kDebugMode) {
        print('   ✅ Taxa carregada: R\$ ${_deliveryTaxResponse!.price}');
        print('   - Distância: ${_deliveryTaxResponse!.distance}m');
        print('   - Método: ${deliveryMethod.name}');
      }

      notifyListeners();
      return _deliveryTaxResponse!;
    } catch (e) {
      if (kDebugMode) {
        print('   ❌ Erro ao carregar taxa: $e');
      }

      // Em caso de erro, limpa o cache para evitar estados inconsistentes
      clearDeliveryTaxCache();
      rethrow;
    }
  }
}
