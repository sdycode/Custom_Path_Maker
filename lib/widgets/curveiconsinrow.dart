import 'package:custom_path_maker/2D%20Gerometry%20Functions/functions%20to%20fill%20CurvePoints%20data/get_enums_to_fill_curvePointsList_from_map_data.dart';
import 'package:custom_path_maker/constants/colors.dart';
import 'package:custom_path_maker/constants/consts.dart';
import 'package:custom_path_maker/constants/global.dart';
import 'package:custom_path_maker/constants/icons_images_paths.dart';
import 'package:custom_path_maker/functions/checkIfIndexPresentInList.dart';
import 'package:custom_path_maker/functions/updatePrePostBothPointsForPoint.dart';
import 'package:custom_path_maker/functions/updatePrePostCurveTypeBasedOnArcTypeOnPoint.dart';
import 'package:custom_path_maker/providers/path_screen_provider.dart';
import 'package:custom_path_maker/screens/path_drawing_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CurveIconsInRowWidget extends StatelessWidget {
  const CurveIconsInRowWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PathScreenProvider p = Provider.of<PathScreenProvider>(
      context,
    );
    double iconW = editOptionW * 0.2;
    return Container(
      width: editOptionW,
      height: iconW,
      child: ListView.builder(
          itemCount: curvePointIcons.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (c, i) {
            return InkWell(
              onTap: () {
                if (checkIfIndexPresentInList(points, selectedPoint)) {
                  points[selectedPoint].arcTypeOnPoint =
                      ArcTypeOnPoint.values[i];
                  updatePrePostCurveTypeBasedOnArcTypeOnPoint(selectedPoint);

                  updatePrePostBothPointsForPoint(selectedPoint);
                  setCubicBezeirToQuadIfNextIsNormal(selectedPoint);
                  p.updateUI();
                }
              },
              child: Container(
                width: iconW,
                height: iconW,
                padding: EdgeInsets.all(8),
                child: Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: (checkIfIndexPresentInList(points, selectedPoint))
                          ? points[selectedPoint].arcTypeOnPoint ==
                                  ArcTypeOnPoint.values[i]
                              ?curveiconBoxActiveColor
                              : curveiconBoxInActiveColor
                          : curveiconBoxInActiveColor,
                      borderRadius: BorderRadius.circular(4),
                      // color: Colors.green,
                      border: (checkIfIndexPresentInList(points, selectedPoint))
                          ? points[selectedPoint].arcTypeOnPoint ==
                                  ArcTypeOnPoint.values[i]
                              ? null
                              : null
                          : null,
                      boxShadow:
                          (checkIfIndexPresentInList(points, selectedPoint))
                              ?  points[selectedPoint].arcTypeOnPoint ==
                                  ArcTypeOnPoint.values[i]
                              ?const [BoxShadow(
                                offset: Offset(0.2,0.2)
                              )] :null
                              : null),
                  child: Image.asset(
                    curvePointIcons[i],
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            );
          }),
    );
  }
}
