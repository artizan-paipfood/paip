// import 'package:flutter/material.dart';
// import 'package:manager/src/core/ui/tag_widget.dart';
// import 'package:manager/src/modules/order/aplication/stores/order_store.dart';
// import 'package:paipfood_package/paipfood_package.dart';

// class DialogCourierStatus extends StatelessWidget {
//   final OrderStore store;
//   final OrderModel order;
//   const DialogCourierStatus({required this.store, required this.order, super.key});

//   @override
//   Widget build(BuildContext context) {
//     return FutureState(
//       future: store.waiterService.courierStatus(order: order),
//       onComplete: (context, data) {
//         return AlertDialog(
//           title: const Text('Status'),
//           content: ConstrainedBox(
//             constraints: BoxConstraints(
//               maxHeight: MediaQuery.sizeOf(context).height * 0.8,
//             ),
//             child: SingleChildScrollView(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(data.email),
//                   PSize.i.sizedBoxH,
//                   Text(
//                     data.phone,
//                     style: context.textTheme.bodyMedium?.muted(context),
//                   ),
//                   PSize.i.sizedBoxH,
//                   TagWidget(
//                     label: data.status.name,
//                     colorSelected: data.status.color,
//                   ),
//                   // PSize.i.sizedBoxH,
//                   // const TagWidget(
//                   //   label: "ACCEPTED",
//                   //   colorSelected: Colors.green,
//                   // ),
//                   // PSize.i.sizedBoxH,
//                   // const TagWidget(
//                   //   label: "COLLECTED",
//                   //   colorSelected: Colors.green,
//                   // ),
//                   // PSize.i.sizedBoxH,
//                   // const TagWidget(
//                   //   label: "COMPLETED",
//                   //   colorSelected: Colors.grey,
//                   // ),
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
