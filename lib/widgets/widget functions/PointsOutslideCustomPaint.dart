// ignore_for_file: non_constant_identifier_names, no_leading_underscores_for_local_identifiers

import 'dart:async';
import 'dart:developer';
import 'dart:html';

import 'package:custom_path_maker/2D%20Gerometry%20Functions/functions%20to%20fill%20CurvePoints%20data/get_enums_to_fill_curvePointsList_from_map_data.dart';
import 'package:custom_path_maker/constants/consts.dart';
import 'package:custom_path_maker/constants/get_index_for_list.dart';
import 'package:custom_path_maker/constants/global.dart';
import 'package:custom_path_maker/functions/updatePrePostBothPointsForPoint.dart';
import 'package:custom_path_maker/providers/edit_option_provider.dart';
import 'package:custom_path_maker/providers/path_screen_provider.dart';
import 'package:custom_path_maker/screens/path_drawing_screen.dart';
import 'package:custom_path_maker/widgets/bottomBar.dart';
import 'package:custom_path_maker/widgets/curveiconsinrow.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void _showOverlay(BuildContext context,
    {required String text, required Offset pos}) async {
  OverlayState? overlayState = Overlay.of(context);
  // log("entries ${overlayState.}")
  OverlayEntry overlayEntry;
  bool remove = false;
  overlayEntry = OverlayEntry(builder: (context) {
    double iconW = editOptionW * 0.2;
    return Positioned(
        left: pos.dx + 20,
        top: pos.dy - iconW - 10,
        child: Material(
            child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CurveIconsInRowWidget(),
            IconButton(
                onPressed: () {
                  remove = true;
                  //  overlayEntry.remove();
                  // overlayState!.rearrange([]);
                },
                icon: const Icon(Icons.close))
          ],
        ))
        // ClipRRect(
        //     borderRadius: BorderRadius.circular(10),
        //     child: Material(
        //         child: Container(
        //             alignment: Alignment.center,
        //             color: Colors.grey.shade200,
        //             padding: EdgeInsets.all(
        //                 MediaQuery.of(context).size.height * 0.02),
        //             width: MediaQuery.of(context).size.width * 0.8,
        //             height: MediaQuery.of(context).size.height * 0.06,
        //             child: Text(
        //               text,
        //             ))))

        );
  });
  overlayState!.insert(overlayEntry);
  // Future.delayed(const Duration(seconds: 6)).then((value) {
  //   overlayEntry.remove();
  // });
  Timer.periodic(Duration(milliseconds: 100), (timer) {
    if (remove) {
      if (overlayEntry.mounted) {
        overlayEntry.remove();
      }
      timer.cancel();
    }
    // log("timer ${timer.tick}");
  });
}

PointsOutslideCustomPaint(BuildContext context) {
  PathScreenProvider p = Provider.of<PathScreenProvider>(
    context,
  );
  EditOptionProvider editProvider = Provider.of<EditOptionProvider>(
    context,
  );
  document.onContextMenu.listen((event) => event.preventDefault());

  return [
    ...(List.generate(points.length, (i) {
      Offset shiftetPosition = Offset(
          points[i].point.dx -
              pointSize * 0.5 +
              drawingBoardLeftOffset +
              pathModels[pathModelIndex].offsetFromOrigin.dx,
          points[i].point.dy -
              pointSize * 0.5 +
              drawingBoardTopOffset +
              pathModels[pathModelIndex].offsetFromOrigin.dy);
      final GlobalKey<PopupMenuButtonState> _menuKey =
          GlobalKey<PopupMenuButtonState>();
      return Positioned(
          left: shiftetPosition.dx,
          top: shiftetPosition.dy,
          child:
              // PopupMenuButton(
              //     color: Colors.black,
              //     key: _menuKey,
              //     tooltip: "CurveTypes",
              //     itemBuilder: (_) => <PopupMenuItem<String>>[
              //           const PopupMenuItem<String>(
              //             child: CurveIconsInRowWidget(),
              //           )
              //         ],
              //     child:

              GestureDetector(
            onSecondaryTapDown: (d) {
              log("ontapp tapped _menuKey  called on point $i");
              // _menuKey.currentState!.showButtonMenu();
              selectedPoint = i; p.updateUI();
              editProvider.updateUI();
              _showOverlay(context, text: "not ver", pos: d.globalPosition);
            },
            onTap: () {
              log("ontapp tapped called on point $i");
              selectedPoint = i;
              // if (selectedPoints.containsKey(i)) {
              //   selectedPoints.remove(i);
              // } else {
              //   selectedPoints.putIfAbsent(i, () => i);
              // }
              p.updateUI();
              editProvider.updateUI();
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
              editProvider.updateUI();
            },
            child: Transform.scale(
              scale: 1 / zoomValue,
              child: Transform.scale(
                scale: selectedPoint == i ? 1.3 : 1.0,
                child: Container(
                  width: pointSize,
                  height: pointSize,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(pointSize * 0.3),
                    border: selectedPoint == i
                        ? Border.all(width: 2, color: Colors.white)
                        : null,
                    color: getItemFromList(i, Colors.primaries),
                  ),
                ),
              ),
            ),
          )
          // ),
          );
    }))
  ];
}
