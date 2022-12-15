// ignore_for_file: unrelated_type_equality_checks, non_constant_identifier_names

import 'dart:developer';

import 'package:custom_path_maker/2D%20Gerometry%20Functions/functions%20to%20fill%20CurvePoints%20data/get_enums_to_fill_curvePointsList_from_map_data.dart';
import 'package:custom_path_maker/2D%20Gerometry%20Functions/math/getRectBoundaryPointsFromGivenPoints.dart';
import 'package:custom_path_maker/constants/consts.dart';
import 'package:custom_path_maker/constants/get_index_for_list.dart';
import 'package:custom_path_maker/constants/global.dart';
import 'package:custom_path_maker/enum/enums.dart';
import 'package:custom_path_maker/functions/setCurvePointJustAfterAdded.dart';
import 'package:custom_path_maker/functions/updatePrePostBothPointsForPoint.dart';
import 'package:custom_path_maker/functions/updatePrePostPointForSymmetry.dart';
import 'package:custom_path_maker/models/curve_point.dart';
import 'package:custom_path_maker/providers/path_screen_provider.dart';
import 'package:custom_path_maker/widgets/Gradient/colorStopsSlider.dart';
import 'package:custom_path_maker/widgets/Gradient/gradRadiusSlider.dart';
import 'package:custom_path_maker/widgets/Gradient/gradSweepRadiusSlider.dart';
import 'package:custom_path_maker/widgets/Gradient/gradControlPoints.dart';
import 'package:custom_path_maker/widgets/PointCurvetypeWidget.dart';
import 'package:custom_path_maker/widgets/bottomBar.dart';
import 'package:custom_path_maker/widgets/editOptions_widget.dart';
import 'package:custom_path_maker/Painter/painter_widget.dart';
import 'package:custom_path_maker/widgets/topbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' hide Gradient;
import 'package:provider/provider.dart';
  double drawingBoardLeftOffset = 100;
  double drawingBoardTopOffset = 100;
class PathDrawingScreen extends StatefulWidget {
  const PathDrawingScreen({Key? key}) : super(key: key);

  @override
  State<PathDrawingScreen> createState() => _PathDrawingScreenState();
}
// somnathyeole1967

// get
class _PathDrawingScreenState extends State<PathDrawingScreen> {
  late PathScreenProvider p;

