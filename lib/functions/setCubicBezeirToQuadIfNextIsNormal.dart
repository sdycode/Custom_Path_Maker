import 'package:custom_path_maker/2D%20Gerometry%20Functions/functions%20to%20fill%20CurvePoints%20data/get_enums_to_fill_curvePointsList_from_map_data.dart';
import 'package:custom_path_maker/constants/global.dart';

setCubicBezeirToQuadIfNextIsNormal(int i) {
  int next = (i + 1) % points.length;
  if (points[i].arcTypeOnPoint == ArcTypeOnPoint.normal) {
    if (points[next].prePointCurveType == PrePointCurveType.cubicBezier) {
      points[i].postPointCurveType = PostPointCurveType.normal;
      points[next].prePointCurveType == PrePointCurveType.quadBezier;
    }
  }
}