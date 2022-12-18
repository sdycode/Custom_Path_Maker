import 'package:custom_path_maker/constants/button_styles.dart';
import 'package:custom_path_maker/constants/consts.dart';
import 'package:custom_path_maker/constants/global.dart';
import 'package:custom_path_maker/enum/enums.dart';
import 'package:custom_path_maker/providers/edit_option_provider.dart';
import 'package:custom_path_maker/providers/path_screen_provider.dart';
import 'package:custom_path_maker/widgets/Buttons/toggleButtons.dart';
import 'package:custom_path_maker/widgets/widget%20functions/showColorPicker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// int colorOrGradientIndex = 0;

class ColorAndGradientButton extends StatelessWidget {
  const ColorAndGradientButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PathScreenProvider p =
        Provider.of<PathScreenProvider>(context, listen: false);
    EditOptionProvider editProvider = Provider.of<EditOptionProvider>(
      context,
    );

    int colorOrGradientIndex =
        pathModels[pathModelIndex].gradientType == GradientType.color ? 0 : 1;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
            margin: EdgeInsets.symmetric(vertical: 4),
            width: editOptionW,
            child: ToggleButtonsWithNames(
              names: const ["Color", "Gradient"],
              selectedIndex: colorOrGradientIndex,
              onTap: () {
                if (pathModels[pathModelIndex].gradientType ==
                    GradientType.color) {
                  pathModels[pathModelIndex].gradientType = GradientType.linear;
                } else {
                  pathModels[pathModelIndex].gradientType = GradientType.color;
                }
              },
            )),
        if (pathModels[pathModelIndex].gradientType == GradientType.color)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(28),
              child: InkWell(
                onTap: () {
                  showColorPicker(context, (Color d) {
                    pathModels[pathModelIndex].hexColorString =
                        d.toString().replaceAll(')', '').split('x')[1];
                    p.updateUI();
                    editProvider.updateUI();
                  },
                      Color(int.parse(
                          "0xff${pathModels[pathModelIndex].hexColorString}")));
                },
                child: Container(
                  height: 30,
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(28),
                      color: Color(int.parse(
                          "0xff${pathModels[pathModelIndex].hexColorString}"))),
                ),
              ),
            ),
          )
      ],
    );
  }
}
