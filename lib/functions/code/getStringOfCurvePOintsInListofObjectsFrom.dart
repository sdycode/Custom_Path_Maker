import 'dart:developer';

import 'package:custom_path_maker/constants/global.dart';
import 'package:custom_path_maker/functions/code/getOffsetAsString.dart';
import 'package:custom_path_maker/models/PathModel.dart';
import 'package:custom_path_maker/models/curve_point.dart';

String getStringOfCurvePOintsInListofObjectsFrom(PathModel pathModel) {
  double sw = paintBoxSize.width;
  double sh = paintBoxSize.height;
  List<CurvePoint> ps = pathModel.points;
  String total = '''List<CurvePoint> ${pathModel.pathName}Points =[''';
  int c = 0;
  ps.forEach((p) {
    String data =
        '''CurvePoint.withAllData(${p.index}, ${getOffsetAsString(p.point, paintBoxSize)}, ${p.pointPosition}, ${p.prePointCurveType}, ${p.postPointCurveType},${getOffsetAsString(p.prePoint, paintBoxSize)} ,${getOffsetAsString(p.postPoint, paintBoxSize)} ,${getOffsetAsString(p.preArcEndPoint, paintBoxSize)} ,${getOffsetAsString(p.postArcEndPoint, paintBoxSize)} , ${p.arcRadius}, ${p.tempArcRadius}, ${p.isArcClockwise}, ${p.pointSymmetry}, ${p.arcTypeOnPoint}),''';

    total += data;
    c++;
  });
  total += '];';
  log("newdata $total");
  return total;
}
