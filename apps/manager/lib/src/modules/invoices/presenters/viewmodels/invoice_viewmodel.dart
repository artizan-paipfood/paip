import 'package:flutter/material.dart';
import 'package:core/core.dart';
import 'package:manager/l10n/gen/app_localizations.dart';
import 'package:manager/src/modules/invoices/domain/usecases/invoices_usecase.dart';
import 'package:manager/src/modules/invoices/domain/models/invoice_dialog_model.dart';

enum PaymentState { initial, pending, paid, failed, expired }

class InvoiceViewmodel extends ChangeNotifier {
  final InvoicesUsecase usecase;

  InvoiceViewmodel({required this.usecase});

  static const _paymentCheckDelay = Duration(seconds: 10);
  static const _paymentTimeLimit = Duration(minutes: 5);
  static const _maxRetries = 3;

  final PaymentType _paymentType = PaymentType.pix;

  bool _isBlocked = false;
  bool get isBlocked => _isBlocked;
  bool get isNotBlocked => !_isBlocked;

  PaymentState _paymentState = PaymentState.initial;
  PaymentState get paymentState => _paymentState;
  bool get isPaid => _paymentState == PaymentState.paid;

  bool _isPolling = false;
  int _retryCount = 0;

  DateTime? _paymentDateLimit;
  DateTime? get paymentDateLimit => _paymentDateLimit;

  /// Verifica o status da fatura do estabelecimento
  ///
  /// Retorna um [InvoiceDialogModel] se houver uma fatura pendente ou bloqueada,
  /// null caso contrário.
  Future<InvoiceDialogModel?> checkInvoice(AppLocalizations i18n, {required String establishmentId}) async {
    if (establishmentId.isEmpty) {
      debugPrint('Erro: establishmentId não pode ser vazio');
      return null;
    }

    try {
      final invoice = await usecase.checkInvoice(establishmentId);
      if (invoice != null) {
        if (invoice.isBlocked()) {
          _isBlocked = true;
          notifyListeners();
        }

        if ((invoice.transactionId ?? '').isNotEmpty) {
          await checkPaymentStatus(invoice: invoice);
        }

        if (!isPaid) {
          return InvoiceDialogModel(invoice: invoice, i18n: i18n);
        }
      }
    } catch (e) {
      debugPrint('Erro ao verificar invoice: $e');
      _paymentState = PaymentState.failed;
      notifyListeners();
    }

    return null;
  }

  /// Gera um novo PIX para pagamento
  ///
  /// Inicia o processo de verificação do status do pagamento após a geração.
  Future<PixResponse> generatePix({required EstablishmentInvoiceEntity invoice}) async {
    if (invoice.id.isEmpty) {
      throw Exception('Invoice ID não pode ser vazio');
    }

    try {
      final pix = await usecase.generatePix(invoice: invoice);
      _paymentState = PaymentState.pending;
      _paymentDateLimit = DateTime.now().add(_paymentTimeLimit);
      _retryCount = 0;

      Future.delayed(_paymentCheckDelay, () {
        whilePaymentStatus(invoice: invoice.copyWith(transactionId: pix.id));
      });

      notifyListeners();
      return pix;
    } catch (e) {
      debugPrint('Erro ao gerar Pix: $e');
      _paymentState = PaymentState.failed;
      notifyListeners();
      rethrow;
    }
  }

  /// Verifica o status do pagamento em loop até que seja pago ou expire o tempo
  @visibleForTesting
  Future<void> whilePaymentStatus({required EstablishmentInvoiceEntity invoice}) async {
    if (_isPolling) return;
    _isPolling = true;

    try {
      while (_paymentState == PaymentState.pending && _paymentDateLimit != null && DateTime.now().isBefore(_paymentDateLimit!)) {
        await checkPaymentStatus(invoice: invoice);
        if (_paymentState == PaymentState.paid) break;
        await Future.delayed(_paymentCheckDelay);
      }

      if (_paymentState == PaymentState.pending) {
        _paymentState = PaymentState.expired;
        notifyListeners();
      }
    } finally {
      _isPolling = false;
    }
  }

  /// Verifica o status atual do pagamento
  @visibleForTesting
  Future<void> checkPaymentStatus({required EstablishmentInvoiceEntity invoice}) async {
    final transactionId = invoice.transactionId;
    if (transactionId == null || transactionId.isEmpty) return;

    try {
      final status = await usecase.pixPaymentStatus(id: transactionId);
      if (status.status == PaymentStatus.paid) {
        await usecase.upsert(invoice.copyWith(paymentDate: DateTime.now(), paymentType: _paymentType));
        _paymentState = PaymentState.paid;
        _isBlocked = false;
        notifyListeners();
      }
    } catch (e) {
      debugPrint('Erro ao verificar status de pagamento: $e');
      _retryCount++;

      if (_retryCount >= _maxRetries) {
        _paymentState = PaymentState.failed;
        notifyListeners();
      }
    }
  }

  /// Limpa o estado do ViewModel
  void reset() {
    _isBlocked = false;
    _paymentState = PaymentState.initial;
    _isPolling = false;
    _retryCount = 0;
    _paymentDateLimit = null;
    notifyListeners();
  }
}
