
  import 'package:custom_path_maker/constants/global.dart';
import 'package:flutter/material.dart';

bool isSelectedPoint() {
    if (selectedPoint >= 0 && selectedPoint < points.length) {
      return true;
    }
    return false;
  }

  void setCurvePointJustAfterAdded(int i) {
    if (points.length == 0) {
      return;
    }
    if (i == 1) {
      /// 2nd point added and modify start point (i.e first point along with 2nd)
      /// modify start point
      Offset startPostPoint =
          Offset.lerp(points[0].point, points[1].point, 0.3) ?? points[0].point;
      Offset startPrePoint =
          Offset.lerp(points[0].point, startPostPoint, -0.3) ?? points[0].point;
      points[0].prePoint = startPrePoint;
      points[0].postPoint = startPostPoint;

      /// modify current point
      ///
      Offset prePoint =
          Offset.lerp(points[0].point, points[1].point, 0.7) ?? points[1].point;
      Offset postPoint =
          Offset.lerp(points[0].point, points[1].point, 0.7) ?? points[1].point;
      points[1].prePoint = prePoint;
      points[1].postPoint = postPoint;
    } else if(i>0) {
      /// i>1 [ 2,3,4,. . . . ]
      /// modify post point of previous (i.e  i-1 point)
    
      Offset previousPostPoint =
          Offset.lerp(points[i - 1].point, points[i].point, 0.3) ??
              points[i - 1].point;
      points[i - 1].postPoint = previousPostPoint;

      /// modify current point
      Offset prePoint =
          Offset.lerp(points[i - 1].point, points[i].point, 0.7) ??
              points[i].point;
      Offset postPoint =
          Offset.lerp(points[i].point, points[0].point, 0.3) ?? points[i].point;

      points[i].prePoint = prePoint;
      points[i].postPoint = postPoint;
    }
  }