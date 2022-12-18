import 'package:custom_path_maker/models/PathModel.dart';
import 'package:custom_path_maker/models/curve_point.dart';

import 'package:flutter/material.dart';

bool showCUrrentEditingPath = true;
double drawingBoardW = 500;

double drawingBoardH = 500;
int selectedPoint = -1;
double rad = 0.5;
List<CurvePoint> points = [];
double pointSize = 10;
Map<int, int> selectedPoints = {};
double arcRadius = 50;
Size paintBoxSize = const Size(0, 0);
List<PathModel> pathModels = [
  PathModel.withCurvePoints(points,
      paint: Paint()..color = Colors.primaries.first, pathName: "path0")
];
int pathModelIndex = 0;
List<CurvePoint> list = [];
