import 'dart:developer';

import 'package:custom_path_maker/2D%20Gerometry%20Functions/functions%20to%20fill%20CurvePoints%20data/get_enums_to_fill_curvePointsList_from_map_data.dart';
import 'package:custom_path_maker/constants/global.dart';

void printCurvpoitvsinMapForm() async {
  int c = 0;
  Map<String, List<Map<String, String>>> map = {};
  List<Map<String, String>> mp = [];
  String total = '{"points":[';
  points.forEach((p) {
    log("pppp ${p.arcRadius.toStringAsFixed(4)}+ ${p.tempArcRadius.toStringAsFixed(4)}");
    c++;

    mp.add({
      LongToshortMap["index"]!: p.index.toString(),
      LongToshortMap["pointX"]!: p.point.dx.toStringAsFixed(4),
      LongToshortMap["pointY"]!: p.point.dy.toStringAsFixed(4),
      LongToshortMap["pointPosition"]!:
          p.pointPosition.toString().split('.')[1],
      LongToshortMap["prePointCurveType"]!:
          p.prePointCurveType.toString().split('.')[1],
      LongToshortMap["postPointCurveType"]!:
          p.postPointCurveType.toString().split('.')[1],
      LongToshortMap["prePointX"]!: p.prePoint.dx.toStringAsFixed(4),
      LongToshortMap["prePointY"]!: p.prePoint.dy.toStringAsFixed(4),
      LongToshortMap["postPointX"]!: p.postPoint.dx.toStringAsFixed(4),
      LongToshortMap["postPointY"]!: p.postPoint.dy.toStringAsFixed(4),
      LongToshortMap["preArcEndPointX"]!:
          p.preArcEndPoint.dx.toStringAsFixed(4),
      LongToshortMap["preArcEndPointY"]!:
          p.preArcEndPoint.dy.toStringAsFixed(4),
      LongToshortMap["postArcEndPointX"]!:
          p.postArcEndPoint.dx.toStringAsFixed(4),
      LongToshortMap["postArcEndPointY"]!:
          p.postArcEndPoint.dy.toStringAsFixed(4),
      LongToshortMap["arcRadius"]!: p.arcRadius.toStringAsFixed(4),
      LongToshortMap["tempArcRadius"]!: p.tempArcRadius.toStringAsFixed(4),
      LongToshortMap["isArcClockwise"]!: p.isArcClockwise.toString(),
      LongToshortMap["pointSymmetry"]!:
          p.pointSymmetry.toString().split('.')[1],
      LongToshortMap["arcTypeOnPoint"]!:
          p.arcTypeOnPoint.toString().split('.')[1]
    });
    String data = '''
{
  "${LongToshortMap["index"]!}": "${p.index.toString()}", 
"${LongToshortMap["pointX"]!}" :"${p.point.dx.toStringAsFixed(4)}", 
"${LongToshortMap["pointY"]!}" :"${p.point.dy.toStringAsFixed(4)}",
"${LongToshortMap["pointPosition"]!}" :"${p.pointPosition.toString().split('.')[1]}", 
"${LongToshortMap["prePointCurveType"]!}" :"${p.prePointCurveType.toString().split('.')[1]}", 
"${LongToshortMap["postPointCurveType"]!}" :"${p.postPointCurveType.toString().split('.')[1]}", 
"${LongToshortMap["prePointX"]!}" :"${p.prePoint.dx.toStringAsFixed(4)}", 
"${LongToshortMap["prePointY"]!}" :"${p.prePoint.dy.toStringAsFixed(4)}", 
"${LongToshortMap["postPointX"]!}" :"${p.postPoint.dx.toStringAsFixed(4)}", 
"${LongToshortMap["postPointY"]!}" :"${p.postPoint.dy.toStringAsFixed(4)}", 
"${LongToshortMap["preArcEndPointX"]!}" :"${p.preArcEndPoint.dx.toStringAsFixed(4)}", 
"${LongToshortMap["preArcEndPointY"]!}" :"${p.preArcEndPoint.dy.toStringAsFixed(4)}", 
"${LongToshortMap["postArcEndPointX"]!}" :"${p.postArcEndPoint.dx.toStringAsFixed(4)}", 
"${LongToshortMap["postArcEndPointY"]!}" :"${p.postArcEndPoint.dy.toStringAsFixed(4)}", 
"${LongToshortMap["arcRadius"]!}" :"${p.arcRadius.toStringAsFixed(4)}", 
"${LongToshortMap["tempArcRadius"]!}" :"${p.tempArcRadius.toStringAsFixed(4)}", 
"${LongToshortMap["isArcClockwise"]!}" :"${p.isArcClockwise.toString()}", 
"${LongToshortMap["pointSymmetry"]!}" :"${p.pointSymmetry.toString().split('.')[1]}", 
"${LongToshortMap["arcTypeOnPoint"]!}" :"${p.arcTypeOnPoint.toString().split('.')[1]}" } ${c == points.length ? "" : ","}''';
    total += "\n$data";
  });
  total += "]}";

  // log(total);
  map["points"] = mp;
  // final File file = File(
  //     'E:/Shubham in E/Personal projects/three_d_model_tool/lib/3D Paint/a.json');
  // await file.writeAsString(json.encode(map));
  // log(map.toString());
  // Map<String, List<Map<String, String>>> m =
  //     GetPointsDataFromJson.getMapForPointsof1Path(file);
  // GetPointsDataFromJson.createCurvePointsListFromJson(m);
}
