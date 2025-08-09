import 'package:flutter/material.dart';

import 'package:core/core.dart';
import 'package:manager/l10n/i18n_extension.dart';
import 'package:manager/src/core/helpers/command.dart';
import 'package:manager/src/modules/invoices/domain/models/invoice_dialog_model.dart';
import 'package:manager/src/modules/invoices/presenters/viewmodels/invoice_viewmodel.dart';
import 'package:paipfood_package/paipfood_package.dart';

class InvoiceDialog extends StatefulWidget {
  final InvoiceDialogModel model;
  final InvoiceViewmodel viewmodel;
  final Function(EstablishmentInvoiceEntity invoice) onGeneratePayment;
  const InvoiceDialog({required this.model, required this.onGeneratePayment, required this.viewmodel, super.key});

  @override
  State<InvoiceDialog> createState() => _InvoiceDialogState();
}

class _InvoiceDialogState extends State<InvoiceDialog> {
  bool _isLoading = false;

  void _onPay() => Command0.execute(
        () {
          if (_isLoading) return;
          setState(() => _isLoading = true);
          context.pop();
          widget.onGeneratePayment(widget.model.invoice);
        },
        analyticsDesc: 'invoice_dialog_on_pay',
        onError: (e, s) => toast.showError(context.i18n.erroAoGerarPagamento),
        onFinally: () => setState(() => _isLoading = false),
      );

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: widget.viewmodel,
      builder: (context, _) {
        if (widget.viewmodel.paymentState == PaymentState.failed) {
          Future.delayed(100.milliseconds, () {
            if (context.mounted) {
              toast.showError(context.i18n.erroAoVerificarPagamento);
              Navigator.of(context).pop();
            }
          });
        }

        return PopScope(
          canPop: widget.viewmodel.isNotBlocked,
          child: CwDialog(
            canPop: widget.viewmodel.isNotBlocked,
            title: Text(widget.model.title),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(width: 400),
                Text(widget.model.description, style: context.textTheme.bodyMedium?.muted(context)),
                if (widget.model.cancelNotice != null) Text(widget.model.cancelNotice!, style: context.textTheme.bodyMedium?.copyWith(color: Colors.red)),
                PSize.ii.sizedBoxH,
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (widget.viewmodel.isNotBlocked)
                      CwOutlineButton(
                        label: context.i18n.fechar,
                        onPressed: _isLoading
                            ? null
                            : () {
                                Navigator.pop(context);
                              },
                      ),
                    PSize.ii.sizedBoxW,
                    PButton(label: "${widget.model.invoice.amount.toStringCurrency} - ${context.i18n.pagar}", onPressed: () => _onPay()),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
