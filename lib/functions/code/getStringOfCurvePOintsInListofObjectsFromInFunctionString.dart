 import 'package:custom_path_maker/functions/code/getStringOfCurvePOintsInListofObjectsFrom.dart';
import 'package:custom_path_maker/models/PathModel.dart';

String getStringOfCurvePOintsInListofObjectsFromInFunctionString(
      PathModel pathModel) {
    return '''
 List<CurvePoint> getCurvePointsListForPath_${pathModel.pathName}(PathModel pathModel, Size s) {
    double sw = s.width;
    double sh = s.height;
 ${getStringOfCurvePOintsInListofObjectsFrom(pathModel)}
    return ${pathModel.pathName}Points;
  }
''';
  }