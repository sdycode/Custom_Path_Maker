import 'dart:math';

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
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
                width: w - editOptionW,
                child: SliderTheme(
                  data: sliderThemeData,
                  child: RangeSlider(
                      min: 0,
                      max: pi * 2,
                      values: values,
                      labels: const RangeLabels("Start Angle", "End Angle"),
                      onChanged: (d) {
                        pathModels[pathModelIndex].startSweepAngle = d.start;
                        pathModels[pathModelIndex].endSweepAngle = d.end;
                        p.updateUI();
                      }),
                )),
            ColorStopSlider(
              th: gradColorSliderHeight,
              tw: w - editOptionW,
            )
          ],
        ));
  }
}
