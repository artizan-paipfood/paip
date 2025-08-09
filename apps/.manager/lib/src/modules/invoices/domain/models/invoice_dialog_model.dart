import 'package:core/core.dart';
import 'package:manager/l10n/gen/app_localizations.dart';
import 'package:paipfood_package/paipfood_package.dart' hide AppLocalizations;

class InvoiceDialogModel {
  final EstablishmentInvoiceEntity invoice;
  final AppLocalizations i18n;
  InvoiceDialogModel({required this.invoice, required this.i18n});

  final _format = DateFormat('dd/MM/yyyy');

  String get description {
    if (invoice.isBlocked()) return i18n.faturaDescBloqueado(_format.format(invoice.dueDate));
    return i18n.faturaDescVencimento(_format.format(invoice.dueDate));
  }

  String? get cancelNotice {
    if (invoice.isBlocked()) return null;
    if (invoice.daysUntilDue() != 0) return '';
    if (invoice.daysUntilBlock() != null && invoice.daysUntilBlock() != 0) return i18n.faturaAvisoBloqueio(invoice.daysUntilBlock()!);

    return null;
  }

  String get title {
    if (invoice.isBlocked()) return i18n.sistemaBloqueado;
    if (invoice.daysUntilDue() == 0) return i18n.faturaVencida;
    return i18n.faturaDisponivel;
  }
}
