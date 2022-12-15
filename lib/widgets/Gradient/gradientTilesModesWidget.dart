import 'dart:developer';

import 'package:custom_path_maker/constants/consts.dart';
import 'package:custom_path_maker/constants/global.dart';
import 'package:custom_path_maker/enum/enums.dart';
import 'package:custom_path_maker/extension/extensions.dart';
import 'package:custom_path_maker/functions/gradient%20functions/getNormaGradient.dart';
import 'package:custom_path_maker/providers/edit_option_provider.dart';
import 'package:custom_path_maker/providers/gradprovider.dart';
import 'package:custom_path_maker/providers/path_screen_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GradientTilesTypesWidget extends StatelessWidget {
  const GradientTilesTypesWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    EditOptionProvider editProvider = Provider.of<EditOptionProvider>(
      context,
    );
    return Container(
      width: editOptionW,
      // color: Colors.red,
      // height: 400,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ...(TileMode.values.map((e) => GradientTileBox(e)).toList())
        ],
      ),
    );
  }
}

class GradientTileBox extends StatelessWidget {
  final TileMode tileMode;
   GradientTileBox(this.tileMode, {Key? key}) : super(key: key);
  double tileSizeFactor = 0.12;
  @override
  Widget build(BuildContext context) {
    GradProvider gradProvider =
        Provider.of<GradProvider>(context, listen: false);
    PathScreenProvider pathScreenProvider =
        Provider.of<PathScreenProvider>(context, listen: false);
    EditOptionProvider editProvider =
        Provider.of<EditOptionProvider>(context, listen: false);
    double marginValue = (editOptionW * 0.1 / 8).floor().toDouble();
    return Transform.scale(
       scale: pathModels[pathModelIndex].tileMode.name == tileMode.name
                    ? 1
                    : 0.85,
      child: InkWell(
        onTap: () {
          pathModels[pathModelIndex].tileMode = tileMode;
          // log("sele tilemode ${pathModels[pathModelIndex].tileMode}/  ${tileMode}");
          pathScreenProvider.updateUI();
          editProvider.updateUI();
        },
        child: Container(
          // width: editOptionW * 0.23,
          // padding: EdgeInsets.all(12),
          child: Column(
            children: [
              const SizedBox(
                height: 8,
              ),
              Transform.scale(
                scale: 1,
                // scale: pathModels[pathModelIndex].tileMode.name == tileMode.name
                //     ? 1
                //     : 0.85,
                child: Container(
                  // margin: EdgeInsets.all(marginValue),
                  width: editOptionW * tileSizeFactor*1.4,
                  height: editOptionW * tileSizeFactor,
                  decoration: BoxDecoration(
                      border: pathModels[pathModelIndex].tileMode.name ==
                              tileMode.name
                          ? Border.all(width: 3, color: Colors.white)
                          : Border.all(width: 0.5, color: Colors.white),
                      borderRadius: BorderRadius.circular(8),
                      gradient: getGradientForTileMode(
                          tileMode,
                          pathModels[pathModelIndex].gradientType.index,
                          gradProvider)),
                ),
              ),
              // const SizedBox(
              //   height: 8,
              // ),
              Text(
                tileMode.name.capitaliseFirstLetter(),
                style: const TextStyle(color: Colors.white,fontSize: 12),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
