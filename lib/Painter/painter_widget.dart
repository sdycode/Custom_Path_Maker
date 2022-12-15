import 'dart:developer';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:custom_path_maker/2D%20Gerometry%20Functions/functions%20to%20fill%20CurvePoints%20data/get_enums_to_fill_curvePointsList_from_map_data.dart';
import 'package:custom_path_maker/2D%20Gerometry%20Functions/math/getRectBoundaryPointsFromGivenPoints.dart';
import 'package:custom_path_maker/constants/consts.dart';
import 'package:custom_path_maker/constants/global.dart';
import 'package:custom_path_maker/constants/matrix.dart';
import 'package:custom_path_maker/enum/enums.dart';
import 'package:custom_path_maker/functions/checkIfIndexPresentInList.dart';
import 'package:custom_path_maker/models/PathModel.dart';
import 'package:flutter/material.dart';

ui.Shader? getShader(
    GradientType gradientType, PathModel pathModel, Size s, Box box) {
  switch (gradientType) {
    case GradientType.color:
      return null;
    case GradientType.linear:
      // ui.Offset from = ui.Offset(box.center.dx - box.width * 0.5 + 50,
      //     box.center.dy - box.height * 0.5 + 50);
      // ui.Offset to = ui.Offset(box.center.dx + box.width * 0.5 - 150,
      //     box.center.dy + box.height * 0.5 + 50);

      return ui.Gradient.linear(
        pathModel.linearFrom,
        pathModel.linearTo,
        [
          ...pathModel.colorStopModels
              .map((e) => Color(int.parse("0x${e.hexColorString}")))
        ],
        [...pathModel.colorStopModels.map((e) => e.colorStop)],

        // [Colors.red, Colors.amber],
        // [0.2, 0.6],
        pathModel.tileMode,
      );
    case GradientType.radial:
      return ui.Gradient.radial(
          // box.center, s.width * 0.5,
          pathModel.center,
          pathModel.rad,
          [
            ...pathModel.colorStopModels
                .map((e) => Color(int.parse("0x${e.hexColorString}")))
          ],
          [...pathModel.colorStopModels.map((e) => e.colorStop)],
          pathModel.tileMode,
          // Float64List.
          idenityFloat64List(),
          pathModel.focalCenter,
          pathModel.focalRad);
    case GradientType.sweep:
      return ui.Gradient.sweep(
        pathModel.center,
        [
          ...pathModel.colorStopModels
              .map((e) => Color(int.parse("0x${e.hexColorString}")))
        ],
        [...pathModel.colorStopModels.map((e) => e.colorStop)],
        pathModel.tileMode,
        pathModel.startSweepAngle,
        pathModel.endSweepAngle,
      );
    default:
      log("default shader radd");
      return ui.Gradient.linear(Offset.zero, ui.Offset(s.width, s.height), [
        Colors.red, Colors.yellow,

        // )
      ]);
  }
}

class PointPainter extends CustomPainter {
  Box box;
  PathModel pathModel;
  PointPainter(this.box, {required this.pathModel});

  @override
  void paint(Canvas canvas, Size s) {
    // log("sele tilemode in paint ${pathModels[pathModelIndex].tileMode}/  ${pathModel.tileMode}");

    // log("boxdata ${box.width} / ${box.height} / ${h * 0.6} / ${box.center}");
    // log("radd ${pathModel.rad}");
    Shader? shader = getShader(pathModel.gradientType, pathModel, s, box);

    Paint paint = Paint()
      ..strokeWidth = 3
      ..shader = shader
      ..color = ui.Color(int.parse("0xff${pathModel.hexColorString}"))
      ..style = pathModel.stroke ? PaintingStyle.stroke : PaintingStyle.fill;
    Path path = Path();
    if (points.length < 2) {
      return;
    }

    for (var i = 1; i < points.length; i++) {
      if (i == 1) {
        // && points[0].arcTypeOnPoint != ArcTypeOnPoint.arc
        path.moveTo(points.first.point.dx, points.first.point.dy);
        if (!pathModel.stroke) {
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
        // canvas.drawPoints(
        //     ui.PointMode.points,
        //     [preArcEnd, postArcEnd],
        //     Paint()
        //       ..color = Colors.amber
        //       ..strokeWidth = 6);
      }
    }
    if (!pathModel.open) {
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
        // canvas.drawPoints(
        //     ui.PointMode.points,
        //     [preArcEnd, postArcEnd],
        //     Paint()
        //       ..color = Colors.amber
        //       ..strokeWidth = 6);
      }

      if (!pathModel.stroke) {
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
