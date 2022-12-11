
import 'package:custom_path_maker/2D%20Gerometry%20Functions/functions%20to%20fill%20CurvePoints%20data/get_enums_to_fill_curvePointsList_from_map_data.dart';
import 'package:custom_path_maker/constants/global.dart';
import 'package:custom_path_maker/models/curve_point.dart';

import 'resetPreV_Next_SelfPoint_to_quad_bezier_whenTappedOn_point.dart';

setPointCurveTypeForBezierCurve(int i) {
  int preIndex = i > 0 ? i - 1 : points.length - 1;
  int postIndex = (i + 1) % (points.length);
  CurvePoint point = points[i];
  CurvePoint prePoint = points[preIndex];
  CurvePoint postPoint = points[postIndex];

  if (prePoint.postPointCurveType == PostPointCurveType.normal) {
    point.prePointCurveType = PrePointCurveType.quadBezier;
  }
  if (prePoint.postPointCurveType == PostPointCurveType.arc) {
    point.prePointCurveType = PrePointCurveType.quadBezier;
  }
  if (prePoint.postPointCurveType == PostPointCurveType.quadBezier ||
      prePoint.postPointCurveType == PostPointCurveType.cubicBezier) {
    point.prePointCurveType = PrePointCurveType.cubicBezier;
    prePoint.postPointCurveType = PostPointCurveType.cubicBezier;
  }
// For post section
  if (postPoint.postPointCurveType == PostPointCurveType.normal) {
    point.postPointCurveType = PostPointCurveType.quadBezier;
  }
  if (postPoint.postPointCurveType == PostPointCurveType.arc) {
    point.postPointCurveType = PostPointCurveType.quadBezier;
  }
  if (postPoint.postPointCurveType == PostPointCurveType.quadBezier ||
      postPoint.postPointCurveType == PostPointCurveType.cubicBezier) {
    point.postPointCurveType = PostPointCurveType.cubicBezier;
    postPoint.prePointCurveType = PrePointCurveType.cubicBezier;
  }
  resetPreV_Next_SelfPoint_to_quad_bezier_whenTappedOn_point(i);
}
