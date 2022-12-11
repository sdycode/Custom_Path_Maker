import 'dart:developer';

import 'package:custom_path_maker/2D%20Gerometry%20Functions/functions%20to%20fill%20CurvePoints%20data/get_enums_to_fill_curvePointsList_from_map_data.dart';
import 'package:custom_path_maker/2D%20Gerometry%20Functions/math/get_dist_between_2_points.dart';
import 'package:custom_path_maker/constants/global.dart';
import 'package:custom_path_maker/functions/getAndUpdateArcEndPointsOnArcSelectedOnPoint.dart';
import 'package:flutter/material.dart';

updatePrePostPointForSymmetry(bool isPre, int k) {
  log("isPre $isPre / $k /  ${points[k].prePoint} /${points[k].postPoint} / ${points[k].arcTypeOnPoint}");
  if (points[k].arcTypeOnPoint == ArcTypeOnPoint.symmetric) {
    if (isPre) {
      points[k].postPoint =
          Offset.lerp(points[k].prePoint, points[k].point, 2) ??
              points[k].point;
    } else {
      points[k].prePoint =
          Offset.lerp(points[k].postPoint, points[k].point, 2) ??
              points[k].point;
    }
  } else if (points[k].arcTypeOnPoint == ArcTypeOnPoint.angleSymmetric) {
    if (isPre) {
      double distFromControlPoint =
          get_dist_between_2_points(points[k].prePoint, points[k].point);
      double distFromOtherPoint =
          get_dist_between_2_points(points[k].postPoint, points[k].point);
      points[k].postPoint = Offset.lerp(points[k].prePoint, points[k].point,
              1 + distFromOtherPoint / distFromControlPoint) ??
          points[k].point;

      log("pre angle ${points[k].prePoint} /${points[k].postPoint}");
    } else {
      double distFromControlPoint =
          get_dist_between_2_points(points[k].postPoint, points[k].point);
      double distFromOtherPoint =
          get_dist_between_2_points(points[k].prePoint, points[k].point);
      points[k].prePoint = Offset.lerp(points[k].postPoint, points[k].point,
              1 + distFromOtherPoint / distFromControlPoint) ??
          points[k].point;
    }
  }
  int preIndex = k > 0 ? k - 1 : points.length - 1;
  int postIndex = (k + 1) % (points.length);
  getAndUpdateArcEndPointsOnArcSelectedOnPoint(preIndex);
  getAndUpdateArcEndPointsOnArcSelectedOnPoint(k);
  getAndUpdateArcEndPointsOnArcSelectedOnPoint(postIndex);
}