import 'package:custom_path_maker/constants/consts.dart';
import 'package:custom_path_maker/constants/global.dart';
import 'package:custom_path_maker/enum/enums.dart';
import 'package:custom_path_maker/providers/edit_option_provider.dart';
import 'package:custom_path_maker/providers/path_screen_provider.dart';
import 'package:custom_path_maker/widgets/Buttons/toggleButtons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FillStrokeButtonsWithSlider extends StatelessWidget {
  const FillStrokeButtonsWithSlider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int colorOrGradientIndex =
        pathModels[pathModelIndex].stroke == false ? 0 : 1;
          PathScreenProvider p =
        Provider.of<PathScreenProvider>(context, listen: false);
    EditOptionProvider editProvider = Provider.of<EditOptionProvider>(
      context,
    );
    return Container(
      width: editOptionW,
         margin: EdgeInsets.symmetric(vertical: 4),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ToggleButtonsWithNames(
            names: const ["Fill", "Stroke"],
            selectedIndex: colorOrGradientIndex,
            onTap: () {
              pathModels[pathModelIndex].stroke =
                  !pathModels[pathModelIndex].stroke;
            },
          )
        ],
      ),
    );
  }
}
