import 'package:custom_path_maker/constants/consts.dart';
import 'package:custom_path_maker/constants/global.dart';
import 'package:custom_path_maker/enum/enums.dart';
import 'package:custom_path_maker/providers/edit_option_provider.dart';
import 'package:custom_path_maker/providers/path_screen_provider.dart';
import 'package:custom_path_maker/widgets/Buttons/toggleButtons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OpenCloseButtonsWithSlider extends StatelessWidget {
  const OpenCloseButtonsWithSlider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int colorOrGradientIndex = pathModels[pathModelIndex].open == true ? 0 : 1;
    PathScreenProvider p =
        Provider.of<PathScreenProvider>(context, listen: false);
    EditOptionProvider editProvider = Provider.of<EditOptionProvider>(
      context,
    );

    return Container(
         margin: EdgeInsets.symmetric(vertical: 4),
      width: editOptionW,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ToggleButtonsWithNames(
            names: const ["Open", "Close"],
            selectedIndex: colorOrGradientIndex,
            onTap: () {
              pathModels[pathModelIndex].open =
                  !pathModels[pathModelIndex].open;
            },
          )
        ],
      ),
    );
  }
}
