// ignore_for_file: unrelated_type_equality_checks, non_constant_identifier_names, prefer_const_constructors

import 'dart:typed_data';
import 'dart:io';

import 'package:custom_path_maker/2D%20Gerometry%20Functions/math/getRectBoundaryPointsFromGivenPoints.dart';
import 'package:custom_path_maker/constants/consts.dart';
import 'package:custom_path_maker/constants/global.dart';
import 'package:custom_path_maker/constants/gradient_constants.dart';
import 'package:custom_path_maker/enum/enums.dart';
import 'package:custom_path_maker/functions/setCurvePointJustAfterAdded.dart';
import 'package:custom_path_maker/models/curve_point.dart';
import 'package:custom_path_maker/providers/path_screen_provider.dart';
import 'package:custom_path_maker/screens/drawingBoard.dart';
import 'package:custom_path_maker/widgets/Gradient/colorStopsSlider.dart';
import 'package:custom_path_maker/widgets/Gradient/gradRadiusSlider.dart';
import 'package:custom_path_maker/widgets/Gradient/gradSweepRadiusSlider.dart';
import 'package:custom_path_maker/widgets/Gradient/gradControlPoints.dart';
import 'package:custom_path_maker/widgets/bottomBar.dart';
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
    super.initState();
  }

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
                    clipBehavior: Clip.hardEdge,
                    fit: StackFit.expand,
                    children: [
                      // Positioned(right: 0, bottom: 0, child: ColorsRow(w * 0.4, 30)),

                      // width: h * 0.6,
                      //                           height: h * 0.6,
                      Positioned(
                          left: drawingBoardLeftOffset,
                          top: drawingBoardTopOffset,
                          child:
                          DrawingBoardWidget(),),
                      
                      ...PointsOutslideCustomPaint(context),
                      ...PrePointsOutSidePaint(context),
                      ...PostPointsOutSidePaint(context),
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
                            LayersListWidget(),
                      const EditOptions_widget(),
                    ]),
              ),
              const BottomBar()
            ],
          )),
    );
  }
}

Uint8List? imageData;
void loadBackgroundImage() async {
  imageData = (await rootBundle.load('assets/sampleImage/duck.jpg'))
      .buffer
      .asUint8List();
}

Future pickAndLoadImageFromDevice() async {
  imgP.ImagePickerPlugin imagePickerPlugin = imgP.ImagePickerPlugin();
  PickedFile pickedFile =
      await imagePickerPlugin.pickImage(source: ImageSource.gallery);
  imageData = await pickedFile.readAsBytes();
}
