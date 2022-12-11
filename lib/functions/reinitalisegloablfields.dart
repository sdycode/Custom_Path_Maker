import 'package:custom_path_maker/constants/consts.dart';
import 'package:flutter/material.dart';

void reInitiaiseGlobalFields(BuildContext context) {
  w = MediaQuery.of(context).size.width;
  h = MediaQuery.of(context).size.height;
  leftSideW = w - editOptionW;
 mainScreenH = h - topbarH - bottombarH;
}
