
import 'dart:developer';

import 'package:custom_path_maker/2D%20Gerometry%20Functions/functions%20to%20fill%20CurvePoints%20data/get_enums_to_fill_curvePointsList_from_map_data.dart';
import 'package:custom_path_maker/enum/enums.dart';
import 'package:custom_path_maker/functions/Data%20from%20String/offsetFromString.dart';
import 'package:custom_path_maker/functions/Data%20from%20String/sizeFromString.dart';
import 'package:custom_path_maker/models/PathModel.dart';
import 'package:custom_path_maker/models/colorStopModel.dart';
import 'package:custom_path_maker/models/curve_point.dart';
import 'package:flutter/material.dart';

PathModel? getPathModelFromMap(Map map) {
  PathModel? pmod;

  try {
    pmod = PathModel.withAllData(
        pathNo: map["pathNo"] as int,
        pathName: map["pathName"] as String,
        points: [
          ...((map["points"] as List).map((e) {
            log("pointdata aTP ${e['aTP']}");
            CurvePointData pointData = CurvePointData.fromModifedJson(e);

            // log("pointdata ${pointData.aTP} ");
            return CurvePoint.fromCurvePointData(pointData);
          }))
        ],
        continuousSweep: map["continuousSweep"] as bool,
        open: map["open"] as bool,
        stroke: map["stroke"] as bool,
        strokeWidth: (map["strokeWidth"] as double).toDouble(),
        rad: (map["rad"] as double).toDouble(),
        focalRad: (map["focalRad"] as double).toDouble(),
        startSweepAngle: (map["startSweepAngle"] as int).toDouble(),
        endSweepAngle: map["endSweepAngle"] as double,
        hexColorString: map["hexColorString"] as String,
        colorStopModels: [
          ...((map["colorStopModels"] as List).map((e) {
            return ColorStopModel.fromJson(e);
          }))
        ],
        paint: Paint(),
        gradientType:
            // GradientType.color,
            getGradientTypeFromString(map["gradientType"] as String),
        linearFrom:
            // Offset.zero,
            offsetFromString(map["linearFrom"].toString()),
        linearTo:
            // Offset.zero,
            offsetFromString(map["linearTo"].toString()),
        center:
            // Offset.zero,
            offsetFromString(map["center"].toString()),
        focalCenter:
            // Offset.zero,
            offsetFromString(map["focalCenter"].toString()),
        size:
            // Size.zero,
            sizeFromString(map["size"].toString()),
        tileMode:
            // TileMode.clamp,
            getTileModeFromString(map["tileMode"] as String),
        offsetFromOrigin: offsetFromString(map["offsetFromOrigin"].toString()));
  } catch (e) {
    log("pmod errr $e");
  }
  log("pmodd ${pmod}");
  return pmod;
}

