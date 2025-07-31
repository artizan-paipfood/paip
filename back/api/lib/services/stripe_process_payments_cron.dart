import 'dart:developer';

import 'package:cron/cron.dart';
import 'package:core/core.dart';
import 'dart:async';
import 'package:api/services/_back_injectors.dart';
import 'package:api/usecases/stripe_split_usecase.dart';

/*
    A sequência 0,30 1-3 * * * usada no método Schedule.parse() significa:
    
    0,30: Os minutos (0 e 30).
    
    0-1: As horas (1 e 3, ou seja, 1 da manhã as 3 da manhã).
    
    *: Todos os dias do mês.
    
    *: Todos os meses.
    
    *: Todos os dias da semana.
*/

class StripeProcessPaymentsCron {
  static StripeProcessPaymentsCron? _instance;
  StripeProcessPaymentsCron._();
  static StripeProcessPaymentsCron get instance => _instance ??= StripeProcessPaymentsCron._();

  final cron = Cron();
  final int batchSize = 10; // Tamanho do lote

  List<String> _chargesIds = [];

  void initialize() {
    final chargesApi = injector.get<IChargesRepository>();
    final spliUsecase = injector.get<StripeSplitUsecase>();
    final viewsApi = injector.get<ViewsApi>();
    // '0,30 1-3 * * *'
    // '*/1 * * * *'
    cron.schedule(Schedule.parse('0,30 1-3 * * *'), () async {
      // Simulando uma lista de pagamentos a serem processados
      log(_chargesIds.join('\n'));
      final response = await chargesApi.getChargesByStatus(status: ChargeStatus.paid);
      final charges = response.where((e) => e.paymentProvider == PaymentProvider.stripe && e.orderId != null).toList();

      //Processar lotes
      for (var batch in _chunk(charges, 50)) {
        await Future.wait(batch.map((charge) => _processCharge(charge: charge, viewsApi: viewsApi, splitUsecase: spliUsecase)));
      }
    });
  }

  Future<void> _processCharge({required ChargeEntity charge, required ViewsApi viewsApi, required StripeSplitUsecase splitUsecase}) async {
    try {
      final orderSplitWithPaymentProvider = await viewsApi.getOrderSplitWithpaymentProviderView(orderId: charge.orderId!);
      await splitUsecase.onProcessSplit(orderSplitWithPaymentProvider: orderSplitWithPaymentProvider, charge: charge, country: charge.locale.name);
    } catch (e) {
      _chargesIds.add('chargeId: ${charge.id} - paymentId: ${charge.paymentId} - orderId: ${charge.orderId!}');
    }
  }

  // Função auxiliar para dividir a lista em chunks (lotes)
  List<List<T>> _chunk<T>(List<T> list, int size) {
    final List<List<T>> chunks = [];
    for (int i = 0; i < list.length; i += size) {
      final int end = (i + size < list.length) ? i + size : list.length;
      chunks.add(list.sublist(i, end));
    }
    return chunks;
  }
}
