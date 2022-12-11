
import 'package:custom_path_maker/constants/global.dart';

import 'resetAdjcentCubicToQuadBezeirifSelectedPointIsArc.dart';

resetPreV_Next_SelfPoint_to_quad_bezier_whenTappedOn_point(
    int selectedPointIndex) {
  int i = selectedPointIndex;
  int preIndex = i > 0 ? i - 1 : points.length - 1;
  int postIndex = (i + 1) % (points.length);
  resetAdjcentCubicToQuadBezeirifSelectedPointIsArc(preIndex);
  resetAdjcentCubicToQuadBezeirifSelectedPointIsArc(i);
  resetAdjcentCubicToQuadBezeirifSelectedPointIsArc(postIndex);
}