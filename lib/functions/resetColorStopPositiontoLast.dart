import 'package:custom_path_maker/constants/global.dart';
import 'package:custom_path_maker/constants/gradient_constants.dart';
import 'package:custom_path_maker/models/PathModel.dart';
import 'package:flutter/material.dart';

resetColorStopPositiontoLastForGivenPathModel(PathModel pathModel) {
  pathModel.colorStopModels.last.left = actualW;
}
setSizeInPathModel(PathModel pathModel){
  pathModel.size  =Size(drawingBoardW, drawingBoardH);
}