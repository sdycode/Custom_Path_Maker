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
      paint: Paint()..color = Colors.primaries.first, pathName: "path0",
      
      size: Size(drawingBoardW, drawingBoardH)
      )
];
int pathModelIndex = 0;
List<CurvePoint> list = [];
List<String> hexColors = [
  "ffaa55",
  "ee9ca7",
"ffdde1",
"2193b0",
"6dd5ed",
"FBD786",
"f7797d",
"c471ed",
"f7797d",
"373B44",
"4286f4",
"6DD5FA",
"FFFFFF",
"2980B9",
"6DD5FA",
"FF0099",
"493240",
"1f4037",
"99f2c8",
"f12711",
"f5af19",
"005AA7",
"FFFDE4",
"a8c0ff",
"3f2b96",
"fffbd5",
"b20a2c",
];
