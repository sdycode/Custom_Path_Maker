import 'dart:developer';

import 'package:custom_path_maker/2D%20Gerometry%20Functions/math/getRectBoundaryPointsFromGivenPoints.dart';
import 'package:custom_path_maker/Painter/painter_widget.dart';
import 'package:custom_path_maker/constants/global.dart';
import 'package:custom_path_maker/enum/enums.dart';
import 'package:custom_path_maker/functions/setCurvePointJustAfterAdded.dart';
import 'package:custom_path_maker/models/curve_point.dart';
import 'package:custom_path_maker/providers/path_screen_provider.dart';
import 'package:custom_path_maker/screens/path_drawing_screen.dart';
import 'package:custom_path_maker/widgets/bottomBar.dart';
import 'package:custom_path_maker/widgets/pathsListWidget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DrawingBoardWidget extends StatelessWidget {
  const DrawingBoardWidget({Key? key}) : super(key: key);
  DecorationImage? getDecorationImageForBackgroundImageStatus(
      BackgroundImageStatus bgStatus) {
    // if (bgStatus == BackgroundImageStatus.asset && assetImageData != null) {
    //   return DecorationImage(
    //       image: MemoryImage(assetImageData!),
    //       fit: BoxFit.values[bgImageFitIndex],
    //       opacity: bgImageOpacity);
    // }
    // if(bgStatus == BackgroundImageStatus.memory && pickedImageData != null){
    //   return DecorationImage(
    //       image: MemoryImage(pickedImageData!),
    //       fit: BoxFit.values[bgImageFitIndex],
    //       opacity: bgImageOpacity);
    // }
    if (pickedImageData != null && backgroundImageStatus != BackgroundImageStatus.none) {
      return DecorationImage(
          image: MemoryImage(pickedImageData!),
          fit: BoxFit.values[bgImageFitIndex],
          opacity: bgImageOpacity);
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    PathScreenProvider p = Provider.of<PathScreenProvider>(context);
    log("pointslen --------------------------- ");
    // for (var i = 0; i < pathModels.length; i++) {
    //   log("points of $i :  ------ \n ${pathModels[i].points.map(
    //         (e) => e.point,
    //       ).toList()}");
    // }
    log("showhide ${showHidePaths}");
    return Container(
        height: drawingBoardH,
        width: drawingBoardW,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.white),
            image: getDecorationImageForBackgroundImageStatus(
                backgroundImageStatus)),
        child: Stack(
          // fit: StackFit.expand,
          children: [
            Container(
              height: drawingBoardH,
              width: drawingBoardW,
            ),
            ...List.generate(pathModels.length, (i) {
              log("pointslen $i : ${pathModels[i].points.length}");
              return i == pathModelIndex
                  ? Container()
                  :
                  // left: pathModels[i].offsetFromOrigin.dx,
                  // top: pathModels[i].offsetFromOrigin.dy,
                  Transform.translate(
                      offset: pathModels[i].offsetFromOrigin,
                      child: Visibility(
                        visible: showHidePaths[i],
                        child: IgnorePointer(
                            ignoring: true,
                            child: Opacity(
                              opacity: 0.6,
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
                      ),
                    );
            }),

            if (showCUrrentEditingPath)
              Transform.translate(
                offset: pathModels[pathModelIndex].offsetFromOrigin,
                //   left: pathModels[pathModelIndex].offsetFromOrigin.dx,
                // top: pathModels[pathModelIndex].offsetFromOrigin.dy,
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
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
                            onPanUpdate: (d) {
                              if (isZoomPanEnabled) {
                                zoomPanOffset = Offset(
                                    zoomPanOffset.dx + d.delta.dx,
                                    zoomPanOffset.dy + d.delta.dy);
                                p.updateUI();
                              }
                            },
                            onTapUp: (d) {
                              points.add(CurvePoint.withIndexAndOffset(
                                  index: points.length,
                                  point: d.localPosition));
                              selectedPoint = points.length - 1;
                              setCurvePointJustAfterAdded(selectedPoint);
                              p.updateUI();
                            },
                            // child: Container(
                            //   width: double.infinity,
                            //   height: double.infinity,
                            //   color: Colors.transparent,
                            // ),
                          ),
                        ]),
                  ),
                ),
              ),
            // Positioned(
            //     // left: pathModels[pathModelIndex].offsetFromOrigin.dx,
            //     // top: pathModels[pathModelIndex].offsetFromOrigin.dy,
            //     child: CircleAvatar(
            //       radius: 50,
            //     ))
          ],
        ));
  }
}

void translatePoints(int pathIndex, Offset delta) {
  // pathModels[pathIndex].points = pathModels[pathIndex].points.map((e) {
  //   e.point = Offset(e.point.dx + delta.dx, e.point.dy + delta.dy);
  //   return e;
  // }).toList();

  pathModels[pathIndex].offsetFromOrigin = Offset(
      pathModels[pathIndex].offsetFromOrigin.dx + delta.dx,
      pathModels[pathIndex].offsetFromOrigin.dy + delta.dy);
}
