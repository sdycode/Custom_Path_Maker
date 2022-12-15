import 'package:custom_path_maker/constants/button_styles.dart';
import 'package:custom_path_maker/constants/consts.dart';
import 'package:custom_path_maker/constants/global.dart';
import 'package:custom_path_maker/enum/enums.dart';
import 'package:custom_path_maker/providers/edit_option_provider.dart';
import 'package:custom_path_maker/providers/path_screen_provider.dart';
import 'package:custom_path_maker/widgets/widget%20functions/showColorPicker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ColorAndGradientButton extends StatelessWidget {
  const ColorAndGradientButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PathScreenProvider p =
        Provider.of<PathScreenProvider>(context, listen: false);
    EditOptionProvider editProvider = Provider.of<EditOptionProvider>(
      context,
    );
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4),
      width: editOptionW,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ElevatedButton(
              style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all(Colors.white),
                  backgroundColor: MaterialStateProperty.all(Color(int.parse(
                      "0xff${pathModels[pathModelIndex].hexColorString}")))),
              onPressed: () {
                // showColorPicker(context, fun, prevColor);

                showColorPicker(context, (Color d) {
                  // gradProvider.colorStopModels[i] = ColorStopModel(e.colorStop,
                  //     d.toString().replaceAll(')', '').split('x')[1], e.left);

                  pathModels[pathModelIndex].hexColorString =
                      d.toString().replaceAll(')', '').split('x')[1];
                  p.updateUI();
                  editProvider.updateUI();
                },
                    Color(int.parse(
                        "0xff${pathModels[pathModelIndex].hexColorString}")));
              },
              child: Text("")),
          ElevatedButton.icon(
              style: openPathButtonStyle,
              onPressed: () {
                pathModels[pathModelIndex].gradientType = GradientType.color;

                p.updateUI();
                editProvider.updateUI();
              },
              icon: Icon(
                  pathModels[pathModelIndex].gradientType == GradientType.color
                      ? Icons.check_box
                      : Icons.check_box_outline_blank),
              label: Text(
                  pathModels[pathModelIndex].gradientType == GradientType.color
                      ? "Color"
                      : "Color")),
          ElevatedButton.icon(
              style: fillButtonStyle,
              onPressed: () {
                pathModels[pathModelIndex].gradientType = GradientType.linear;
                editProvider.updateUI();
                p.updateUI();
              },
              icon: Icon(
                  pathModels[pathModelIndex].gradientType != GradientType.color
                      ? Icons.check_box
                      : Icons.check_box_outline_blank),
              label: Text(
                  pathModels[pathModelIndex].gradientType != GradientType.color
                      ? "Gradient"
                      : "Gradient")),
        ],
      ),
    );
  }
}
