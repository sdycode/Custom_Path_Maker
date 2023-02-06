import 'dart:developer';

import 'package:custom_path_maker/constants/consts.dart';
import 'package:custom_path_maker/constants/global.dart';
import 'package:custom_path_maker/models/PathModel.dart';
import 'package:custom_path_maker/models/colorStopModel.dart';
import 'package:custom_path_maker/providers/gradprovider.dart';
import 'package:custom_path_maker/widgets/widget%20functions/showColorPicker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants/gradient_constants.dart';

class ColorStopSlider extends StatelessWidget {
  final double tw;
  final double th;

  const ColorStopSlider({Key? key, required this.tw, required this.th})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    double barH = th * 0.8;
    PathModel pathModel = pathModels[pathModelIndex];
    GradProvider gradProvider = Provider.of(context, listen: true);
    log("didff / ${tw - actualW} / ${actualW}/ $tw / $editOptionW");
    return Container(
        width: tw,
        height: th,
        margin: const EdgeInsets.all(4),
        color: Colors.amber.shade100.withAlpha(0),
        child: Center(
          child: Container(
            width: actualW,
            height: th,
            child: Stack(clipBehavior: Clip.none, children: [
              Padding(
                padding: EdgeInsets.zero,
                // EdgeInsets.only(top: th * 0.3),
                child: Center(
                  child: GestureDetector(
                    onTapUp: (d) {
                      log("onadd $d / ${pathModel.colorStopModels.length}");
                      double stopValue = d.localPosition.dx / (actualW);
                      pathModel.colorStopModels.add(ColorStopModel(
                          stopValue, "ffffffff", d.localPosition.dx));
                      log("bef remove aftersort after add /ll ${pathModel.colorStopModels.length}");
                      gradProvider.sortColorStopModelsAsPerStopValue(
                          pathModel.colorStopModels.length - 1, actualW);
                      gradProvider.updateUi();
                    },
                    child: Container(
                      width: actualW,
                      height: barH,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.white),
                          color: sliderBarColor,
                          borderRadius: BorderRadius.circular(barH * 0.2)),
                    ),
                  ),
                ),
              ),
              ...List.generate(
                  pathModel.colorStopModels.length,
                  (i) => ColorStopSliderItemWidget(
                        tw: actualW,
                        th: th,
                        colorStopModel: pathModel.colorStopModels[i],
                        i: i,
                      ))
            ]),
          ),
        ));
  }
}

class ColorStopSliderItemWidget extends StatelessWidget {
  final double tw;
  final double th;

  final ColorStopModel colorStopModel;
  final int i;
  const ColorStopSliderItemWidget(
      {Key? key,
      required this.tw,
      required this.th,
      required this.colorStopModel,
      required this.i})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double iconH = th * 0.4;
    double barW = 12;
    double totalItemW = iconH + barW;
    GradProvider gradProvider = Provider.of(context, listen: true);
    PathModel pathModel = pathModels[pathModelIndex];
    // log("colorStopModel.left ${colorStopModel.left}");
    return Positioned(
      left: colorStopModel.left - totalItemW * 0.5,
      child: Container(
        height: th,
        width: totalItemW,
        child: Column(
          children: [
            GestureDetector(
              onHorizontalDragEnd: (d) {
                gradProvider.sortColorStopModelsAsPerStopValue(i, tw);
                gradProvider.updateUi();
              },
              onHorizontalDragUpdate: (d) {
                double updatedLeft = ((d.delta.dx) / tw);
                double stop = colorStopModel.colorStop + (updatedLeft);
                double modfStopValue =
                    (pathModel.colorStopModels[i].left + d.delta.dx) /
                        (tw
                        // sliderWidth * sliderActualWidthFactorWithPadding

                        );

                if (pathModel.colorStopModels[i].left + d.delta.dx >= 0.0 &&
                    pathModel.colorStopModels[i].left + d.delta.dx <=
                        // sliderWidth * sliderActualWidthFactorWithPadding
                        tw) {
                  pathModel.colorStopModels[i] = ColorStopModel(
                      modfStopValue,
                      colorStopModel.hexColorString,
                      pathModel.colorStopModels[i].left + d.delta.dx);

                  gradProvider.updateUi();
                }
              },
              onTap: () {
                showColorPicker(context, (Color d) {
                  pathModel.colorStopModels[i] = ColorStopModel(
                      colorStopModel.colorStop,
                      d.toString().replaceAll(')', '').split('x')[1],
                      colorStopModel.left);
                  gradProvider.updateUi();
                },
                    Color(int.parse(
                        "0x${pathModel.colorStopModels[i].hexColorString}")));
              },
              child: Container(
                height: th,
                decoration: BoxDecoration(
                  border: Border.all(width: 2, color: Colors.white),
                  borderRadius: BorderRadius.circular(totalItemW * 0.2),
                  color: Color(int.parse("0x${colorStopModel.hexColorString}")),
                ),
                width: barW,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