  @override
  Widget build(BuildContext context) {
    paintBoxSize = Size(h * 0.8, h * 0.8);

    const fontarm = "Arapey-Regular";

    ///Package name

    PathScreenProvider p = Provider.of<PathScreenProvider>(context);
    // log("hei $h : ${MediaQuery.of(context).size.height} / points ${points.length}");
    // log("gradd  $isGradient / ${pathModels[pathModelIndex].gradientType.name}");
//     isGradient
// pathModels[pathModelIndex]
//                                             .gradientType
//                                             .name ==
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            children: [
              const TopBar(),
              Container(
                width: w,
                height: mainScreenH,
                child: Stack(
                    clipBehavior: Clip.none,
                    fit: StackFit.expand,
                    children: [
                      // Positioned(right: 0, bottom: 0, child: ColorsRow(w * 0.4, 30)),

                      const EditOptions_widget(),
                      // width: h * 0.6,
                      //                           height: h * 0.6,
                      Positioned(
                          left: drawingBoardLeftOffset,
                          top: drawingBoardTopOffset,
                          child: Container(
                            height: h * 0.6,
                            width: h * 0.6,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.white)),
                            child: CustomPaint(
                              painter: PointPainter(
                                  getBoxForPoints(
                                      points.map((e) => e.point).toList()),
                                  pathModel: pathModels.first),
                              child: Stack(
                                  fit: StackFit.expand,
                                  clipBehavior: Clip.none,
                                  children: [
                                    GestureDetector(
                                      onTapUp: (d) {
                                        points.add(
                                            CurvePoint.withIndexAndOffset(
                                                index: points.length,
                                                point: d.localPosition));
                                        selectedPoint = points.length - 1;
                                        setCurvePointJustAfterAdded(
                                            selectedPoint);
                                        setState(() {});
                                      },
                                      child: Container(
                                        width: double.infinity,
                                        height: double.infinity,
                                        color: Colors.transparent,
                                      ),
                                    ),
                                    // if (!isGradient &&
                                    //     pathModels[pathModelIndex]
                                    //             .gradientType
                                    //             .name
                                    //             .toString() ==
                                    //         GradientType.linear.name.toString())
                                    //   LinearGradControlPoints(),
                                    // if (!isGradient &&
                                    //     pathModels[pathModelIndex]
                                    //             .gradientType
                                    //             .name
                                    //             .toString() ==
                                    //         GradientType.radial.name.toString())
                                    //   RadialGradControlPoints(),
                                    // if (!isGradient &&
                                    //     pathModels[pathModelIndex]
                                    //             .gradientType
                                    //             .name
                                    //             .toString() ==
                                    //         GradientType.sweep.name.toString())
                                    //   SweepGradControlPoint()
                                  ]),
                            ),
                          )),

                      ...PointsOutslideCustomPaint(p),
                      ...PrePointsOutSidePaint(p),
                      ...PostPointsOutSidePaint(p),
                        if (!isGradient &&
                                        pathModels[pathModelIndex]
                                                .gradientType
                                                .name
                                                .toString() ==
                                            GradientType.linear.name.toString())
                                      LinearGradControlPoints(),
                                    if (!isGradient &&
                                        pathModels[pathModelIndex]
                                                .gradientType
                                                .name
                                                .toString() ==
                                            GradientType.radial.name.toString())
                                      RadialGradControlPoints(),
                                    if (!isGradient &&
                                        pathModels[pathModelIndex]
                                                .gradientType
                                                .name
                                                .toString() ==
                                            GradientType.sweep.name.toString())
                                      SweepGradControlPoint(),

                      if (!isGradient &&
                          pathModels[pathModelIndex]
                                  .gradientType
                                  .name
                                  .toString() ==
                              GradientType.radial.name.toString())
                        GradRadiusSlider(),

                      if (!isGradient &&
                          pathModels[pathModelIndex]
                                  .gradientType
                                  .name
                                  .toString() ==
                              GradientType.sweep.name.toString())
                        GradSweepRadiusSlider(),
                    ]),
              ),
              const BottomBar()
            ],
          )),
    );
  }



  PointsOutslideCustomPaint(PathScreenProvider p) {
    return [
      ...(List.generate(points.length, (i) {
        return Positioned(
            left: points[i].point.dx - pointSize * 0.5 + drawingBoardLeftOffset,
            top: points[i].point.dy - pointSize * 0.5 + drawingBoardTopOffset,
            child: GestureDetector(
              onTap: () {
                log("ontapp called on $i");
                selectedPoint = i;
                if (selectedPoints.containsKey(i)) {
                  selectedPoints.remove(i);
                } else {
                  selectedPoints.putIfAbsent(i, () => i);
                }
                p.updateUI();
              },
              onPanUpdate: (d) {
                points[i].point = Offset(
                  points[i].point.dx + d.delta.dx,
                  points[i].point.dy + d.delta.dy,
                );

                points[i].prePoint = Offset(
                  points[i].prePoint.dx + d.delta.dx,
                  points[i].prePoint.dy + d.delta.dy,
                );
                points[i].postPoint = Offset(
                  points[i].postPoint.dx + d.delta.dx,
                  points[i].postPoint.dy + d.delta.dy,
                );
                updatePrePostBothPointsForPoint(i);
                p.updateUI();
              },
              child: Transform.scale(
                scale: selectedPoint == i ? 1.3 : 1.0,
                child: Container(
                  width: pointSize,
                  height: pointSize,
                  decoration: BoxDecoration(
                    border: selectedPoint == i
                        ? Border.all(width: 2, color: Colors.white)
                        : null,
                    color: getItemFromList(i, Colors.primaries),
                  ),
                ),
              ),
            ));
      }))
    ];
  }

  PostPointsOutSidePaint(PathScreenProvider p) {
    return [
      ...(selectedPoints.keys.map((int k) {
        return Positioned(
            left: points[k].prePoint.dx -
                pointSize * 0.5 +
                drawingBoardLeftOffset,
            top:
                points[k].prePoint.dy - pointSize * 0.5 + drawingBoardTopOffset,
            child: GestureDetector(
              onTap: () {
                setState(() {});
              },
              onPanUpdate: (d) {
                points[k].prePoint = Offset(
                  points[k].prePoint.dx + d.delta.dx,
                  points[k].prePoint.dy + d.delta.dy,
                );
                selectedPoint = k;
                if (points[k].pointSymmetry != PointSymmetry.nonSymmetric) {
                  bool isPre = true;
                  updatePrePostPointForSymmetry(isPre, k);
                }

                setState(() {});
              },
              child: Container(
                width: pointSize,
                height: pointSize,
                color: Colors.purple.withAlpha(150),
              ),
            ));
      })),
    ];
  }

  PrePointsOutSidePaint(PathScreenProvider p) {
    return [
      ...(selectedPoints.keys.map((int k) {
        return Positioned(
            left: points[k].postPoint.dx -
                pointSize * 0.5 +
                drawingBoardLeftOffset,
            top: points[k].postPoint.dy -
                pointSize * 0.5 +
                drawingBoardTopOffset,
            child: GestureDetector(
              onTap: () {
                setState(() {});
              },
              onPanUpdate: (d) {
                points[k].postPoint = Offset(
                  points[k].postPoint.dx + d.delta.dx,
                  points[k].postPoint.dy + d.delta.dy,
                );
                selectedPoint = k;
                if (points[k].pointSymmetry != PointSymmetry.nonSymmetric) {
                  bool isPre = false;
                  updatePrePostPointForSymmetry(isPre, k);
                }

                setState(() {});
              },
              child: Container(
                width: pointSize,
                height: pointSize,
                color: Colors.green.withAlpha(150),
              ),
            ));
      })),
    ];
  }
}
