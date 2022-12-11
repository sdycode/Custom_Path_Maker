
import 'package:custom_path_maker/2D%20Gerometry%20Functions/curves/get_arc_model.dart';
import 'package:custom_path_maker/2D%20Gerometry%20Functions/functions%20to%20fill%20CurvePoints%20data/get_enums_to_fill_curvePointsList_from_map_data.dart';
import 'package:custom_path_maker/constants/global.dart';
import 'package:custom_path_maker/models/arc_model.dart';
import 'package:custom_path_maker/models/curve_point.dart';
import 'package:flutter/material.dart';

getAndUpdateArcEndPointsOnArcSelectedOnPoint(int selectedPointIndex) {
  /// Here arc end points are calclated using [getArcModel] and set these data [radius, clockwise] to curvePoint attributes
  int i = selectedPointIndex;
  int preIndex = i > 0 ? i - 1 : points.length - 1;
  int postIndex = (i + 1) % (points.length);
  CurvePoint point = points[i];
  CurvePoint prePoint = points[preIndex];
  CurvePoint postPoint = points[postIndex];
  List<Offset> arcPoints = [
    Offset(prePoint.point.dx, prePoint.point.dy),
    Offset(point.point.dx, point.point.dy),
    Offset(postPoint.point.dx, postPoint.point.dy),
  ];
  if (prePoint.postPointCurveType == PostPointCurveType.quadBezier ||
      prePoint.postPointCurveType == PostPointCurveType.cubicBezier) {
    arcPoints[0] = Offset(prePoint.postPoint.dx, prePoint.postPoint.dy);
  }
  if (postPoint.prePointCurveType == PrePointCurveType.quadBezier ||
      postPoint.prePointCurveType == PrePointCurveType.cubicBezier) {
    arcPoints[2] = Offset(postPoint.prePoint.dx, postPoint.prePoint.dy);
  }
  Arc3PointModel arc3pointModel =
      getArcModel(arcPoints, points[i].tempArcRadius);

  point.preArcEndPoint = arc3pointModel.startPoint;
  point.postArcEndPoint = arc3pointModel.endPoint;
  point.arcRadius = arc3pointModel.radius;
  point.isArcClockwise = arc3pointModel.isClockwise;
}
