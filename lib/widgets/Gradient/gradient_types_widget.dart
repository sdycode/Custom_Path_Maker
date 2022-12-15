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

class GradientTypesWidget extends StatelessWidget {
  const GradientTypesWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    EditOptionProvider editProvider =
        Provider.of<EditOptionProvider>(context, listen: true);
    return Container(
      width: editOptionW,
      // color: Colors.red,
      // height: 400,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ...(GradientTypesOnly.values.map((e) => GradientTypeBox(e)).toList())
        ],
      ),
    );
  }
}

class GradientTypeBox extends StatelessWidget {
  final GradientTypesOnly gradientTypesOnly;
  GradientTypeBox(this.gradientTypesOnly, {Key? key}) : super(key: key);
  double tileSizeFactor = 0.16;
  double tileBoxSizeFactor = 0.2 * 1.4;
  @override
  Widget build(BuildContext context) {
    GradProvider gradProvider =
        Provider.of<GradProvider>(context, listen: false);
    PathScreenProvider pathScreenProvider =
        Provider.of<PathScreenProvider>(context, listen: false);
    EditOptionProvider editProvider =
        Provider.of<EditOptionProvider>(context, listen: false);
    double marginValue = (editOptionW * 0.1 / 6).floor().toDouble();

    return Transform.scale(
       scale: pathModels[pathModelIndex].gradientType.name ==
                      gradientTypesOnly.name
                  ? 1
                  : 0.85,
      child: InkWell(
        onTap: () {
          pathModels[pathModelIndex].gradientType = GradientType
              .values[GradientTypesOnly.values.indexOf(gradientTypesOnly)];
          pathScreenProvider.updateUI();
          editProvider.updateUI();
        },
        child: Container(
        
          child: Column(
            children: [
          
              Transform.scale(
               scale: 1,
                child: Container(
                  // margin: EdgeInsets.all(marginValue),
                  width: editOptionW * tileSizeFactor * 1.4,
                  height: editOptionW * tileSizeFactor,
                  decoration: BoxDecoration(
                      border: pathModels[pathModelIndex].gradientType.name ==
                              gradientTypesOnly.name
                          ? Border.all(width: 3,color: Colors.white)
                      : Border.all(width: 0.5, color: Colors.white),
                      borderRadius: BorderRadius.circular(8),
                      gradient: getGradientForTileMode(
                          pathModels[pathModelIndex].tileMode,
                          gradientTypesOnly.index,
                          gradProvider)),
                ),
              ),
           
              Text(
                gradientTypesOnly.name.capitaliseFirstLetter(),
                style: const TextStyle(color: Colors.white, fontSize: 13),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
