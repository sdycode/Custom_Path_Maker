import 'package:custom_path_maker/models/curve_point.dart';
import 'package:flutter/material.dart';

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
