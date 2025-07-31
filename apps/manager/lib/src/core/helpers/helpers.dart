import 'package:flutter/material.dart';
import 'package:manager/l10n/i18n_extension.dart';
import 'package:manager/src/core/services/printer/printer_dto.dart';
import 'package:manager/src/core/models/sync_model.dart';
import 'package:manager/src/modules/config/aplication/usecases/printer_usecase.dart';
import 'package:manager/src/modules/menu/domain/models/image_menu_model.dart';
import 'package:paipfood_package/paipfood_package.dart';

class Helpers {
  static Set<String> collections = {
    PreferencesModel.box,
    ItemModel.box,
    CategoryModel.box,
    ComplementModel.box,
    ProductModel.box,
    SizeModel.box,
    MenuDto.box,
    SyncRequestModel.box,
    ImageMenuModel.box,
    CustomerModel.box,
    PrinterEntity.box,
    CustomerDeliveryTaxPolygon.box,
    PrinterUsecase.box,
  };

  static List<String> namesAvatar = [
    "Eduardo",
    "Ana Laura",
    "João",
    "Laura Beatriz",
    "Henrique",
    "Ana Clara",
    "Pedro",
    "Maria Laura",
    "Felipe",
    "Ana Carolina",
    "Augusto",
    "Laura Victoria",
    "Rafael",
    "Ana Júlia",
    "Gabriel",
    "Luana Laura",
    "Vinícius",
    "Ana Luiza",
    "Matheus",
    "Laura Sofia",
    "Carlos",
    "Juliana",
    "Fernando",
    "Isabela",
    "Arthur",
    "Gabriela",
    "Hugo",
    "Mariana",
    "Vinícius",
    "Bianca",
    "Renato",
    "Rafaela",
    "José",
    "Vitória",
    "Paulo",
    "Raquel",
    "Cesar",
    "Monique",
    "Roberto",
    "Sophie",
    "Diego",
    "Larissa",
    "Leonardo",
    "Leticia",
    "Rodrigo",
    "Tatiane",
    "José",
    "Vitória",
    "Paulo",
    "Raquel",
    "Cesar",
    "Monique",
    "Roberto",
    "Sophie",
    "Diego",
    "Larissa",
    "Leonardo",
    "Leticia",
    "Rodrigo",
    "Tatiane",
    "Eduardo",
    "Ana Laura",
    "João",
    "Laura Beatriz",
    "Henrique",
    "Ana Clara",
    "Pedro",
    "Maria Laura",
    "Felipe",
    "Ana Carolina",
    "Augusto",
    "Laura Victoria",
    "Rafael",
    "Ana Júlia",
    "Gabriel",
    "Luana Laura",
    "Vinícius",
    "Ana Luiza",
    "Matheus",
    "Laura Sofia",
    "Carlos",
    "Juliana",
    "Fernando",
    "Isabela",
    "Arthur",
    "Gabriela",
    "Hugo",
    "Mariana",
    "Vinícius",
    "Bianca",
    "Renato",
    "Rafaela",
    "José",
    "Vitória",
    "Paulo",
    "Raquel",
    "Cesar",
    "Monique",
    "Roberto",
    "Sophie",
    "Diego",
    "Larissa",
    "Leonardo",
    "Leticia",
    "Rodrigo",
    "Tatiane",
  ];
  static String lastPurchase(BuildContext context, DateTime purchaseDate) {
    final i18n = context.i18n;
    final now = DateTime.now();
    final difference = now.difference(purchaseDate);

    if (difference.inDays >= 30) {
      final months = (difference.inDays / 30).floor();
      return months == 1 ? i18n.comprouAMes : i18n.comprouAMeses(months);
    }
    if (difference.inDays >= 7) {
      final weeks = (difference.inDays / 7).floor();
      return weeks == 1 ? i18n.comprouASemana : i18n.comprouASemanas(weeks);
    }

    if (difference.inDays >= 1) {
      return difference.inDays == 1 ? i18n.comprouADia : i18n.comprouADias(difference.inDays);
    }
    final hours = difference.inHours;
    if (hours == 0) return i18n.comprouAPouco;
    return hours == 1 ? i18n.comprouAHora : i18n.comprouAHoras(hours);
  }
}
