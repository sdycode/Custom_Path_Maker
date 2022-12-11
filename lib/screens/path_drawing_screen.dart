import 'package:custom_path_maker/2D%20Gerometry%20Functions/functions%20to%20fill%20CurvePoints%20data/get_enums_to_fill_curvePointsList_from_map_data.dart';
import 'package:custom_path_maker/constants/consts.dart';
import 'package:custom_path_maker/constants/get_index_for_list.dart';
import 'package:custom_path_maker/constants/global.dart';
import 'package:custom_path_maker/constants/icons_images_paths.dart';
import 'package:custom_path_maker/functions/checkIfIndexPresentInList.dart';
import 'package:custom_path_maker/functions/code/getAllStringData.dart';
import 'package:custom_path_maker/functions/code/getImportLinessString.dart';
import 'package:custom_path_maker/functions/code/getModelAndEnumsStringData.dart';
import 'package:custom_path_maker/functions/code/getPaintContainerWidgetAsString.dart';

import 'package:custom_path_maker/functions/code/getStringOfAllFunctionsOfCurvepointsList.dart';
import 'package:custom_path_maker/functions/code/getStringOfCommonCanvasFunction.dart';
import 'package:custom_path_maker/functions/code/getStringofAllCanvasFunctions.dart';

import 'package:custom_path_maker/functions/updatePrePostBothPointsForPoint.dart';
import 'package:custom_path_maker/functions/updatePrePostCurveTypeBasedOnArcTypeOnPoint.dart';
import 'package:custom_path_maker/functions/updatePrePostPointForSymmetry.dart';
import 'package:custom_path_maker/models/PathModel.dart';
import 'package:custom_path_maker/models/curve_point.dart';
import 'package:custom_path_maker/providers/path_screen_provider.dart';
import 'package:custom_path_maker/widgets/bottomBar.dart';
import 'package:custom_path_maker/widgets/editOptions_widget.dart';
import 'package:custom_path_maker/widgets/painter_widget.dart';
import 'package:custom_path_maker/widgets/topbar.dart';
import 'package:custom_path_maker/widgets/widget%20functions/showCodeInDialog.dart';
import 'package:flutter/material.dart';

import 'dart:developer';
import 'dart:io';


import 'dart:ui' as ui;

// ignore_for_file: unnecessary_brace_in_string_interps


import 'dart:ui';

import 'package:flutter/material.dart' hide Gradient;
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';





class PathDrawingScreen extends StatefulWidget {
  PathDrawingScreen({Key? key}) : super(key: key);

