import 'dart:math';

import 'package:custom_path_maker/2D%20Gerometry%20Functions/math/get_dist_between_2_points.dart';
import 'package:flutter/material.dart';

get_max_radius_for_arc_between_3_points(List<Offset> points) {
  if (points.length != 3) {
    return 1;
  }
  double dist1 = get_dist_between_2_points(points.first, points[1]);
  double dist2 = get_dist_between_2_points(points[2], points[1]);
  return min(
    dist1,
    dist2,
  );
}
