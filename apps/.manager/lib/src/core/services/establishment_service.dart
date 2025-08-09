import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:core/core.dart';
import 'package:manager/l10n/l10n_provider.dart';
import 'package:manager/src/core/datasources/data_source.dart';
import 'package:manager/src/core/models/sync_model.dart';
import 'package:manager/src/modules/home/aplication/usecases/close_establishment_usecase.dart';
import 'package:manager/src/modules/home/aplication/usecases/open_establishment_usecase.dart';
import 'package:manager/src/modules/order/domain/services/log_service.dart';
import 'package:paipfood_package/paipfood_package.dart';

class EstablishmentService extends ChangeNotifier {
  final IClient http;
  final IEstablishmentRepository establishmentRepo;
  final DataSource dataSource;
  final IBucketRepository bucketRepo;
  final ILocalStorage localStorage;

  final OpenEstablishmentUsecase openEstablishmentUsecase;
  final CloseEstablishmentUsecase closeEstablishmentUsecase;

  EstablishmentService({
    required this.http,
    required this.establishmentRepo,
    required this.dataSource,
    required this.bucketRepo,
    required this.localStorage,
    required this.openEstablishmentUsecase,
    required this.closeEstablishmentUsecase,
  }) {
    _init();
  }

  bool isConected = true;
  final log = LogService();

  String get country => LocaleNotifier.instance.locale.name;

  void _init() {
    InternetConnectionChecker.createInstance().onStatusChange.listen((InternetConnectionStatus status) async {
      switch (status) {
        case InternetConnectionStatus.connected:
          if (isConected == false) toast.showSucess(l10nProiver.conexaoReestabelecida, duration: Duration(seconds: 3));
          isConected = true;
          debugPrint('🌍Data connection is available.✅');
          break;
        case InternetConnectionStatus.disconnected:
          isConected = false;
          while (!isConected) {
            debugPrint('🌍You are disconnected from the internet.❌');
            unawaited(log.insertLog(content: "🌍 ❌ CONEXÃO DE INTERNET PERDIDA"));
            toast.showError(l10nProiver.semConexaoInternet, alignment: Alignment.center);
            await Future.delayed(const Duration(seconds: 8));
          }
          break;
      }
    });
  }

  Future<void> openClose() async {
    final isOpen = establishmentProvider.value.isOpen;
    if (isOpen) {
      await closeEstablishmentUsecase.call();
      notifyListeners();
      return;
    }
    await openEstablishmentUsecase.call();
    notifyListeners();
  }

  Future<void> upsertCustomersBucket() async {
    final customersMap = await localStorage.getAll(CustomerModel.box);
    if (customersMap == null || customersMap.isEmpty) return;
    final tempDirectory = await getTemporaryDirectory();
    final String pathFile = join(tempDirectory.path, CustomerModel.box);
    final tempFile = File(pathFile);
    await tempFile.writeAsString(json.encode(customersMap));
    final bytes = await tempFile.readAsBytes();
    final establishmentId = establishmentProvider.value.id;
    await bucketRepo.upsertFile(fileName: CustomerModel.getFileName(establishmentId), fileBytes: bytes);
    await tempFile.delete();
    await localStorage.put(SyncRequestModel.box, key: CustomerModel.box, value: {"updated_at": DateTime.now().pToTimesTamptzFormat()});
  }

  Future<bool> verifySyncCustomer() async {
    final request = await localStorage.get(SyncRequestModel.box, key: CustomerModel.box);
    if (request == null) return true;
    final updatedAt = DateTime.parse(request['updated_at']);
    final now = DateTime.now();
    final diffInDays = updatedAt.difference(now).inDays;
    if (diffInDays < 15) return false;
    return true;
  }

  Future<void> downloadCustomersJsonFile({dynamic Function(int, int)? onReceiveProgress}) async {
    final establishmentId = establishmentProvider.value.id;
    final request = await bucketRepo.downloadFile(path: CustomerModel.getFileName(establishmentId), onReceiveProgress: onReceiveProgress);
    final decode = json.decode(request) as Map;
    final List<Map> maps = [];
    decode.values.toList().map((e) => maps.add(e as Map)).toList();
    await localStorage.putTransaction(CustomerModel.box, values: maps, key: 'phone');
  }
}
