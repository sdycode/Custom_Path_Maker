import 'dart:developer';

import 'package:custom_path_maker/2D%20Gerometry%20Functions/math/getRectBoundaryPointsFromGivenPoints.dart';
import 'package:custom_path_maker/Painter/painter_widget.dart';
import 'package:custom_path_maker/constants/global.dart';
import 'package:custom_path_maker/enum/enums.dart';
import 'package:custom_path_maker/functions/setCurvePointJustAfterAdded.dart';
import 'package:custom_path_maker/models/curve_point.dart';
import 'package:custom_path_maker/providers/path_screen_provider.dart';
import 'package:custom_path_maker/screens/path_drawing_screen.dart';
import 'package:custom_path_maker/widgets/pathsListWidget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DrawingBoardWidget extends StatelessWidget {
  const DrawingBoardWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PathScreenProvider p = Provider.of<PathScreenProvider>(context);
    log("pointslen --------------------------- ");
       for (var i = 0; i < pathModels.length; i++) {
      log("points of $i :  ------ \n ${pathModels[i].points.map(
            (e) => e.point,
          ).toList()}");
    }
    log("showhide ${showHidePaths}");
    return Container(
        height: drawingBoardH,
        width: drawingBoardW,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.white),
            image: imageData == null ||
                    backgroundImageStatus == BackgroundImageStatus.none
                ? null
                : DecorationImage(
                    image: MemoryImage(imageData!),
                    fit: BoxFit.values[bgImageFitIndex],
                    opacity: bgImageOpacity
                    //AssetImage("")

                    // imageData!=null?

                    // MemoryImage(imageData!):AssetImage("")

                    )),
        child: Stack(
          fit: StackFit.expand,
          children: [
        if(showCUrrentEditingPath)    Opacity(
              opacity: 1,
              child: CustomPaint(
                painter: PointPainter(
                    pathModelIndex,
                    getBoxForPoints(pathModels[pathModelIndex]
                        .points
                        .map((e) => e.point)
                        .toList()),
                    pathModel: pathModels[pathModelIndex]),
                child: Stack(
                    fit: StackFit.expand,
                    clipBehavior: Clip.none,
                    children: [
                      GestureDetector(
                        onTapUp: (d) {
                          points.add(CurvePoint.withIndexAndOffset(
                              index: points.length, point: d.localPosition));
                          selectedPoint = points.length - 1;
                          setCurvePointJustAfterAdded(selectedPoint);
                          p.updateUI();
                        },
                        child: Container(
                          width: double.infinity,
                          height: double.infinity,
                          color: Colors.transparent,
                        ),
                      ),
                    ]),
              ),
            ),
            ...List.generate(pathModels.length, (i) {
              log("pointslen $i : ${pathModels[i].points.length}");
              return
                  // i == pathModelIndex
                  //     ? IgnorePointer(ignoring: true, child: Container())
                  //     :
false
                  // i == pathModelIndex
                      ?
                      // Container()
                      IgnorePointer(
                          ignoring: true,
                          child: Positioned(
                              left: i * 50,
                              top: i * 50,
                              child: CircleAvatar(
                                radius: 50,
                                backgroundColor: Colors
                                    .primaries[i % Colors.primaries.length]
                                    .withAlpha(50),
                              )),
                        )
                      : Visibility(
                          visible: showHidePaths[i],
                          child: IgnorePointer(
                              ignoring: true,
                              child: Opacity(
                                opacity: 0.8,
                                child: Container(
                                  color: Colors
                                      .primaries[i % Colors.primaries.length]
                                      .withAlpha(0),
                                  child: CustomPaint(
                                    painter: PointPainter(
                                        i,
                                        getBoxForPoints(pathModels[i]
                                            .points
                                            .map((e) => e.point)
                                            .toList()),
                                        pathModel: pathModels[i]),
                                  ),
                                ),
                              )),
                        );
            }),
          ],
        ));
  }
}
