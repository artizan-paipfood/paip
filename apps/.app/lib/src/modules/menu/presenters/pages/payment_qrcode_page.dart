// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
//
// import 'package:app/l10n/context_l10n_extension.dart';
//
// import 'package:app/src/core/helpers/routes.dart';
// import 'package:app/src/modules/menu/aplication/stores/menu_store.dart';
// import 'package:paipfood_package/paipfood_package.dart';

// class PaymentQrcodePage extends StatefulWidget {
//   const PaymentQrcodePage({super.key});

//   @override
//   State<PaymentQrcodePage> createState() => _PaymentQrcodePageState();
// }

// class _PaymentQrcodePageState extends State<PaymentQrcodePage> {
//   late final store = context.read<MenuStore>();
//   final DateTime dateLimit = DateTime.now().add(5.minutes);
//   int current = 1;
//   @override
//   void dispose() {
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ListenableBuilder(
//         listenable: store.listenables,
//         builder: (context, __) {
//           if (store.orderStore.order.isPaid) {
//             store.buildOrder(true).then((value) {
//               Future.delayed(3.seconds, () {
//                 if (context.mounted) {
//                   Go.of(context).goNamed(Routes.order.name, pathParameters: Params.orderId.buildParam(store.establishment.id));
//                 }
//               });
//             });
//           }
//           return Stack(
//             children: [
//               Scaffold(
//                 appBar: AppBar(
//                   leading: BackButton(
//                     onPressed: () => Go.of(context).pop(),
//                   ),
//                 ),
//                 body: Padding(
//                   padding: PSize.iv.paddingBottom + PSize.iii.paddingHorizontal,
//                   child: SingleChildScrollView(
//                     child: Column(
//                       children: [
//                         PSize.iii.sizedBoxH,
//                         Row(
//                           children: [
//                             _buildProgress(context, label: context.i18n.gerandoQrCode, step: 0, currentStep: current),
//                             PSize.i.sizedBoxW,
//                             _buildProgress(context, label: context.i18n.aguardandoPagamento, step: 1, currentStep: current),
//                             PSize.i.sizedBoxW,
//                             _buildProgress(context, label: context.i18n.pagamentoRealizado, step: 2, currentStep: current),
//                           ],
//                         ),
//                         PSize.ii.sizedBoxH,
//                         StreamBuilder(
//                           stream: Stream.periodic(1.seconds),
//                           builder: (context, snapshot) {
//                             final difference = dateLimit.difference(DateTime.now());
//                             final minutes = difference.inMinutes;
//                             final seconds = difference.inSeconds % 60;
//                             final formattedTime = '$minutes:${seconds.toString().padLeft(2, '0')}';
//                             if (difference.inSeconds < 0) {
//                               Future.delayed(100.milliseconds, () {
//                                 if (mounted) {
//                                   Go.of(context).pop();
//                                 }
//                               });
//                             }
//                             return Text(
//                               formattedTime,
//                               textAlign: TextAlign.center,
//                               style: context.textTheme.titleLarge,
//                             );
//                           },
//                         ),
//                         PSize.ii.sizedBoxH,
//                         Material(
//                             borderRadius: PSize.ii.borderRadiusAll,
//                             clipBehavior: Clip.antiAliasWithSaveLayer,
//                             child: Image.memory(
//                               base64Decode(store.paymentProvider!.qrCodeBase64!),
//                               fit: BoxFit.fitWidth,
//                             )),
//                         PSize.ii.sizedBoxH,
//                         Text(store.paymentProvider!.value.toStringCurrency, style: context.textTheme.titleLarge),
//                         PSize.ii.sizedBoxH,
//                         Container(
//                           decoration: BoxDecoration(
//                             borderRadius: PSize.i.borderRadiusAll,
//                             border: Border.all(color: context.color.primaryColor),
//                           ),
//                           child: Column(
//                             mainAxisSize: MainAxisSize.min,
//                             children: [
//                               Padding(
//                                 padding: PSize.i.paddingAll,
//                                 child: Text(
//                                   store.paymentProvider!.qrCodeCopyPaste!,
//                                   textAlign: TextAlign.center,
//                                 ),
//                               ),
//                               Row(
//                                 children: [
//                                   Expanded(
//                                     child: PButton(
//                                       label: context.i18n.copiarCodigo,
//                                       icon: Icomoon.document_copy,
//                                       onPressed: () {
//                                         Clipboard.setData(ClipboardData(text: store.paymentProvider!.qrCodeCopyPaste!));
//                                         banner.showSucess(context.i18n.codigoCopiadoSucesso);
//                                       },
//                                     ),
//                                   ),
//                                 ],
//                               )
//                             ],
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//               if (store.order.isPaid)
//                 Center(
//                   child: Container(
//                     height: 100,
//                     width: 100,
//                     decoration: BoxDecoration(color: context.color.primaryColor, shape: BoxShape.circle),
//                   ),
//                 ).animate().scale(begin: const Offset(1, 1), end: const Offset(13, 13), duration: 3.seconds, curve: Curves.easeInOutQuart),
//               if (store.order.isPaid)
//                 Center(
//                   child: Container(
//                     height: 100,
//                     width: 100,
//                     decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
//                     child: const Icon(Icomoon.tick_01, color: PColors.primaryColor_, size: 80),
//                   ),
//                 ).animate().scale(begin: const Offset(0, 0), end: const Offset(1, 1), curve: Curves.easeInOutBack, delay: 2.seconds),
//             ],
//           );
//         });
//   }

//   Widget _buildProgress(BuildContext context, {required String label, required int step, required int currentStep}) {
//     final widget = Column(
//       children: [
//         Text(step != currentStep ? "" : label, style: context.textTheme.titleMedium),
//         PSize.i.sizedBoxH,
//         SizedBox(
//           width: step != currentStep ? null : label.length * 9,
//           child: LinearProgressIndicator(
//             minHeight: 7,
//             borderRadius: PSize.i.borderRadiusAll,
//             backgroundColor: context.color.onPrimaryBG,
//             value: step != currentStep ? 1 : null,
//           ),
//         ),
//       ],
//     );
//     return step != currentStep ? Expanded(child: widget) : widget;
//   }
// }
