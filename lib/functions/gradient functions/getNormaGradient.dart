import 'package:custom_path_maker/providers/gradprovider.dart';
import 'package:flutter/material.dart';

Gradient getGradientForTileMode(
    TileMode tileMode, int gradIndex, GradProvider gradProvider) {
  // log("tilemode $tileMode / grdi $gradIndex");

  return [
    LinearGradient(
      colors: [
        ...gradProvider.colorStopModels
            .map((e) => Color(int.parse("0x${e.hexColorString}")))
      ],
      begin: gradProvider.linearAlignStart,
      end: gradProvider.linearAlignEnd,
      stops: [...gradProvider.colorStopModels.map((e) => e.colorStop)],
      tileMode: tileMode,
    ),
    RadialGradient(
        focalRadius: 0.4,
        // focal: Alignment(0.5,0.5),
        center:Alignment.center,
        colors: [
          ...gradProvider.colorStopModels
              .map((e) => Color(int.parse("0x${e.hexColorString}")))
        ],
        radius: 0.4,
        tileMode: tileMode
        
        ),
    SweepGradient(
      startAngle: gradProvider.sweepStartAngle,
      endAngle: gradProvider.sweepEndAngle,
      colors: (gradProvider.continuousSweep)
          ? [
              ...gradProvider.colorStopModels
                  .map((e) => Color(int.parse("0x${e.hexColorString}"))),
              Color(int.parse(
                  "0x${gradProvider.colorStopModels.first.hexColorString}"))
            ]
          : [
              ...gradProvider.colorStopModels
                  .map((e) => Color(int.parse("0x${e.hexColorString}"))),
            ],
      stops: (gradProvider.continuousSweep)
          ? [
              0.0,
              ...gradProvider.colorStopModels
                  .sublist(1, gradProvider.colorStopModels.length - 1)
                  .map((e) {
                return e.colorStop;
              }),
              gradProvider.colorStopModels.last.colorStop,
              1.0
            ]
          : [
              ...gradProvider.colorStopModels.map((e) => e.colorStop),
            ],
      tileMode: tileMode,
    ),
  ][gradIndex];
}
