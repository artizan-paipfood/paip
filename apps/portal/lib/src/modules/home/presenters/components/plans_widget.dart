// import 'package:flutter/material.dart';
// import 'package:paipfood_package/paipfood_package.dart';
// import 'package:portal/src/modules/home/presenters/components/card_plan.dart';

// class PlansWidget extends StatelessWidget {
//   const PlansWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Wrap(
//       crossAxisAlignment: WrapCrossAlignment.start,
//       runSpacing: 20,
//       children: [
//         CardPlan(
//           cardPlanModel: CardPlanModel.basic,
//         ),
//         PSize.ii.sizedBoxHW,
//         Stack(
//           children: [
//             Padding(
//               padding: const EdgeInsets.only(right: 2),
//               child: CardPlan(
//                 isSelected: true,
//                 cardPlanModel: CardPlanModel.basic,
//               ),
//             ),
//             Positioned(
//               top: 16,
//               right: -2,
//               child: Container(
//                 decoration: BoxDecoration(color: context.color.primaryColor, borderRadius: 0.5.borderRadiusAll),
//                 child: const Padding(
//                   padding: EdgeInsets.symmetric(vertical: 2, horizontal: 8),
//                   child: Text('Popular', style: TextStyle(color: Colors.white)),
//                 ),
//               ),
//             ),
//           ],
//         ),
//         PSize.ii.sizedBoxHW,
//         CardPlan(
//           cardPlanModel: CardPlanModel.basic,
//         ),
//       ],
//     );
//   }
// }
