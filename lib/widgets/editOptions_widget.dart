// ignore_for_file: camel_case_types

import 'package:custom_path_maker/constants/consts.dart';
import 'package:custom_path_maker/constants/global.dart';
import 'package:custom_path_maker/enum/enums.dart';
import 'package:custom_path_maker/providers/edit_option_provider.dart';
import 'package:custom_path_maker/widgets/ColorAndGradientButton.dart';
import 'package:custom_path_maker/widgets/FillAndOpenButtons.dart';
import 'package:custom_path_maker/widgets/Gradient/gradientColorsListWidget.dart';
import 'package:custom_path_maker/widgets/Gradient/gradient_details_widget.dart';
import 'package:custom_path_maker/widgets/curveiconsinrow.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditOptions_widget extends StatelessWidget {
  const EditOptions_widget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    EditOptionProvider editProvider = Provider.of<EditOptionProvider>(context);
    return Positioned(
      right: 0,
      top: 0,
      child: Container(
        width: editOptionW,
        color: Color.fromARGB(137, 37, 36, 36),
        height: h,
        child: Column(
          children: [
            const CurveIconsInRowWidget(),
            const FillAndOpenButtons(),
            const ColorAndGradientButton(),
            if (pathModels[pathModelIndex].gradientType!= GradientType.color) const GradientDetailsWidget(),
     
          ],
        ),
      ),
    );
  }
}
