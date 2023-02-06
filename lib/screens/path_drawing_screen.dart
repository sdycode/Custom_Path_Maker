// ignore_for_file: unrelated_type_equality_checks, non_constant_identifier_names, prefer_const_constructors

import 'dart:developer';
import 'dart:typed_data';
import 'dart:io';

import 'package:custom_path_maker/2D%20Gerometry%20Functions/math/getRectBoundaryPointsFromGivenPoints.dart';
import 'package:custom_path_maker/Painter/pathClipperWidget.dart';
import 'package:custom_path_maker/constants/consts.dart';
import 'package:custom_path_maker/constants/global.dart';
import 'package:custom_path_maker/constants/gradient_constants.dart';
import 'package:custom_path_maker/enum/enums.dart';
import 'package:custom_path_maker/functions/resetColorStopPositiontoLast.dart';
import 'package:custom_path_maker/functions/setCurvePointJustAfterAdded.dart';
import 'package:custom_path_maker/models/curve_point.dart';
import 'package:custom_path_maker/providers/path_screen_provider.dart';
import 'package:custom_path_maker/screens/drawingBoard.dart';
import 'package:custom_path_maker/widgets/Gradient/colorStopsSlider.dart';
import 'package:custom_path_maker/widgets/Gradient/gradRadiusSlider.dart';
import 'package:custom_path_maker/widgets/Gradient/gradSweepRadiusSlider.dart';
import 'package:custom_path_maker/widgets/Gradient/gradControlPoints.dart';
import 'package:custom_path_maker/widgets/bottomBar.dart';
import 'package:custom_path_maker/widgets/curveiconsinrow.dart';
import 'package:custom_path_maker/widgets/editOptions_widget.dart';
import 'package:custom_path_maker/Painter/painter_widget.dart';
import 'package:custom_path_maker/widgets/pathsListWidget.dart';
import 'package:custom_path_maker/widgets/topbar.dart';
import 'package:custom_path_maker/widgets/widget%20functions/PointsOutslideCustomPaint.dart';
import 'package:custom_path_maker/widgets/widget%20functions/PostPointsOutSidePaint.dart';
import 'package:custom_path_maker/widgets/widget%20functions/PrePointsOutSidePaint.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' hide Gradient;
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_picker_for_web/image_picker_for_web.dart' as imgP;
import 'package:provider/provider.dart';

double drawingBoardLeftOffset = 100;
double drawingBoardTopOffset = 100;
BackgroundImageStatus backgroundImageStatus = BackgroundImageStatus.none;
int bgImageFitIndex = 0;
double bgImageOpacity = 0.5;
bool showLayersList = true;
bool hideControlPoints = false;
bool moveShapeWidget = false;

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
  void initState() {
    // TODO: implement initState
    loadBackgroundImage();
    if (pathModels.isNotEmpty) {
      resetColorStopPositiontoLastForGivenPathModel(pathModels.first);
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    paintBoxSize = Size(h * 0.8, h * 0.8);

    const fontarm = "Arapey-Regular";

    PathScreenProvider p = Provider.of<PathScreenProvider>(context);

    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            children: [
              TopBar(),
              // curvePointOptions(context),

              Container(
                width: w,
                height: mainScreenH,
                child: Stack(
                    clipBehavior: Clip.hardEdge,
                    fit: StackFit.expand,
                    children: [
                      // Positioned(right: 0, bottom: 0, child: ColorsRow(w * 0.4, 30)),

                      // width: h * 0.6,
                      //                           height: h * 0.6,

                      Transform.scale(
                        origin: Offset(0, mainScreenH * 0.5),
                        scale: zoomValue,
                        child: Transform.translate(
                          offset: zoomPanOffset,
                          child: Stack(
                            children: [
                              Positioned(
                                left: drawingBoardLeftOffset,
                                top: drawingBoardTopOffset,
                                child: DrawingBoardWidget(),
                              ),
                              if (!hideControlPoints)
                                ...PointsOutslideCustomPaint(context),
                              if (!hideControlPoints)
                                ...PrePointsOutSidePaint(context),
                              if (!hideControlPoints)
                                ...PostPointsOutSidePaint(context),
                              if (moveShapeWidget)
                                Positioned(
                                  left: pathModels[pathModelIndex]
                                          .offsetFromOrigin
                                          .dx +
                                      drawingBoardLeftOffset,
                                  top: pathModels[pathModelIndex]
                                          .offsetFromOrigin
                                          .dy +
                                      drawingBoardTopOffset,
                                  child: ClipPath(
                                    clipBehavior: Clip.antiAlias,
                                    clipper: ClipperPathWidget(pathModelIndex),
                                    child: MouseRegion(
                                      cursor: SystemMouseCursors.move,
                                      child: GestureDetector(
                                        onPanUpdate: (d) {
                                          translatePoints(
                                              pathModelIndex, d.delta);
                                          p.updateUI();
                                        },
                                        child: Container(
                                            height: mainScreenH,
                                            width: mainScreenW,
                                            decoration: BoxDecoration(
                                                border: null,
                                                //  Border.all(width: 2),
                                                color: Colors.grey.shade100
                                                    .withAlpha(0))),
                                      ),
                                    ),
                                  ),
                                ),
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
                                      GradientType.linear.name.toString())
                                LinearGradControlPoints(),
                              if (!isGradient &&
                                  pathModels[pathModelIndex]
                                          .gradientType
                                          .name
                                          .toString() ==
                                      GradientType.sweep.name.toString())
                                SweepGradControlPoint(),
                            ],
                          ),
                        ),
                      ),

                      if (showLayersList) LayersListWidget(),
                      const EditOptions_widget(),
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
                      if (!isGradient &&
                          pathModels[pathModelIndex]
                                  .gradientType
                                  .name
                                  .toString() ==
                              GradientType.linear.name.toString())
                        Positioned(
                            bottom: 0,
                            child: ColorStopSlider(
                              th: gradColorSliderHeight,
                              tw: w - editOptionW,
                            )),
                    ]),
              ),
              const BottomBar()
            ],
          )),
    );
  }
}

Uint8List? assetImageData;
Uint8List? pickedImageData;
void loadBackgroundImage() async {
  assetImageData = (await rootBundle.load('assets/sampleImage/duck.jpg'))
      .buffer
      .asUint8List();
  pickedImageData = Uint8List.fromList(assetImageData!);
}

Future pickAndLoadImageFromDevice() async {
  imgP.ImagePickerPlugin imagePickerPlugin = imgP.ImagePickerPlugin();
  PickedFile pickedFile =
      await imagePickerPlugin.pickImage(source: ImageSource.gallery);
  pickedImageData = await pickedFile.readAsBytes();
}
