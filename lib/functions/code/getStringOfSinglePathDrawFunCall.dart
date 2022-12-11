import 'package:custom_path_maker/constants/global.dart';
import 'package:custom_path_maker/models/PathModel.dart';

getStringOfSinglePathDrawFunCall(PathModel pathModel, int i) {
    String pointsName = "${pathModels[i].pathName}Points";
    return '''\nList<CurvePoint> $pointsName = getCurvePointsListForPath_${pathModels[i].pathName}(pathModels[$i],s);
    drawCanvasForPath${pathModels[i].pathName}(pathModels[$i],canvas,$pointsName);''';
  }