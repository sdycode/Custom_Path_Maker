

import 'package:custom_path_maker/2D%20Gerometry%20Functions/functions%20to%20fill%20CurvePoints%20data/get_enums_to_fill_curvePointsList_from_map_data.dart';
import 'package:custom_path_maker/constants/global.dart';

resetAdjcentCubicToQuadBezeirifSelectedPointIsArc(int selectedPointIndex) {
  int i = selectedPointIndex;
  int preIndex = i > 0 ? i - 1 : points.length - 1;
  int postIndex = (i + 1) % (points.length);
  // log("resetAdjcentCubicToQuadBezeirifSelectedPointIsArc ${points[i].arcTypeOnPoint}");
  if (points[i].arcTypeOnPoint == ArcTypeOnPoint.arc) {
    if (points[preIndex].postPointCurveType ==
        PostPointCurveType.cubicBezier) {
      points[preIndex].postPointCurveType = PostPointCurveType.quadBezier;
    }
    if (points[postIndex].prePointCurveType ==
        PostPointCurveType.cubicBezier) {
      points[postIndex].prePointCurveType = PrePointCurveType.quadBezier;
    }
  }
}
