  getModelAndEnumsStringData() {
    return '''
import 'package:flutter/material.dart';

enum PrePointCurveType {
  normal,
  arc,
  quadBezier,
  cubicBezier,
}

enum PostPointCurveType {
  normal,
  arc,
  quadBezier,
  cubicBezier,
}

enum PointPosition { normal, start, end }

enum PointSymmetry { angleSymmetry, allSymmetry, nonSymmetric }

enum ArcTypeOnPoint { normal, arc, symmetric, angleSymmetric, nonSymmetric }


class CurvePoint {
  int index = 0;
  Offset point = Offset.zero;
  PrePointCurveType prePointCurveType = PrePointCurveType.normal;
  PostPointCurveType postPointCurveType = PostPointCurveType.normal;
  Offset prePoint = Offset.zero;
  Offset postPoint = Offset.zero;
  Offset preArcEndPoint = Offset.zero;
  Offset postArcEndPoint = Offset.zero;
  double arcRadius = 0;
  double tempArcRadius = 50;
  bool isArcClockwise = true;

  PointPosition pointPosition = PointPosition.normal;
  PointSymmetry pointSymmetry = PointSymmetry.nonSymmetric;
  ArcTypeOnPoint arcTypeOnPoint = ArcTypeOnPoint.normal;
  CurvePoint.withOffset(this.point);
  CurvePoint.withIndexAndOffset({required this.index, required this.point});
  CurvePoint.withAllNamedData(
      {required this.index,
      required this.point,
      required this.pointPosition,
      required this.prePointCurveType,
      required this.postPointCurveType,
      required this.prePoint,
      required this.postPoint,
      required this.preArcEndPoint,
      required this.postArcEndPoint,
      required this.arcRadius,
      required this.tempArcRadius,
      required this.isArcClockwise,
      required this.pointSymmetry,
      required this.arcTypeOnPoint});

  CurvePoint.withAllData(
      this.index,
      this.point,
      this.pointPosition,
      this.prePointCurveType,
      this.postPointCurveType,
      this.prePoint,
      this.postPoint,
      this.preArcEndPoint,
      this.postArcEndPoint,
      this.arcRadius,
      this.tempArcRadius,
      this.isArcClockwise,
      this.pointSymmetry,
      this.arcTypeOnPoint);
  factory CurvePoint.fromCopy(CurvePoint p) {
    CurvePoint point = CurvePoint.withAllNamedData(
        index: p.index,
        point: p.point,
        pointPosition: p.pointPosition,
        prePointCurveType: p.prePointCurveType,
        postPointCurveType: p.postPointCurveType,
        prePoint: p.prePoint,
        postPoint: p.postPoint,
        preArcEndPoint: p.preArcEndPoint,
        postArcEndPoint: p.postArcEndPoint,
        arcRadius: p.arcRadius,
        tempArcRadius: p.tempArcRadius,
        isArcClockwise: p.isArcClockwise,
        pointSymmetry: p.pointSymmetry,
        arcTypeOnPoint: p.arcTypeOnPoint);
   

    return point;
  }
  }


  class PathModel {
  int pathNo;
  String pathName;
  List<CurvePoint> points = [];
  bool open;
  bool stroke;
  Paint paint = Paint()
    ..color = Colors.red
    ..style = PaintingStyle.fill;
  PathModel.withCurvePoints(this.points,
      {required this.paint,
      this.stroke = false,
      this.open = true,
      this.pathName = "path",
      this.pathNo = 0});

  PathModel.withoutPoints(
      {required this.paint,
      required this.stroke ,
      required this.open ,
      required this.pathName ,
      required this.pathNo });
}
''';
  }