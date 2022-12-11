import 'dart:developer';

import 'package:custom_path_maker/constants/global.dart';
import 'package:custom_path_maker/functions/code/getPainterEndingBody.dart';
import 'package:custom_path_maker/functions/code/getPainterStartingBody.dart';
import 'package:custom_path_maker/functions/code/getStringOfSinglePathDrawFunCall.dart';
import 'package:custom_path_maker/models/PathModel.dart';

String getAllStringData(String painterClassName) {
  String totalData = "";
  totalData += getPainterStartingBody("$painterClassName");
  for (var i = 0; i < pathModels.length; i++) {
    PathModel pathModel = pathModels[i];

    totalData += getStringOfSinglePathDrawFunCall(
      pathModel,
      i,
    );
  }

  totalData += getPainterEndingBody(painterClassName);
  return totalData;
}
