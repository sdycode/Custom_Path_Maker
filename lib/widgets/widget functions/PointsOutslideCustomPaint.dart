// ignore_for_file: non_constant_identifier_names

import 'package:custom_path_maker/2D%20Gerometry%20Functions/functions%20to%20fill%20CurvePoints%20data/get_enums_to_fill_curvePointsList_from_map_data.dart';
import 'package:custom_path_maker/constants/get_index_for_list.dart';
import 'package:custom_path_maker/constants/global.dart';
import 'package:custom_path_maker/functions/updatePrePostBothPointsForPoint.dart';
import 'package:custom_path_maker/providers/edit_option_provider.dart';
import 'package:custom_path_maker/providers/path_screen_provider.dart';
import 'package:custom_path_maker/screens/path_drawing_screen.dart';
import 'package:custom_path_maker/widgets/bottomBar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

PointsOutslideCustomPaint(BuildContext context) {
  PathScreenProvider p = Provider.of<PathScreenProvider>(
    context,
  );
  EditOptionProvider editProvider = Provider.of<EditOptionProvider>(
    context,
  );
  return [
    ...(List.generate(points.length, (i) {
      Offset shiftetPosition = Offset(
          points[i].point.dx -
              pointSize * 0.5 +
              drawingBoardLeftOffset +
              pathModels[pathModelIndex].offsetFromOrigin.dx,
          points[i].point.dy -
              pointSize * 0.5 +
              drawingBoardTopOffset +
              pathModels[pathModelIndex].offsetFromOrigin.dy);
      return Positioned(
          left: shiftetPosition.dx,
          top: shiftetPosition.dy,
          child: GestureDetector(
            onTap: () {
              // log("ontapp called on $i");
              selectedPoint = i;
              // if (selectedPoints.containsKey(i)) {
              //   selectedPoints.remove(i);
              // } else {
              //   selectedPoints.putIfAbsent(i, () => i);
              // }
              p.updateUI();
              editProvider.updateUI();
            },
            onPanUpdate: (d) {
              points[i].point = Offset(
                points[i].point.dx + d.delta.dx,
                points[i].point.dy + d.delta.dy,
              );

              points[i].prePoint = Offset(
                points[i].prePoint.dx + d.delta.dx,
                points[i].prePoint.dy + d.delta.dy,
              );
              points[i].postPoint = Offset(
                points[i].postPoint.dx + d.delta.dx,
                points[i].postPoint.dy + d.delta.dy,
              );
              updatePrePostBothPointsForPoint(i);
              p.updateUI();
              editProvider.updateUI();
            },
            child: Transform.scale(
              scale: 1/zoomValue,
              child: Transform.scale(
                scale: selectedPoint == i ? 1.3 : 1.0,
                child: Container(
                  width: pointSize,
                  height: pointSize,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(pointSize * 0.3),
                    border: selectedPoint == i
                        ? Border.all(width: 2, color: Colors.white)
                        : null,
                    color: getItemFromList(i, Colors.primaries),
                  ),
                ),
              ),
            ),
          ));
    }))
  ];
}
