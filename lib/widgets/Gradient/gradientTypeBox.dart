// import 'package:custom_path_maker/constants/consts.dart';
// import 'package:custom_path_maker/enum/enums.dart';
// import 'package:custom_path_maker/functions/gradient%20functions/getNormaGradient.dart';
// import 'package:custom_path_maker/providers/gradprovider.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// const double _textBoxH = 25;

// class GradientTypeBoxesWidget extends StatelessWidget {
//   GradientTypeBoxesWidget({Key? key}) : super(key: key);

//   double gradboxH = editOptionW * 0.25 + _textBoxH;
//   late GradProvider gradProvider;
//   @override
//   Widget build(BuildContext context) {
//      gradProvider =
//         Provider.of<GradProvider>(context, listen: true);
//     return Container(
//       // width: gradeSelectBoxW + w * 0.05 + 6,
//       // width: w * 0.,
//       width: editOptionW,
//       height: gradboxH,
//       child: Row(
//         mainAxisSize: MainAxisSize.max,
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: [
//           ...List.generate(
//               GradientType.values.length, (i) => _gradientSelectionBox(i))
//         ],
//       ),
//     );
//   }

//   _gradientSelectionBox(int i) {
//     return Transform.scale(
//       scale: gradProvider.gradientType == GradientType.values[i] ? 1.1 : 1,
//       child: InkWell(
//         onTap: () {
//           gradProvider.gradientType = GradientType.values[i];
//           gradProvider.updateUi();
//         },
//         child: Container(
//           margin: const EdgeInsets.symmetric(horizontal: 10),
//           child: Column(
//             children: [
//               Container(
//                 height: gradboxH,
//                 width: gradboxH,
//                 decoration: BoxDecoration(
//                     color: Colors.green,
//                     border: gradProvider.gradientType == GradientType.values[i]
//                         ? Border.all(color: Colors.white, width: 4)
//                         : null,
//                     borderRadius: BorderRadius.circular(8),
//                     gradient: getGradientForTileMode(TileMode.values[i], i, gradProvider)),
//               ),
//               Container(
//                 width: w * 0.05,
//                 height: 40,
//                 child: Center(
//                   child: Text(
//                     GradientType.values[i]
//                         .toString()
//                         .split('.')[1]
//                         .toUpperCase(),
//                     style: const TextStyle(color: Colors.white),
//                   ),
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
