import 'dart:typed_data';

import 'package:flutter/material.dart';

import 'package:manager/src/core/datasources/data_source.dart';
import 'package:manager/src/modules/config/aplication/usecases/save_information_establishment_usecase.dart';
import 'package:paipfood_package/paipfood_package.dart';

class AparenceStore {
  final DataSource dataSource;
  final IBucketRepository bucketRepo;
  final IEstablishmentRepository establishmentRepo;
  final SaveInformationEstablishmentUsecase saveInformationEstablishmentUsecase;
  AparenceStore({
    required this.dataSource,
    required this.bucketRepo,
    required this.establishmentRepo,
    required this.saveInformationEstablishmentUsecase,
  });
  var rebuildColors = ValueNotifier(0);
  var rebuildImages = ValueNotifier(0);

  EstablishmentModel get establishment => establishmentProvider.value;

  Future<void> saveImage({required Uint8List bytes, required bool isLogo}) async {
    if (isLogo) {
      establishmentProvider.value = establishment.copyWith(
        imageCacheId: DateTime.now().toString(),
        logoBytes: bytes,
        logo: establishment.buildLogoPath,
      );

      await bucketRepo.upsertImage(fileName: establishment.buildLogoPath, imageBytes: bytes);
    }
    if (isLogo == false) {
      establishmentProvider.value = establishment.copyWith(
        imageCacheId: DateTime.now().toString(),
        bannerBytes: bytes,
        banner: establishment.buildBannerPath,
      );

      await bucketRepo.upsertImageCustom(fileName: establishment.buildBannerPath, imageBytes: bytes, maxSize: 1080);
    }
    await establishmentRepo.updateEstablishment(establishment: establishmentProvider.value, authToken: AuthNotifier.instance.accessToken);
    rebuildImages.value++;
  }

  Future<void> deleteImage(bool isLogo) async {
    if (isLogo) {
      if (establishment.logo == null) return;
      await bucketRepo.deletefile(establishment.buildLogoPath);

      establishmentProvider.value = establishment.copyWith()
        ..logo = null
        ..logoBytes = null;
    }
    if (isLogo == false) {
      if (establishment.banner == null) return;
      await bucketRepo.deletefile(establishment.buildBannerPath);
      establishmentProvider.value = establishment.copyWith()
        ..banner = null
        ..bannerBytes = null;
    }
    await establishmentRepo.updateEstablishment(establishment: establishmentProvider.value, authToken: AuthNotifier.instance.accessToken);
    rebuildImages.value++;
  }

  void changeTheme(ThemeEnum theme) {
    dataSource.company.theme = theme;
  }

  Future<void> save() async {
    await saveInformationEstablishmentUsecase.call();
  }
}
