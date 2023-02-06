// ignore_for_file: camel_case_types

import 'dart:developer';

import 'package:custom_path_maker/2D%20Gerometry%20Functions/functions%20to%20fill%20CurvePoints%20data/get_enums_to_fill_curvePointsList_from_map_data.dart';
import 'package:custom_path_maker/constants/consts.dart';
import 'package:custom_path_maker/constants/global.dart';
import 'package:custom_path_maker/enum/enums.dart';
import 'package:custom_path_maker/functions/checkIfIndexPresentInList.dart';
import 'package:custom_path_maker/providers/edit_option_provider.dart';
import 'package:custom_path_maker/widgets/Buttons/hideControlPointsButton.dart';
import 'package:custom_path_maker/widgets/Buttons/showLayersButton.dart';
import 'package:custom_path_maker/widgets/ColorAndGradientButton.dart';
import 'package:custom_path_maker/widgets/DrawingBoardTileWidget.dart';
import 'package:custom_path_maker/widgets/FillAndOpenButtons.dart';
import 'package:custom_path_maker/widgets/Gradient/gradientColorsListWidget.dart';
import 'package:custom_path_maker/widgets/Gradient/gradient_details_widget.dart';
import 'package:custom_path_maker/widgets/curveiconsinrow.dart';
import 'package:custom_path_maker/widgets/fill_stroke_buttons.dart';
import 'package:custom_path_maker/widgets/openCloseButtons.dart';
import 'package:custom_path_maker/widgets/radius_slider.dart';
import 'package:custom_path_maker/widgets/strokeWidthSlider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditOptions_widget extends StatelessWidget {
  const EditOptions_widget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {  ScrollController controller = ScrollController();

    EditOptionProvider editProvider = Provider.of<EditOptionProvider>(context);
    return Positioned(
      right: 0,
      top: 0,
      child: Container(
        width: editOptionW,
        color: Color.fromARGB(255, 33, 33, 33),
        height:editOptionH,
        child: Scrollbar(controller: controller,
        trackVisibility: true,
          child: SingleChildScrollView(controller: controller,
            child: Column(
              children: [
                // const
                CurveIconsInRowWidget(),
                if (checkRadiusSliderCanbeshowdForSelectedPoint(selectedPoint))
                  const RadiusSlider(),
                   const HideControlPointsWidgetButton(),
                // const FillAndOpenButtons(),
                const OpenCloseButtonsWithSlider(),
                const FillStrokeButtonsWithSlider(),
                if(  pathModels[pathModelIndex].stroke)
                StrokeWidthSlider(),
                const ColorAndGradientButton(),
                if (pathModels[pathModelIndex].gradientType !=
                    GradientType.color)
                  const GradientDetailsWidget(),

                const DrawingBoardTileWidget(),
                // const ShowLayersWidgetButton()
              ],
            ),
          ),
        ),
      ),
    );
  }
}

checkRadiusSliderCanbeshowdForSelectedPoint(int selectedPoint) {
  if (checkIfIndexPresentInList(points, selectedPoint)) {
    if (points[selectedPoint].arcTypeOnPoint == ArcTypeOnPoint.arc) {
      return true;
    }
  }
  return false;
}
