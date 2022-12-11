
  String getStringOfCommonCanvasFunction() {
    String pathName = "path";
    // pathModel.pathName;
    String pointsName = "pathPoints";
    // "${pathName}Points";
    String paintName = "paint";
    // "${pathName}Paint";
    String isStrokeName = "stroke";
    // "${pathName}IsStroke";
    String openName = "open";
    // "${pathName}open";
    // $isStrokeName= "stroke";
    // $openName= "open";
    // Paint $paintName = Paint()
    return ''' 
void drawCanvasCommonFunction(List<CurvePoint>pathPoints, Paint paint, bool stroke, bool open,Canvas canvas ){
  
      
    Path $pathName = Path();
    if ($pointsName.length < 2) {
      return;
    }

    for (var i = 1; i < $pointsName.length; i++) {
      if (i == 1) {
        // && $pointsName[0].arcTypeOnPoint != ArcTypeOnPoint.arc
        $pathName.moveTo($pointsName.first.point.dx, $pointsName.first.point.dy);
        if (!$isStrokeName) {
          $pathName.moveTo($pointsName[i - 1].postArcEndPoint.dx,
              $pointsName[i - 1].postArcEndPoint.dy);
        }
      } else {}
      if ($pointsName[i - 1].postPointCurveType == PostPointCurveType.arc) {
        // move to
        $pathName.lineTo($pointsName[i - 1].postArcEndPoint.dx,
            $pointsName[i - 1].postArcEndPoint.dy);
      } else {
        // move to
        $pathName.lineTo($pointsName[i - 1].point.dx, $pointsName[i - 1].point.dy);
      }
      int nextIndex = (i + 1) % $pointsName.length;
      int preIndex = i - 1;
      Offset p = $pointsName[i].point;
      Offset pre = $pointsName[i].prePoint;
      Offset postPoint = $pointsName[i].postPoint;
      Offset preArcEnd = $pointsName[i].preArcEndPoint;
      Offset postArcEnd = $pointsName[i].postArcEndPoint;
      Offset prePost = $pointsName[i - 1].postPoint;
      Offset nextPoint = $pointsName[nextIndex].point;

      // Check next of arc  point is cubic bezier ( and make pre point of next as quad from cubic)

      if ($pointsName[i].arcTypeOnPoint == ArcTypeOnPoint.arc) {
        if ($pointsName[nextIndex].prePointCurveType ==
            PrePointCurveType.cubicBezier) {
          $pointsName[nextIndex].prePointCurveType = PrePointCurveType.quadBezier;
        }
      }

      if ($pointsName[i].prePointCurveType == PrePointCurveType.normal) {
        $pathName.lineTo(p.dx, p.dy);
      } else if ($pointsName[i].prePointCurveType == PrePointCurveType.quadBezier) {
        $pathName.quadraticBezierTo(pre.dx, pre.dy, p.dx, p.dy);
        if ($pointsName[nextIndex].arcTypeOnPoint == ArcTypeOnPoint.normal) {
          $pathName.quadraticBezierTo(
              postPoint.dx, postPoint.dy, nextPoint.dx, nextPoint.dy);
          i++;
        }
      } else if ($pointsName[i].prePointCurveType ==
          PrePointCurveType.cubicBezier) {
        $pathName.cubicTo(prePost.dx, prePost.dy, pre.dx, pre.dy, p.dx, p.dy);
      } else if ($pointsName[i].prePointCurveType == PrePointCurveType.arc) {
        if ($pointsName[i - 1].postPointCurveType ==
            PostPointCurveType.quadBezier) {
          $pathName.quadraticBezierTo(
              prePost.dx, prePost.dy, preArcEnd.dx, preArcEnd.dy);
        }
        $pathName.lineTo(preArcEnd.dx, preArcEnd.dy);
        $pathName.arcToPoint(postArcEnd,
            radius: Radius.circular($pointsName[i].arcRadius),
            clockwise: $pointsName[i].isArcClockwise);

       
      }
    }
    if (!$openName) {
      Offset pLast = $pointsName[0].point;
      Offset preLast = $pointsName[0].prePoint;
      Offset preArcEnd = $pointsName[0].preArcEndPoint;
      Offset postArcEnd = $pointsName[0].postArcEndPoint;
      Offset prePostLast = $pointsName.last.postPoint;

      int nextIndex = 1;

      if ($pointsName[0].arcTypeOnPoint == ArcTypeOnPoint.arc) {
        if ($pointsName[nextIndex].prePointCurveType ==
            PrePointCurveType.cubicBezier) {
          $pointsName[nextIndex].prePointCurveType = PrePointCurveType.quadBezier;
        }
      }
      if ($pointsName[0].prePointCurveType == PrePointCurveType.normal) {
        $pathName.lineTo(pLast.dx, pLast.dy);
      } else if ($pointsName[0].prePointCurveType == PrePointCurveType.quadBezier) {
        $pathName.quadraticBezierTo(preLast.dx, preLast.dy, pLast.dx, pLast.dy);
        if ($pointsName[1].arcTypeOnPoint == ArcTypeOnPoint.normal) {
          Offset postPoint = $pointsName[0].postPoint;
          Offset nextPoint = $pointsName[1].point;
          $pathName.quadraticBezierTo(
              postPoint.dx, postPoint.dy, nextPoint.dx, nextPoint.dy);
        
        }
      } else if ($pointsName[0].prePointCurveType ==
          PrePointCurveType.cubicBezier) {
        $pathName.cubicTo(prePostLast.dx, prePostLast.dy, preLast.dx, preLast.dy,
            pLast.dx, pLast.dy);
      } else if ($pointsName[0].prePointCurveType == PrePointCurveType.arc) {
        $pathName.lineTo(preArcEnd.dx, preArcEnd.dy);
        $pathName.arcToPoint(postArcEnd,
            radius: Radius.circular($pointsName[0].arcRadius),
            clockwise: $pointsName[0].isArcClockwise);
         }
      
      if (!$isStrokeName ) {
        $pathName.close();
      }
    }

    canvas.drawPath($pathName, $paintName);
    }''';
  }
