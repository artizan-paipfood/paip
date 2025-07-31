import 'dart:io';
import 'package:manager/l10n/l10n_provider.dart';
import 'package:manager/src/core/datasources/data_source.dart';
import 'package:manager/src/modules/home/aplication/usecases/verify_establishment_is_open_usecase.dart';
import 'package:paipfood_package/paipfood_package.dart';

class CloseEstablishmentUsecase {
  final EstablishmentRepository establishmentRepo;
  final DataSource dataSource;
  final VerifyEstablishmentIsOpenUsecase verifyEstablishmentIsOpenUsecase;
  final UpdateQueusRepository updateQueusRepo;
  CloseEstablishmentUsecase({required this.establishmentRepo, required this.dataSource, required this.verifyEstablishmentIsOpenUsecase, required this.updateQueusRepo});

  Future<void> call() async {
    final isOpen = verifyEstablishmentIsOpenUsecase.call();
    if (!isOpen) {
      Future.delayed(3.seconds, () => toast.showInfo(l10nProiver.infoFecharSistemaEmMinutos(30), subtitle: 'Atenção'));
      Future.delayed(30.minutes, () => exit(0));
    }
    establishmentProvider.value = establishmentProvider.value.copyWith(isOpen: false);
    await establishmentRepo.updateEstablishment(establishment: establishmentProvider.value, authToken: AuthNotifier.instance.accessToken);
    await updateQueusRepo.upsert(UpdateQueusModel.fromEstablishment(establishmentProvider.value));
    toast.showSucess(l10nProiver.fechado);
  }
}
