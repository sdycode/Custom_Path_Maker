import 'package:custom_path_maker/constants/colors.dart';
import 'package:custom_path_maker/constants/consts.dart';
import 'package:custom_path_maker/constants/global.dart';
import 'package:custom_path_maker/constants/gradient_constants.dart';
import 'package:custom_path_maker/providers/path_screen_provider.dart';
import 'package:custom_path_maker/widgets%20data/sliderThemeData.dart';
import 'package:custom_path_maker/widgets%20data/textStyles.dart';
import 'package:custom_path_maker/widgets/Gradient/colorStopsSlider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GradRadiusSlider extends StatelessWidget {
  const GradRadiusSlider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PathScreenProvider p = Provider.of<PathScreenProvider>(context);
    return Positioned(
      bottom: 0,
      left: 0,
      child: Container(
        width: w - editOptionW,
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: 120,
                  child: const Text(
                    "Radius",textAlign:TextAlign.center ,
                    style: sliderNameTextStyle,
                  ),
                ),
                Expanded(
                  child: SliderTheme(
                    data: sliderThemeData,
                    child: Slider(
                        activeColor: radiusSliderColor,
                        value: pathModels[pathModelIndex].rad,
                        min: 0.0,
                        max: 1000,
                        divisions: 1000,
                        onChanged: (d) {
                          pathModels[pathModelIndex].rad = d;
                          p.updateUI();
                        }),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Container(
                  width: 120,
                  child:  const Text(
                    "Focal Radius",textAlign:TextAlign.center ,
                    style: sliderNameTextStyle,
                  ),
                ),
                Expanded(
                  child: SliderTheme(
                    data: sliderThemeData,
                    child: Slider(
                        activeColor: focalRadiusSliderColor,
                        value: pathModels[pathModelIndex].focalRad,
                        min: 0.0,
                        max: 50,
                        divisions: 50,
                        onChanged: (d) {
                          pathModels[pathModelIndex].focalRad = d;
                          p.updateUI();
                        }),
                  ),
                ),
              ],
            ),
            ColorStopSlider(
              th: gradColorSliderHeight,
              tw: w - editOptionW,
            )
          ],
        ),
      ),
    );
  }
}
