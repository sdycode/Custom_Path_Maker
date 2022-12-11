import 'package:custom_path_maker/constants/global.dart';
import 'package:custom_path_maker/functions/checkIfIndexPresentInList.dart';
import 'package:custom_path_maker/functions/updatePrePostBothPointsForPoint.dart';
import 'package:custom_path_maker/providers/path_screen_provider.dart';
import 'package:custom_path_maker/screens/path_drawing_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RadiusSlider extends StatelessWidget {
  const RadiusSlider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PathScreenProvider p = Provider.of<PathScreenProvider>(context);
    return Slider(
        activeColor: Colors.orange,
        value: arcRadius,
        min: 0.0,
        max: 500,
        divisions: 500,
        onChanged: (d) {
          arcRadius = d;

          if (checkIfIndexPresentInList(points, selectedPoint)) {
            points[selectedPoint].tempArcRadius = d;
            updatePrePostBothPointsForPoint(selectedPoint);
          }
          p.updateUI();
        });
  }
}
