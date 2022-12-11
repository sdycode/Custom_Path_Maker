import 'package:custom_path_maker/constants/consts.dart';
import 'package:flutter/material.dart';

class TopBar extends StatelessWidget {
  const TopBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: w,
      height: topbarH,
      color: Colors.amber.shade200,
    );
  }
}