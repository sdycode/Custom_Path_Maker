import 'package:custom_path_maker/constants/global.dart';
import 'package:custom_path_maker/functions/checkIfIndexPresentInList.dart';
import 'package:custom_path_maker/functions/updatePrePostBothPointsForPoint.dart';
import 'package:custom_path_maker/providers/path_screen_provider.dart';
import 'package:custom_path_maker/screens/path_drawing_screen.dart';
import 'package:custom_path_maker/widgets%20data/sliderThemeData.dart';
import 'package:custom_path_maker/widgets%20data/textStyles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StrokeWidthSlider extends StatelessWidget {
  const StrokeWidthSlider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PathScreenProvider p = Provider.of<PathScreenProvider>(context);
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text(
            "Stroke\nWidth",
            textAlign: TextAlign.center,
            style: whiteText.copyWith(fontSize: 10),
          ),
        ),
        Expanded(
            child: SliderTheme(
          data: sliderThemeData,
          child: Slider(
              activeColor: Colors.orange,
              value: pathModels[pathModelIndex].strokeWidth,
              min: 0.5,
              max: 20,
              divisions: 40,
              onChanged: (d) {
                pathModels[pathModelIndex].strokeWidth = d;

                // if (checkIfIndexPresentInList(points, selectedPoint)) {
                //   points[selectedPoint].tempArcRadius = d;
                //   updatePrePostBothPointsForPoint(selectedPoint);
                // }
                p.updateUI();
              }),
        ))
      ],
    );
  }
}
