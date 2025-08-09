import 'package:manager/l10n/l10n_provider.dart';
import 'package:manager/src/core/datasources/data_source.dart';
import 'package:manager/src/modules/home/aplication/usecases/scheaduling_estavlishment_close_usecase.dart';
import 'package:paipfood_package/paipfood_package.dart';

class OpenEstablishmentUsecase {
  final EstablishmentRepository establishmentRepo;
  final DataSource dataSource;
  final ScheadulingEstavlishmentCloseUsecase scheadulingEstavlishmentCloseUsecase;

  final UpdateQueusRepository updateQueusRepo;
  OpenEstablishmentUsecase({
    required this.establishmentRepo,
    required this.dataSource,
    required this.scheadulingEstavlishmentCloseUsecase,
    required this.updateQueusRepo,
  });
  Future<void> call() async {
    establishmentProvider.value = establishmentProvider.value.copyWith(isOpen: true);
    toast.showSucess(l10nProiver.aberto);
    await establishmentRepo.updateEstablishment(establishment: establishmentProvider.value, authToken: AuthNotifier.instance.accessToken);
    await updateQueusRepo.upsert(UpdateQueusModel.fromEstablishment(establishmentProvider.value));
    scheadulingEstavlishmentCloseUsecase.call();
  }
}
