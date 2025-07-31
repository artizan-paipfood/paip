import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:core/core.dart';
import 'package:manager/l10n/i18n_extension.dart';
import 'package:manager/src/core/datasources/data_source.dart';
import 'package:manager/src/modules/invoices/presenters/viewmodels/invoice_viewmodel.dart';
import 'package:paipfood_package/paipfood_package.dart';
import 'package:qr_flutter/qr_flutter.dart';

class InvoiceDialogPix extends StatefulWidget {
  final InvoiceViewmodel viewmodel;
  final PixResponse pix;
  const InvoiceDialogPix({required this.viewmodel, required this.pix, super.key});

  @override
  State<InvoiceDialogPix> createState() => _InvoiceDialogPixState();
}

class _InvoiceDialogPixState extends State<InvoiceDialogPix> {
  late final establishment = establishmentProvider;
  bool _isClosing = false;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: !widget.viewmodel.isBlocked,
      child: Dialog(
        backgroundColor: context.color.primaryBG,
        child: Container(
          width: 350,
          decoration: BoxDecoration(borderRadius: PSize.i.borderRadiusAll),
          child: ListenableBuilder(
            listenable: widget.viewmodel,
            builder: (context, __) {
              if (widget.viewmodel.isPaid) {
                Future.delayed(3.5.seconds, () {
                  if (context.mounted) {
                    context.pop();
                  }
                });
              }

              if (widget.viewmodel.paymentState == PaymentState.failed) {
                Future.delayed(100.milliseconds, () {
                  if (context.mounted) {
                    toast.showError(context.i18n.erroAoVerificarPagamento);
                    context.pop();
                  }
                });
              }

              return Stack(
                children: [
                  SingleChildScrollView(
                    child: Padding(
                      padding: PSize.iv.paddingHorizontal + PSize.ii.paddingVertical,
                      child: Column(
                        children: [
                          StreamBuilder(
                            stream: Stream.periodic(1.seconds),
                            builder: (context, snapshot) {
                              final difference = widget.viewmodel.paymentDateLimit?.difference(DateTime.now()) ?? Duration.zero;
                              final minutes = difference.inMinutes;
                              final seconds = difference.inSeconds % 60;
                              final formattedTime = '$minutes:${seconds.toString().padLeft(2, '0')}';

                              if (difference.inSeconds < 0 && !_isClosing) {
                                _isClosing = true;
                                Future.delayed(100.milliseconds, () async {
                                  if (context.mounted) {
                                    context.pop();
                                    toast.showError(context.i18n.encerrandoSistema);
                                    Future.delayed(10.seconds, () => exit(1));
                                  }
                                });
                              }
                              return Column(
                                children: [
                                  Text(formattedTime, textAlign: TextAlign.center, style: context.textTheme.titleLarge?.copyWith(color: difference.inSeconds < 30 ? Colors.red : null)),
                                  Text(context.i18n.aguardandoPagamento, style: context.textTheme.titleMedium),
                                  PSize.i.sizedBoxH,
                                  LinearProgressIndicator(minHeight: 7, borderRadius: PSize.i.borderRadiusAll, backgroundColor: context.color.onPrimaryBG, color: difference.inSeconds < 30 ? Colors.red : context.color.primaryColor),
                                ],
                              );
                            },
                          ),
                          PSize.ii.sizedBoxH,
                          Material(borderRadius: PSize.ii.borderRadiusAll, clipBehavior: Clip.antiAliasWithSaveLayer, child: QrImageView(data: widget.pix.qrCode, foregroundColor: context.color.black)),
                          PSize.ii.sizedBoxH,
                          Text(widget.pix.amount.toStringCurrency, style: context.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
                          PSize.ii.sizedBoxH,
                          Row(
                            children: [
                              Expanded(
                                child: PButton(
                                  label: 'Copia e cola',
                                  icon: Icons.copy,
                                  onPressed: () {
                                    Clipboard.setData(ClipboardData(text: widget.pix.qrCode));
                                    toast.showInfo(context.i18n.copiadoParaAreaTransferencia, alignment: Alignment.bottomCenter);
                                  },
                                ),
                              ),
                            ],
                          ),
                          PSize.ii.sizedBoxH,
                        ],
                      ),
                    ),
                  ),
                  if (widget.viewmodel.isPaid)
                    Center(child: Container(height: 100, width: 100, decoration: BoxDecoration(color: context.color.primaryColor, shape: BoxShape.circle))).animate().scale(begin: const Offset(1, 1), end: const Offset(18, 18), duration: 3.seconds, curve: Curves.easeInOutQuart),
                  if (widget.viewmodel.isPaid)
                    Center(
                      child: Container(height: 100, width: 100, decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle), child: Icon(PaipIcons.check, color: PColors.primaryColor_, size: 80)),
                    ).animate().scale(begin: const Offset(0, 0), end: const Offset(1, 1), curve: Curves.easeInOutBack, delay: 0.5.seconds),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
