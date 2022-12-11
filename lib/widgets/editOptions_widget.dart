

import 'package:custom_path_maker/constants/consts.dart';
import 'package:custom_path_maker/widgets/curveiconsinrow.dart';
import 'package:flutter/material.dart';

class EditOptions_widget extends StatelessWidget {
  const EditOptions_widget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 0,
      top: 0,
      child: Container(
        width: editOptionW,
        color: Colors.green.shade100,
        height: h,
        child: Column(
          children: [
             CurveIconsInRowWidget()
          ],
        ),
      ),
    );
  }
}