import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:manager/l10n/l10n_provider.dart';
import 'package:manager/src/core/datasources/data_source.dart';
import 'package:manager/src/core/helpers/assets.dart';
import 'package:manager/src/modules/config/presenters/viewmodels/user_preferences_viewmode.dart';
import 'package:manager/src/modules/home/aplication/usecases/verify_establishment_is_open_usecase.dart';
import 'package:manager/src/modules/order/aplication/usecases/check_orders_in_queue_and_add_to_listusecase.dart';
import 'package:paipfood_package/paipfood_package.dart';

class PeriodicEstablishmentUsecase {
  final DataSource dataSource;
  final VerifyEstablishmentIsOpenUsecase verifyEstablishmentIsOpenUsecase;
  final CheckOrdersInQueueAndAddToStoreUsecase checkOrdersInQueueAndAddToStoreUsecase;
  final UserPreferencesViewmodel userPreferencesViewmodel;

  PeriodicEstablishmentUsecase({required this.dataSource, required this.verifyEstablishmentIsOpenUsecase, required this.checkOrdersInQueueAndAddToStoreUsecase, required this.userPreferencesViewmodel});

  void call() {
    if (userPreferencesViewmodel.userPreferences.isNotPrimaryTerminal) return;
    // 🚀 POLLING REDUZIDO DE 5 MINUTOS PARA 30 SEGUNDOS - CRÍTICO PARA PEDIDOS!
    Timer.periodic(30.seconds, (timer) async {
      if (establishmentProvider.value.isOpen) {
        await checkOrdersInQueueAndAddToStoreUsecase.call(establishmentId: establishmentProvider.value.id, currentOrderNumber: establishmentProvider.value.currentOrderNumber);
      }
      await _verifyOpenCloseEstablishment();
    });
  }

  Future<void> _verifyOpenCloseEstablishment() async {
    final establishment = establishmentProvider.value;
    final bool establishmentIsOpen = verifyEstablishmentIsOpenUsecase.call();
    if (establishmentIsOpen != establishment.isOpen) {
      if (establishmentIsOpen) {
        toast.showInfo(l10nProiver.mensagemAbrirEstabelecimento, duration: 10.seconds);
        _playSound(PSounds.alertOpenEstablishment);
      } else {
        toast.showInfo(l10nProiver.mensagemFecharEstabelecimento, duration: 10.seconds);
        _playSound(PSounds.popTone);
      }
    }
  }

  void _playSound(String assests) async {
    final player = AudioPlayer();
    await player.play(AssetSource(assests), volume: 1);
    await player.onPlayerComplete.first;
    await player.stop();
    await player.dispose();
  }
}
