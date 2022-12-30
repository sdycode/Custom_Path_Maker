import 'dart:developer';
import 'dart:io';

import 'package:custom_path_maker/constants/consts.dart';
import 'package:custom_path_maker/constants/global.dart';
import 'package:custom_path_maker/providers/path_screen_provider.dart';
import 'package:custom_path_maker/screens/path_drawing_screen.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
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
          Container(
            margin: EdgeInsets.all(4),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: moveShapeWidget ? Border.all(color: Colors.blue) : null,
                color:
                    Color.fromARGB(moveShapeWidget ? 150 : 0, 156, 206, 247)),
            child: InkWell(
              onTap: () {
                moveShapeWidget = !moveShapeWidget;
                p.updateUI();
              },
              child: Image.asset("assets/icons/translate.png"),
            ),
          ),
          // eid 24585
          //
          ElevatedButton(
              onPressed: () async {
                Directory? dir = await getDownloadsDirectory();
                log("dirpath ${dir?.path}");
                File file = File("${dir?.path}/Painter_Models_Enums.dart");

                file.writeAsString("string with nothing");
                // showCUrrentEditingPath = !showCUrrentEditingPath;
                // p.updateUI();
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
