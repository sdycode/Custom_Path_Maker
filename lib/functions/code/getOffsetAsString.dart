
  import 'package:flutter/material.dart';

String getOffsetAsString(Offset point, Size paintBoxSize) {
    double sw = paintBoxSize.width;
    double sh = paintBoxSize.height;
    return "Offset(sw*${(point.dx / sw)}, sh*${(point.dy / sh)})";
  }