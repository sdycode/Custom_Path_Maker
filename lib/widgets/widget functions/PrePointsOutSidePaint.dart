// ignore_for_file: non_constant_identifier_names

import 'package:custom_path_maker/2D%20Gerometry%20Functions/functions%20to%20fill%20CurvePoints%20data/get_enums_to_fill_curvePointsList_from_map_data.dart';
import 'package:custom_path_maker/constants/global.dart';
import 'package:custom_path_maker/functions/updatePrePostPointForSymmetry.dart';
import 'package:custom_path_maker/providers/edit_option_provider.dart';
import 'package:custom_path_maker/providers/path_screen_provider.dart';
import 'package:custom_path_maker/screens/path_drawing_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

PrePointsOutSidePaint(BuildContext context) {  PathScreenProvider p = Provider.of<PathScreenProvider>(
    context,
  );
  EditOptionProvider editProvider = Provider.of<EditOptionProvider>(
    context,
  );
 
  return [
    ...(selectedPoints.keys.map((int k) {
      return Positioned(
          left:
              points[k].postPoint.dx - pointSize * 0.5 + drawingBoardLeftOffset,
          top: points[k].postPoint.dy - pointSize * 0.5 + drawingBoardTopOffset,
          child: GestureDetector(
            onTap: () {
              p.updateUI();  editProvider.updateUI();
            },
            onPanUpdate: (d) {
              points[k].postPoint = Offset(
                points[k].postPoint.dx + d.delta.dx,
                points[k].postPoint.dy + d.delta.dy,
              );
              selectedPoint = k;
              if (points[k].pointSymmetry != PointSymmetry.nonSymmetric) {
                bool isPre = false;
                updatePrePostPointForSymmetry(isPre, k);
              }
              p.updateUI();  editProvider.updateUI();
            },
            child: Container(
              width: pointSize,
              height: pointSize,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.green.withAlpha(150),
              ),
            ),
          ));
    })),
  ];
}
