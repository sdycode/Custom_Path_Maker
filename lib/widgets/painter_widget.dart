import 'dart:ui' as ui;

import 'package:custom_path_maker/2D%20Gerometry%20Functions/functions%20to%20fill%20CurvePoints%20data/get_enums_to_fill_curvePointsList_from_map_data.dart';
import 'package:custom_path_maker/constants/consts.dart';
import 'package:custom_path_maker/constants/global.dart';
import 'package:custom_path_maker/functions/checkIfIndexPresentInList.dart';
import 'package:flutter/material.dart';

class PointPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size s) {
    Paint paint = Paint()
      ..strokeWidth = 3
      // ..color = Colors.red
      ..shader = ui.Gradient.linear(
        Offset.zero,
        Offset(s.width, s.height),
        [Colors.red, Colors.amber],
      )
      ..style = strokePath ? PaintingStyle.stroke : PaintingStyle.fill;
    Path path = Path();
    if (points.length < 2) {
      return;
    }

    for (var i = 1; i < points.length; i++) {
      if (i == 1) {
        // && points[0].arcTypeOnPoint != ArcTypeOnPoint.arc
        path.moveTo(points.first.point.dx, points.first.point.dy);
        if (!strokePath) {
          path.moveTo(points[i - 1].postArcEndPoint.dx,
              points[i - 1].postArcEndPoint.dy);
        }
      } else {}
      if (points[i - 1].postPointCurveType == PostPointCurveType.arc) {
        // move to
        path.lineTo(
            points[i - 1].postArcEndPoint.dx, points[i - 1].postArcEndPoint.dy);
      } else {
        // move to
        path.lineTo(points[i - 1].point.dx, points[i - 1].point.dy);
      }
      int nextIndex = (i + 1) % points.length;
      int preIndex = i - 1;
      Offset p = points[i].point;
      Offset pre = points[i].prePoint;
      Offset postPoint = points[i].postPoint;
      Offset preArcEnd = points[i].preArcEndPoint;
      Offset postArcEnd = points[i].postArcEndPoint;
      Offset prePost = points[i - 1].postPoint;
      Offset nextPoint = points[nextIndex].point;

      // Check next of arc  point is cubic bezier ( and make pre point of next as quad from cubic)

      if (points[i].arcTypeOnPoint == ArcTypeOnPoint.arc) {
        if (points[nextIndex].prePointCurveType ==
            PrePointCurveType.cubicBezier) {
          points[nextIndex].prePointCurveType = PrePointCurveType.quadBezier;
        }
      }

      if (points[i].prePointCurveType == PrePointCurveType.normal) {
        path.lineTo(p.dx, p.dy);
      } else if (points[i].prePointCurveType == PrePointCurveType.quadBezier) {
        path.quadraticBezierTo(pre.dx, pre.dy, p.dx, p.dy);
        if (points[nextIndex].arcTypeOnPoint == ArcTypeOnPoint.normal) {
          path.quadraticBezierTo(
              postPoint.dx, postPoint.dy, nextPoint.dx, nextPoint.dy);
          i++;
        }
      } else if (points[i].prePointCurveType == PrePointCurveType.cubicBezier) {
        path.cubicTo(prePost.dx, prePost.dy, pre.dx, pre.dy, p.dx, p.dy);
      } else if (points[i].prePointCurveType == PrePointCurveType.arc) {
        if (points[i - 1].postPointCurveType == PostPointCurveType.quadBezier) {
          path.quadraticBezierTo(
              prePost.dx, prePost.dy, preArcEnd.dx, preArcEnd.dy);
        }
        path.lineTo(preArcEnd.dx, preArcEnd.dy);
        path.arcToPoint(postArcEnd,
            radius: Radius.circular(points[i].arcRadius),
            clockwise: points[i].isArcClockwise);

        // i++;
        // path.lineTo(nextPoint, y)
        canvas.drawPoints(
            ui.PointMode.points,
            [preArcEnd, postArcEnd],
            Paint()
              ..color = Colors.amber
              ..strokeWidth = 6);
      }
    }
    if (!open) {
      Offset pLast = points[0].point;
      Offset preLast = points[0].prePoint;
      Offset preArcEnd = points[0].preArcEndPoint;
      Offset postArcEnd = points[0].postArcEndPoint;
      Offset prePostLast = points.last.postPoint;

      int nextIndex = 1;

      if (points[0].arcTypeOnPoint == ArcTypeOnPoint.arc) {
        if (points[nextIndex].prePointCurveType ==
            PrePointCurveType.cubicBezier) {
          points[nextIndex].prePointCurveType = PrePointCurveType.quadBezier;
        }
      }
      if (points[0].prePointCurveType == PrePointCurveType.normal) {
        path.lineTo(pLast.dx, pLast.dy);
      } else if (points[0].prePointCurveType == PrePointCurveType.quadBezier) {
        path.quadraticBezierTo(preLast.dx, preLast.dy, pLast.dx, pLast.dy);
        if (points[1].arcTypeOnPoint == ArcTypeOnPoint.normal) {
          Offset postPoint = points[0].postPoint;
          Offset nextPoint = points[1].point;
          path.quadraticBezierTo(
              postPoint.dx, postPoint.dy, nextPoint.dx, nextPoint.dy);
          // i++;
        }
      } else if (points[0].prePointCurveType == PrePointCurveType.cubicBezier) {
        path.cubicTo(prePostLast.dx, prePostLast.dy, preLast.dx, preLast.dy,
            pLast.dx, pLast.dy);
      } else if (points[0].prePointCurveType == PrePointCurveType.arc) {
        path.lineTo(preArcEnd.dx, preArcEnd.dy);
        path.arcToPoint(postArcEnd,
            radius: Radius.circular(points[0].arcRadius),
            clockwise: points[0].isArcClockwise);
        canvas.drawPoints(
            ui.PointMode.points,
            [preArcEnd, postArcEnd],
            Paint()
              ..color = Colors.amber
              ..strokeWidth = 6);
      }

      if (!strokePath) {
        path.close();
      }
    }

    canvas.drawPath(path, paint);

    Path preLinePath = Path();
    Path postLinePath = Path();
    Paint prePathPaint = Paint()
      ..strokeWidth = 1.5
      ..color = Colors.deepPurple
      ..style = PaintingStyle.stroke;
    Paint postPathPaint = Paint()
      ..strokeWidth = 1.5
      ..color = Colors.green
      ..style = PaintingStyle.stroke;

    selectedPoints.forEach((k, v) {
      if (checkIfIndexPresentInList(points, k)) {
        preLinePath.moveTo(points[k].point.dx, points[k].point.dy);
        preLinePath.lineTo(points[k].prePoint.dx, points[k].prePoint.dy);

        postLinePath.moveTo(points[k].point.dx, points[k].point.dy);
        postLinePath.lineTo(points[k].postPoint.dx, points[k].postPoint.dy);
      }
      // preLinePath.moveTo(_p, y)
    });

    canvas.drawPath(preLinePath, prePathPaint);

    canvas.drawPath(postLinePath, postPathPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