  @override
  State<PathDrawingScreen> createState() => _PathDrawingScreenState();
}

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
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            children: [
              TopBar(),
              Container(
                width: w,
                height: mainScreenH,
                child: Stack(fit: StackFit.expand, children: [
                  // Positioned(right: 0, bottom: 0, child: ColorsRow(w * 0.4, 30)),

                  const EditOptions_widget(),
                  Positioned(
                      right: 0,
                      bottom: 0,
                      child: Container(
                        width: w * 0.5,
                        height: 40,
                        child: Row(
                          children: [
                            ...List.generate(pathModels.length, (i) {
                              return TextButton(
                                  onPressed: () {
                                    points = pathModels[i].points;
                                    pathModelIndex = i;
                                    selectedPoint = -1;
                                    selectedPoints.clear();
                                    setState(() {});
                                  },
                                  child: Text(
                                    i.toString(),
                                    style: TextStyle(
                                        fontSize:
                                            pathModelIndex == i ? 25 : 18),
                                  ));
                            }),
                            IconButton(
                                onPressed: () {
                                  pathModels.add(
                                    PathModel.withCurvePoints([],
                                        paint: Paint()
                                          ..color = Colors.primaries[
                                              (pathModels.length) %
                                                  Colors.primaries.length]
                                          ..strokeWidth = 3,
                                        pathName: "path${pathModels.length}"),
                                  );
                                  points = pathModels.last.points;
                                  selectedPoint = -1;
                                  selectedPoints.clear();
                                  setState(() {});
                                },
                                icon: const Icon(
                                  Icons.add,
                                  color: Colors.white,
                                ))
                          ],
                        ),
                      )),
                
                  Positioned(
                      left: 50,
                      top: 100,
                      child: Container(
                        width: h * 0.8,
                        height: h * 0.8,
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 0, 0, 0),
                            border: Border.all(
                              color: Colors.white,
                            )),
                        child: CustomPaint(
                          painter: PointPainter(),
                          child: Stack(children: [
                            GestureDetector(
                              onTapUp: (d) {
                                points.add(CurvePoint.withIndexAndOffset(
                                    index: points.length,
                                    point: d.localPosition));
                                selectedPoint = points.length - 1;
                                _setCurvePointJustAfterAdded(selectedPoint);
                                setState(() {});
                              },
                              child: Container(
                                width: double.infinity,
                                height: double.infinity,
                                color: Colors.transparent,
                              ),
                            ),
                            ...List.generate(points.length, (i) {
                              return Positioned(
                                  left: points[i].point.dx - pointSize * 0.5,
                                  top: points[i].point.dy - pointSize * 0.5,
                                  child: GestureDetector(
                                    onTap: () {
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
                                              ? Border.all(
                                                  width: 2, color: Colors.white)
                                              : null,
                                          color: getItemFromList(
                                              i, Colors.primaries),
                                        ),
                                      ),
                                    ),
                                  ));
                            }),
                            ...(selectedPoints.keys.map((int k) {
                              return Positioned(
                                  left: points[k].prePoint.dx - pointSize * 0.5,
                                  top: points[k].prePoint.dy - pointSize * 0.5,
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
                                      if (points[k].pointSymmetry !=
                                          PointSymmetry.nonSymmetric) {
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
                            ...(selectedPoints.keys.map((int k) {
                              return Positioned(
                                  left:
                                      points[k].postPoint.dx - pointSize * 0.5,
                                  top: points[k].postPoint.dy - pointSize * 0.5,
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
                                      if (points[k].pointSymmetry !=
                                          PointSymmetry.nonSymmetric) {
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
                          ]),
                        ),
                      )),
                  if (_isSelectedPoint())
                    Positioned(
                        top: 100,
                        right: 0,
                        child:
                            // FlutterLogo(
                            //   size: 100,
                            // )
                            _PointCurvetypeWidget())
                  // CustomPaint(
                  //   size: Size(400, 400),
                  //   painter: _Painter(),
                  // )
                ]),
              ),
              BottomBar()
            ],
          )),
    );
  }

  bool _isSelectedPoint() {
    if (selectedPoint >= 0 && selectedPoint < points.length) {
      return true;
    }
    return false;
  }

  void _setCurvePointJustAfterAdded(int i) {
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
    } else {
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
}

setCubicBezeirToQuadIfNextIsNormal(int i) {
  int next = (i + 1) % points.length;
  if (points[i].arcTypeOnPoint == ArcTypeOnPoint.normal) {
    if (points[next].prePointCurveType == PrePointCurveType.cubicBezier) {
      points[i].postPointCurveType = PostPointCurveType.normal;
      points[next].prePointCurveType == PrePointCurveType.quadBezier;
    }
  }
}

// int _typeIndex
class _PointCurvetypeWidget extends StatelessWidget {
  _PointCurvetypeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PathScreenProvider p = Provider.of<PathScreenProvider>(context);
    // log("in _PointCurvetypeWidget $selectedPoint ");
    return !(selectedPoint >= 0 && selectedPoint < points.length)
        ? Container()
        : Container(
            width: w * 0.4,
            height: h * 0.6,
            color: Colors.amber.shade100,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                    width: w * 0.4,
                    height: w * 0.1,
                    child: ListView.builder(
                        itemCount: curvePointIcons.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (c, i) {
                          return InkWell(
                            onTap: () {
                              if (checkIfIndexPresentInList(
                                  points, selectedPoint)) {
                                points[selectedPoint].arcTypeOnPoint =
                                    ArcTypeOnPoint.values[i];
                                updatePrePostCurveTypeBasedOnArcTypeOnPoint(
                                    selectedPoint);

                                updatePrePostBothPointsForPoint(selectedPoint);
                                setCubicBezeirToQuadIfNextIsNormal(
                                    selectedPoint);
                                p.updateUI();
                              }
                            },
                            child: Container(
                              width: w * 0.06,
                              height: w * 0.06,
                              decoration: BoxDecoration(
                                  border: (checkIfIndexPresentInList(
                                          points, selectedPoint))
                                      ? points[selectedPoint].arcTypeOnPoint ==
                                              ArcTypeOnPoint.values[i]
                                          ? Border.all()
                                          : null
                                      : null),
                              child: Image.asset(
                                curvePointIcons[i],
                                fit: BoxFit.contain,
                              ),
                            ),
                          );
                        })),
                Container(
                  width: w * 0.4,
                  height: h * 0.12,
                  child: ListView.builder(
                      itemCount: PrePointCurveType.values.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (c, i) {
                        return Transform.scale(
                            scale: points[selectedPoint].prePointCurveType ==
                                    PrePointCurveType.values[i]
                                ? 1.3
                                : 1.0,
                            child: InkWell(
                              onTap: () {
                                if (i == 1) {
                                  points[selectedPoint].postPointCurveType =
                                      PostPointCurveType.values[i];
                                  points[selectedPoint].prePointCurveType =
                                      PrePointCurveType.values[i];
                                  // post of previous point
                                  int preNo = selectedPoint > 0
                                      ? selectedPoint - 1
                                      : points.length - 1;
                                  points[preNo].postPointCurveType =
                                      PostPointCurveType.values[i];
                                  // pre of next point

                                  points[(selectedPoint + 1) % points.length]
                                          .prePointCurveType =
                                      PrePointCurveType.values[i];
                                } else {
                                  points[selectedPoint].prePointCurveType =
                                      PrePointCurveType.values[i];
                                }
                                p.updateUI();
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Chip(
                                  label: Text(
                                    PrePointCurveType.values[i].name,
                                  ),
                                ),
                              ),
                            ));
                      }),
                ),
                Container(
                  width: w * 0.4,
                  height: h * 0.12,
                  child: ListView.builder(
                      itemCount: PostPointCurveType.values.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (c, i) {
                        return Transform.scale(
                            scale: points[selectedPoint].postPointCurveType ==
                                    PostPointCurveType.values[i]
                                ? 1.3
                                : 1.0,
                            child: InkWell(
                              onTap: () {
                                if (i == 1) {
                                  points[selectedPoint].postPointCurveType =
                                      PostPointCurveType.values[i];
                                  points[selectedPoint].prePointCurveType =
                                      PrePointCurveType.values[i];
                                  // post of previous point
                                  int preNo = selectedPoint > 0
                                      ? selectedPoint - 1
                                      : points.length - 1;
                                  points[preNo].postPointCurveType =
                                      PostPointCurveType.values[i];
                                  // pre of next point

                                  points[(selectedPoint + 1) % points.length]
                                          .prePointCurveType =
                                      PrePointCurveType.values[i];
                                } else {
                                  points[selectedPoint].postPointCurveType =
                                      PostPointCurveType.values[i];
                                }

                                p.updateUI();
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8),
                                child: Chip(
                                  label: Text(
                                    PostPointCurveType.values[i].name,
                                  ),
                                ),
                              ),
                            ));
                      }),
                ),
                Row(
                  children: [
                    if (checkIfIndexPresentInList(points, selectedPoint))
                      Container(
                        height: 60,
                        width: w * 0.3,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: PointSymmetry.values.length,
                            itemBuilder: (c, i) {
                              return ElevatedButton.icon(
                                  onPressed: () {
                                    points[selectedPoint].pointSymmetry =
                                        PointSymmetry.values[i];

                                    p.updateUI();
                                  },
                                  icon: Icon(
                                      points[selectedPoint].pointSymmetry ==
                                              PointSymmetry.values[i]
                                          ? Icons.check_box
                                          : Icons.check_box_outline_blank),
                                  label: Text(PointSymmetry.values[i].name));
                            }),
                      ),
                  ],
                ),
                Row(
                  children: [
                    ElevatedButton.icon(
                        onPressed: () {
                          open = !open;

                          p.updateUI();
                        },
                        icon: Icon(open
                            ? Icons.check_box
                            : Icons.check_box_outline_blank),
                        label: Text(open ? "Open" : "Close")),
                    ElevatedButton.icon(
                        onPressed: () {
                          strokePath = !strokePath;

                          p.updateUI();
                        },
                        icon: Icon(strokePath
                            ? Icons.check_box
                            : Icons.check_box_outline_blank),
                        label: Text(strokePath ? "Stroke" : "Fill")),
                    ElevatedButton.icon(
                        onPressed: () async {
                         
                          await showCodeInDialog(context);
                          p.updateUI();
                        },
                        icon: Icon(strokePath
                            ? Icons.check_box
                            : Icons.check_box_outline_blank),
                        label: const Text("Get Map Data")),
                    ElevatedButton.icon(
                        onPressed: () async {
                          String painterClassName = "MyFirstPainter";
                          // launch('file://C:');
                          Directory? dir = await getDownloadsDirectory();
                          log("dirpath ${dir?.path}");
                          File file = File(
                              "${dir?.path}/${painterClassName}_file.dart");
                          String totalDataIn1File = getImportLinessString() +
                              getPaintContainerWidgetAsString(
                                  painterClassName) +
                              getAllStringData(painterClassName) +
                              getModelAndEnumsStringData() +
                              getStringofAllCanvasFunctions(pathModels) +
                              getStringOfAllFunctionsOfCurvepointsList(
                                  pathModels) +
                              getStringOfCommonCanvasFunction();
                          file.writeAsString(totalDataIn1File);

                          p.updateUI();
                        },
                        icon: Icon(strokePath
                            ? Icons.check_box
                            : Icons.check_box_outline_blank),
                        label: const Text("Pick Folder")),
                  ],
                )
              ],
            ));
  }
}
