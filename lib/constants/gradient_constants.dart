import 'package:custom_path_maker/constants/consts.dart';
import 'package:flutter/material.dart';

double colorListBoxW = w * 0.18;
double colorListBoxH = h * 0.4;
double sliderWidth = w * 0.7;
double sliderActualWidthFactor = 0.96;
double sliderActualWidthFactorWithPadding = 0.96;
double gradeSelectBoxW = h * 0.1;
double demoBoxSizeW = h * 0.4;
double demoBoxSizeH = h * 0.4;

double textBoxSizeW = w * 0.16;
double textBoxSizeH = h * 0.4;
double imageBoxW = w * 0.2;
double alignOptionsBoxW = w * 0.7;
double alignOptionsBoxH = h * 0.16;
double tileModeW = h * 0.1;
double pointRad = 12;
double preSliderWidth = w * 0.7;
double imageBoxH = h * 0.4;
double gradColorSliderHeight = 26;
List<AlignmentPair> alignmentPairList = [];

const Color sliderBarColor = Color.fromARGB(255, 30, 16, 85);

class AlignmentPair {
  Alignment start;
  Alignment end;
  AlignmentPair(this.start, this.end);
}
