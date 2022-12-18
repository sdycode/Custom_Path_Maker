import 'dart:math';

import 'package:custom_path_maker/enum/enums.dart';
import 'package:custom_path_maker/models/colorStopModel.dart';
import 'package:custom_path_maker/models/curve_point.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class PathModel {
  int pathNo;
  String pathName;
  List<CurvePoint> points = [];
  bool continuousSweep = true;
  bool open;
  bool stroke;
  double rad = 400;
  double focalRad = 0;
  double startSweepAngle = 0;
  double endSweepAngle = pi * 2;
  String hexColorString = "ffaa55";
  List<ColorStopModel> colorStopModels = [
    ColorStopModel(0.0, "fff8b249", 0),
    ColorStopModel(1.0, "fffee795", 0.0)
  ];
  Paint paint = Paint()
    ..color = Colors.red
    ..style = PaintingStyle.fill;
  GradientType gradientType = GradientType.color;
  Offset linearFrom = Offset.zero;
  Offset linearTo = Offset(200, 200);
  Offset center = Offset(100, 100);
  Offset focalCenter = Offset(150, 150);
  Size size;
  TileMode tileMode;
  PathModel.withAllData(
      {required this.pathNo,
      required this.pathName,
      required this.points,
      required this.continuousSweep,
      required this.open,
      required this.stroke,
      required this.rad,
      required this.focalRad,
      required this.startSweepAngle,
      required this.endSweepAngle,
      required this.hexColorString,
      required this.colorStopModels,
      required this.paint,
      required this.gradientType,
      required this.linearFrom,
      required this.linearTo,
      required this.center,
      required this.focalCenter,
      required this.size,
      required this.tileMode});
  PathModel.withCurvePoints(
    this.points, {
    required this.paint,
    this.stroke = false,
    this.open = false,
    this.pathName = "path",
    this.pathNo = 0,
    this.size = const Size(200, 200),
    this.tileMode = TileMode.clamp,
    this.startSweepAngle = 0,
    this.endSweepAngle = pi * 2,
    this.continuousSweep = true,
  });
  factory PathModel.copyWithoutPoints(PathModel pathModel) {
    return PathModel.withAllData(
        pathNo: pathModel.pathNo,
        pathName: pathModel.pathName,
        points: [],
        continuousSweep: pathModel.continuousSweep,
        open: pathModel.open,
        stroke: pathModel.stroke,
        rad: pathModel.rad,
        focalRad: pathModel.focalRad,
        startSweepAngle: pathModel.startSweepAngle,
        endSweepAngle: pathModel.endSweepAngle,
        hexColorString: pathModel.hexColorString,
        colorStopModels: pathModel.colorStopModels,
        paint: pathModel.paint,
        gradientType: pathModel.gradientType,
        linearFrom: pathModel.linearFrom,
        linearTo: pathModel.linearTo,
        center: pathModel.center,
        focalCenter: pathModel.focalCenter,
        size: pathModel.size,
        tileMode: pathModel.tileMode);
  }
  PathModel.withoutPoints(
      {required this.paint,
      required this.stroke,
      required this.open,
      required this.pathName,
      required this.pathNo,
      required this.size,
      required this.tileMode});
}
