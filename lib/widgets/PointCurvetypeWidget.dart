

// int _typeIndex
import 'package:custom_path_maker/constants/icons_images_paths.dart';
import 'package:custom_path_maker/functions/checkIfIndexPresentInList.dart';
import 'package:custom_path_maker/functions/code/getPaintContainerWidgetAsString.dart';
import 'package:custom_path_maker/functions/code/getStringOfCommonCanvasFunction.dart';
import 'package:custom_path_maker/2D%20Gerometry%20Functions/functions%20to%20fill%20CurvePoints%20data/get_enums_to_fill_curvePointsList_from_map_data.dart';
import 'package:custom_path_maker/constants/consts.dart';
import 'package:custom_path_maker/constants/get_index_for_list.dart';
import 'package:custom_path_maker/constants/global.dart';


import 'package:custom_path_maker/functions/updatePrePostBothPointsForPoint.dart';
import 'package:custom_path_maker/functions/updatePrePostCurveTypeBasedOnArcTypeOnPoint.dart';
import 'package:custom_path_maker/functions/updatePrePostPointForSymmetry.dart';
import 'package:custom_path_maker/models/PathModel.dart';
import 'package:custom_path_maker/models/curve_point.dart';
import 'package:custom_path_maker/providers/path_screen_provider.dart';
import 'package:custom_path_maker/widgets/bottomBar.dart';
import 'package:custom_path_maker/widgets/editOptions_widget.dart';
import 'package:custom_path_maker/Painter/painter_widget.dart';
import 'package:custom_path_maker/widgets/topbar.dart';
import 'package:custom_path_maker/widgets/widget%20functions/showCodeInDialog.dart';
import 'package:flutter/material.dart';

import 'dart:developer';
import 'dart:io';
import 'package:custom_path_maker/constants/icons_images_paths.dart';
import 'package:custom_path_maker/functions/checkIfIndexPresentInList.dart';
import 'package:custom_path_maker/functions/code/getAllStringData.dart';
import 'package:custom_path_maker/functions/code/getImportLinessString.dart';
import 'package:custom_path_maker/functions/code/getModelAndEnumsStringData.dart';
import 'package:custom_path_maker/functions/code/getPaintContainerWidgetAsString.dart';

import 'package:custom_path_maker/functions/code/getStringOfAllFunctionsOfCurvepointsList.dart';
import 'package:custom_path_maker/functions/code/getStringOfCommonCanvasFunction.dart';
import 'package:custom_path_maker/functions/code/getStringofAllCanvasFunctions.dart';
import 'package:custom_path_maker/functions/setCubicBezeirToQuadIfNextIsNormal.dart';

import 'dart:ui' as ui;

// ignore_for_file: unnecessary_brace_in_string_interps


import 'dart:ui';

import 'package:flutter/material.dart' hide Gradient;
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
class PointCurvetypeWidget extends StatelessWidget {
  PointCurvetypeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PathScreenProvider p = Provider.of<PathScreenProvider>(context);
    // log("in PointCurvetypeWidget $selectedPoint ");
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
                          pathModels[pathModelIndex].open = !pathModels[pathModelIndex].open;

                          p.updateUI();
                        },
                        icon: Icon(pathModels[pathModelIndex].open
                            ? Icons.check_box
                            : Icons.check_box_outline_blank),
                        label: Text(pathModels[pathModelIndex].open ? "Open" : "Close")),
                    ElevatedButton.icon(
                        onPressed: () {
                          pathModels[pathModelIndex].stroke = !pathModels[pathModelIndex].stroke;

                          p.updateUI();
                        },
                        icon: Icon(pathModels[pathModelIndex].stroke
                            ? Icons.check_box
                            : Icons.check_box_outline_blank),
                        label: Text(pathModels[pathModelIndex].stroke ? "Stroke" : "Fill")),
                    ElevatedButton.icon(
                        onPressed: () async {
                         
                          await showCodeInDialog(context);
                          p.updateUI();
                        },
                        icon: Icon(pathModels[pathModelIndex].stroke
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
                        icon: Icon(pathModels[pathModelIndex].stroke
                            ? Icons.check_box
                            : Icons.check_box_outline_blank),
                        label: const Text("Pick Folder")),
                  ],
                )
              ],
            ));
  }
}
