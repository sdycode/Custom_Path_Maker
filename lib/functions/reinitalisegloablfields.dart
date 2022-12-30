import 'package:custom_path_maker/constants/consts.dart';
import 'package:custom_path_maker/constants/gradient_constants.dart';
import 'package:custom_path_maker/providers/gradprovider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void reInitiaiseGlobalFields(BuildContext context) {
  w = MediaQuery.of(context).size.width;
  h = MediaQuery.of(context).size.height;
  leftSideW = w - editOptionW;
  mainScreenH = h - topbarH - bottombarH;
  mainScreenW = w - editOptionW;
  layersListWidgetH = (mainScreenH - 200).abs();
}

void reInitiaiseGlobalFieldsOfGradientSection(BuildContext context) {
  leftSideW = w - editOptionW;
  mainScreenH = h - topbarH - bottombarH;

  colorListBoxW = w * 0.18;
  colorListBoxH = h * 0.6;
  double leftsideW = w - (tileModeW * 4 + 20 * 4 + 30);

  gradeSelectBoxW = h * 0.1;
  demoBoxSizeW = leftsideW * 0.26;
  demoBoxSizeH = leftsideW * 0.26;
  alignOptionsBoxW = w - (tileModeW * 4 + 20 * 4 + 30);
  alignOptionsBoxH = h * 0.1;
  tileModeW = h * 0.1;
  pointRad = 12;
  sliderWidth = w - (tileModeW * 4 + 20 * 4 + 30);
  textBoxSizeW = leftsideW * 0.32;
  textBoxSizeH = h * 0.4;
  imageBoxH = leftsideW * 0.26;
  imageBoxW = leftsideW * 0.28;

  GradProvider gradProvider = Provider.of(context, listen: false);
  // gradProvider.resizeColorSliderPositions();
  // preSliderWidth = w - (tileModeW * 4 + 20 * 4 + 30);
  gradProvider.updateLinearPointForSelectedAlignment(
    gradProvider.originalAlignmentPair,
  );
}
