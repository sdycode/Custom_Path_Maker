import 'dart:math';

import 'package:custom_path_maker/constants/button_styles.dart';
import 'package:custom_path_maker/constants/consts.dart';
import 'package:custom_path_maker/constants/global.dart';
import 'package:custom_path_maker/constants/gradient_constants.dart';
import 'package:custom_path_maker/providers/path_screen_provider.dart';
import 'package:custom_path_maker/widgets%20data/sliderThemeData.dart';
import 'package:custom_path_maker/widgets/Gradient/colorStopsSlider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GradSweepRadiusSlider extends StatelessWidget {
  GradSweepRadiusSlider({Key? key}) : super(key: key);
  RangeValues values = RangeValues(pathModels[pathModelIndex].startSweepAngle,
      pathModels[pathModelIndex].endSweepAngle);
  @override
  Widget build(BuildContext context) {
    PathScreenProvider p = Provider.of<PathScreenProvider>(context);
    return Positioned(
        bottom: 0,
        left: 0,
        child: Container(
          width:mainScreenW,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Container(
                        padding:
                            const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                        // width: w - editOptionW,
                        child: SliderTheme(
                          data: sliderThemeData,
                          child: RangeSlider(
                              min: 0,
                              max: pi * 2,
                              activeColor: Colors.orange,
                              values: values,
                              labels: const RangeLabels("Start Angle", "End Angle"),
                              onChanged: (d) {
                                pathModels[pathModelIndex].startSweepAngle =
                                    d.start;
                                pathModels[pathModelIndex].endSweepAngle = d.end;
                                p.updateUI();
                              }),
                        )),
                  ),
                  ElevatedButton.icon(
                      style: openPathButtonStyle,
                      onPressed: () {
                        pathModels[pathModelIndex].continuousSweep =
                            !pathModels[pathModelIndex].continuousSweep;
                        p.updateUI();
                      },
                      icon: Icon(pathModels[pathModelIndex].continuousSweep
                          ? Icons.check_box
                          : Icons.check_box_outline_blank),
                      label: const Text(
                        "Continuous Sweep",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ))
                ],
              ),
              ColorStopSlider(
                th: gradColorSliderHeight,
                tw: mainScreenW,
              )
            ],
          ),
        ));
  }
}
