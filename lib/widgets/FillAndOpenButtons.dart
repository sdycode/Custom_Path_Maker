import 'package:custom_path_maker/constants/button_styles.dart';
import 'package:custom_path_maker/constants/consts.dart';
import 'package:custom_path_maker/constants/global.dart';
import 'package:custom_path_maker/providers/path_screen_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FillAndOpenButtons extends StatelessWidget {
  const FillAndOpenButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PathScreenProvider p = Provider.of<PathScreenProvider>(context);

    return Container(
      width: editOptionW,
      margin: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ElevatedButton.icon(
              style: openPathButtonStyle,
              onPressed: () {
                pathModels[pathModelIndex].open =
                    !pathModels[pathModelIndex].open;

                p.updateUI();
              },
              icon: Icon(pathModels[pathModelIndex].open
                  ? Icons.check_box
                  : Icons.check_box_outline_blank),
              label: Text(pathModels[pathModelIndex].open ? "Open" : "Close")),
          ElevatedButton.icon(
              style: fillButtonStyle,
              onPressed: () {
                pathModels[pathModelIndex].stroke =
                    !pathModels[pathModelIndex].stroke;

                p.updateUI();
              },
              icon: Icon(!pathModels[pathModelIndex].stroke
                  ? Icons.check_box
                  : Icons.check_box_outline_blank),
              label: Text(pathModels[pathModelIndex].stroke ? "Fill" : "Fill")),
        ],
      ),
    );
  }
}
