import 'package:custom_path_maker/constants/consts.dart';
import 'package:custom_path_maker/constants/global.dart';
import 'package:custom_path_maker/providers/path_screen_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TopBar extends StatelessWidget {
  const TopBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PathScreenProvider p = Provider.of<PathScreenProvider>(context);
    return Container(
      width: w,
      height: topbarH,
      color: Colors.amber.shade200,
      child: Row(
        children: [
          ElevatedButton(
              onPressed: () {
                showCUrrentEditingPath = !showCUrrentEditingPath;
                p.updateUI();
              },
              child: Text(showCUrrentEditingPath ? "hide" : "Show"))
        ],
      ),
    );
  }
}
/*
 ElevatedButton(
                    style: ButtonStyle(
                        foregroundColor:
                            MaterialStateProperty.all(Colors.white),
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
*/