import 'package:custom_path_maker/constants/consts.dart';
import 'package:custom_path_maker/providers/edit_option_provider.dart';
import 'package:custom_path_maker/providers/path_screen_provider.dart';
import 'package:custom_path_maker/screens/path_drawing_screen.dart';
import 'package:custom_path_maker/widgets%20data/sliderThemeData.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BGImageOpacitySlider extends StatelessWidget {
  const BGImageOpacitySlider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) { PathScreenProvider p =
        Provider.of<PathScreenProvider>(context, listen: false);
    EditOptionProvider editProvider = Provider.of<EditOptionProvider>(
      context,
    );
    return Container(
      width: editOptionW,
      child: SliderTheme(
        data: sliderThemeData.copyWith(),
        child: Slider(
          thumbColor: Colors.pink.shade100,
          activeColor: Colors.pink.shade300,
          min: 0,
          max: 1.0,
          divisions: 100,
            value: bgImageOpacity,
            onChanged: (d) {
              bgImageOpacity = d;p.updateUI();
      editProvider.updateUI();
      
            }),
      ),
    );
  }
}
