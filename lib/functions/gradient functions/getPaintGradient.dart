import 'dart:typed_data';

import 'package:custom_path_maker/2D%20Gerometry%20Functions/math/getRectBoundaryPointsFromGivenPoints.dart';
import 'package:custom_path_maker/providers/gradprovider.dart';
import 'dart:ui' as ui;

ui.Gradient getPaintGradientForTileMode(ui.TileMode tileMode, int gradIndex,
    GradProvider gradProvider, ui.Size s, Box box) {
  // log("tilemode $tileMode / grdi $gradIndex");
  ui.Offset topleft = ui.Offset(
      box.center.dx - box.width * 0.5, box.center.dy - box.hashCode * 0.5);
  ui.Offset bottomRight = ui.Offset(
      box.center.dx + box.width * 0.5, box.center.dy + box.hashCode * 0.5);
  return [
    ui.Gradient.linear(
      topleft, bottomRight,
      // ui.Offset(
      //   s.width * (gradProvider.linearAlignStart.x + 1) * 0.5,
      //   s.height * (gradProvider.linearAlignStart.y + 1) * 0.5,
      // ),
      // ui.Offset(
      //   s.width * (gradProvider.linearAlignEnd.x + 1) * 0.5,
      //   s.height * (gradProvider.linearAlignEnd.y + 1) * 0.5,
      // ),
      [
        ...gradProvider.colorStopModels
            .map((e) => ui.Color(int.parse("0x${e.hexColorString}")))
      ],
      [...gradProvider.colorStopModels.map((e) => e.colorStop)],

      tileMode,
    ),
    ui.Gradient.radial(
      ui.Offset(box.center.dx, box.center.dy),

      gradProvider.radialRadius,

      [
        ...gradProvider.colorStopModels
            .map((e) => ui.Color(int.parse("0x${e.hexColorString}")))
      ],
     [...gradProvider.colorStopModels.map((e) => e.colorStop)],
     tileMode,
    

      // focalRadius: gradProvider.radialFocalRadius,
      // focal: gradProvider.radialAlignFocal,
      // center: gradProvider.radialAlignCenter,
      // colors: [
      //   ...gradProvider.colorStopModels
      //       .map((e) => Color(int.parse("0x${e.hexColorString}")))
      // ],
      // radius: gradProvider.radialRadius,
      // tileMode: tileMode
    ),
    // SweepGradient(
    //   startAngle: gradProvider.sweepStartAngle,
    //   endAngle: gradProvider.sweepEndAngle,
    //   colors: (gradProvider.continuousSweep)
    //       ? [
    //           ...gradProvider.colorStopModels
    //               .map((e) => Color(int.parse("0x${e.hexColorString}"))),
    //           Color(int.parse(
    //               "0x${gradProvider.colorStopModels.first.hexColorString}"))
    //         ]
    //       : [
    //           ...gradProvider.colorStopModels
    //               .map((e) => Color(int.parse("0x${e.hexColorString}"))),
    //         ],
    //   stops: (gradProvider.continuousSweep)
    //       ? [
    //           0.0,
    //           ...gradProvider.colorStopModels
    //               .sublist(1, gradProvider.colorStopModels.length - 1)
    //               .map((e) {
    //             return e.colorStop;
    //           }),
    //           gradProvider.colorStopModels.last.colorStop,
    //           1.0
    //         ]
    //       : [
    //           ...gradProvider.colorStopModels.map((e) => e.colorStop),
    //         ],
    //   tileMode: tileMode,
    // ),
  ][gradIndex];
}
