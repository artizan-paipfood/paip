// import 'package:flutter/material.dart';
// import 'package:manager/l10n/context_l10n_extension.dart';

// import 'package:paipfood_package/paipfood_package.dart';

// class DialogGeneric extends StatelessWidget {
//   final Future Function()? onConfirm;
//   const DialogGeneric({
//     Key? key,
//     this.onConfirm,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final yes = context.i18n.sim;
//     final key = GlobalKey<FormState>();
//     Future<void> submmit() async {
//       if (key.currentState?.validate() ?? false) {
//         final nav = Navigator.of(context);
//         await onConfirm?.call();
//         nav.pop();
//       }
//     }

//     return CwDialog(
//       title: const Row(
//         children: [
//           // Icon(PIcons.strokeRoundedDelete02, color: context.color.errorColor),
//           // Sz.i.sizedBoxW,
//           Text("Tem certeza que deseja fazer isso?"),
//         ],
//       ),
//       content: Form(
//         key: key,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             const Text("Esta operação não pode ser desfeita, digite SIM para confirmar."),
//             CwTextFormFild(
//               autofocus: true,
//               autovalidateMode: AutovalidateMode.disabled,
//               onFieldSubmitted: (value) async => await submmit(),
//               maskUtils: MaskUtils.cRequired(
//                 customValidate: (value) {
//                   if (value?.toLowerCase() != yes.toLowerCase()) {
//                     return "Digite SIM no campo para confirmar.";
//                   }
//                   return null;
//                 },
//               ),
//             )
//           ],
//         ),
//       ),
//       actions: [
//         CwTextButton(label: context.i18n.cancelar, onPressed: () => Navigator.of(context).pop()),
//         CwTextButton(
//           label: "    OK    ",
//           colorText: context.color.errorColor,
//           onPressedFuture: () async {
//             await submmit();
//           },
//         )
//       ],
//     );
//   }
// }
