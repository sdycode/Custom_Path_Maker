import 'package:custom_path_maker/constants/consts.dart';
import 'package:custom_path_maker/widgets/Gradient/gradientColorsListWidget.dart';
import 'package:custom_path_maker/widgets/Gradient/gradientTilesModesWidget.dart';
import 'package:custom_path_maker/widgets/Gradient/gradient_types_widget.dart';
import 'package:flutter/material.dart';

class GradientDetailsWidget extends StatelessWidget {
  const GradientDetailsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: editOptionW,
      child: const ExpansionTile(
        title: Text(
          "Gradient",
          style: TextStyle(color: Colors.white),
        ),
        iconColor: Colors.white,
        collapsedIconColor: Colors.white,
        children: [
          GradientTypesWidget(),
          GradientTilesTypesWidget(),
          GradientColorsListWidget()
        ],
      ),
    );
  }
}
