
  import 'package:custom_path_maker/2D%20Gerometry%20Functions/functions%20to%20fill%20CurvePoints%20data/get_enums_to_fill_curvePointsList_from_map_data.dart';
import 'package:custom_path_maker/constants/global.dart';
import 'package:custom_path_maker/functions/resetPreV_Next_SelfPoint_to_quad_bezier_whenTappedOn_point.dart';
import 'package:custom_path_maker/functions/setPointCurveTypeForBezierCurve.dart';
import 'package:custom_path_maker/models/curve_point.dart';

void updatePrePostCurveTypeBasedOnArcTypeOnPoint(int i) {
    int preIndex = i > 0 ? i - 1 : points.length - 1;
    int postIndex = (i + 1) % (points.length);
    CurvePoint point = points[i];
    CurvePoint prePoint = points[preIndex];
    CurvePoint postPoint = points[postIndex];
    switch (point.arcTypeOnPoint) {
      case ArcTypeOnPoint.normal:
        point.prePointCurveType = PrePointCurveType.normal;
        point.postPointCurveType = PostPointCurveType.normal;
        break;
      case ArcTypeOnPoint.arc:
        point.prePointCurveType = PrePointCurveType.arc;
        point.postPointCurveType = PostPointCurveType.arc;
        resetPreV_Next_SelfPoint_to_quad_bezier_whenTappedOn_point(i);
        break;
      case ArcTypeOnPoint.symmetric:
        points[i].pointSymmetry = PointSymmetry.allSymmetry;
        setPointCurveTypeForBezierCurve(i);
        break;
      case ArcTypeOnPoint.nonSymmetric:
        points[i].pointSymmetry = PointSymmetry.nonSymmetric;

        setPointCurveTypeForBezierCurve(i);
        break;
      case ArcTypeOnPoint.angleSymmetric:
        points[i].pointSymmetry = PointSymmetry.angleSymmetry;
        setPointCurveTypeForBezierCurve(i);
        break;
      default:
    }
  }
