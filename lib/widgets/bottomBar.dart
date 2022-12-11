import 'package:custom_path_maker/constants/consts.dart';
import 'package:custom_path_maker/widgets/radius_slider.dart';
import 'package:flutter/material.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: w,
      height: bottombarH,
      color: Colors.amber.shade200,
    child:const  RadiusSlider(),
    );
  }
}