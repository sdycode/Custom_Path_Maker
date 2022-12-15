import 'package:custom_path_maker/constants/consts.dart';
import 'package:custom_path_maker/models/colorStopModel.dart';
import 'package:custom_path_maker/providers/gradprovider.dart';
import 'package:custom_path_maker/widgets/widget%20functions/checkIsItValidHexString.dart';
import 'package:custom_path_maker/widgets/widget%20functions/getHexColor.dart';
import 'package:custom_path_maker/widgets/widget%20functions/showColorPicker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GradientColorsListWidget extends StatelessWidget {
  const GradientColorsListWidget({Key? key}) : super(key: key);
  //  GradProvider gradProvider;
  final double bh = 40;
  @override
  Widget build(BuildContext context) {
  GradProvider  gradProvider = Provider.of(context, listen: true);
    return Container(
      constraints: BoxConstraints(
        maxHeight: h * 0.4,
      ),
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [
          BoxShadow(
              offset: Offset(0.5, 0.5),
              color: Colors.white,
              spreadRadius: 0.6,
              blurRadius: 0.7)
        ],
        color: const Color.fromARGB(255, 252, 254, 255),
      ),
      width: editOptionW,
      // height: 0.5*colorListBoxH,
      child: Column(
        children: [
          const Text(
            "Colors",
            style:  TextStyle(
                color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: gradProvider.colorStopModels.length,
                itemBuilder: (c, i) {
                  double pad = editOptionW * 0.02;
                  ColorStopModel e = gradProvider.colorStopModels[i];
                  TextEditingController controller = TextEditingController(
                    text: e.hexColorString,
                  );

                  return Container(
                    width: editOptionW - 16,
                    height: bh,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            showColorPicker(context, (Color d) {
                              // log("showColorPicker before ${gradProvider.colorStopModels[colorStopModel.colorStop]!.hexColorString}");
                              gradProvider.colorStopModels[i] = ColorStopModel(
                                  e.colorStop,
                                  d
                                      .toString()
                                      .replaceAll(')', '')
                                      .split('x')[1],
                                  e.left);
                              // .hexColorString = d.toString();
                              // log("showColorPicker after ${gradProvider.colorStopModels[colorStopModel.colorStop]!.hexColorString}");
                              gradProvider.updateUi();
                            },
                                Color(int.parse(
                                    "0x${gradProvider.colorStopModels[i].hexColorString}")));
                          },
                          child: Container(
                            height: bh - pad * 2,
                            margin: EdgeInsets.all(editOptionW * 0.02),
                            width: bh - pad * 2,
                            decoration: BoxDecoration(
                                border: Border.all(),
                                borderRadius: BorderRadius.circular(6),
                                color: getHexColor(e.hexColorString)),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              // border: Border.all(),
                              borderRadius: BorderRadius.circular(8)),
                          height: bh - pad * 2,
                          margin: EdgeInsets.all(editOptionW * 0.02),
                          width: editOptionW * 0.8 - bh - pad * 2,
                          child: Center(
                            child: true
                                ? TextField(
                                    textAlign: TextAlign.center,
                                    controller: controller,
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                    ),
                                    onSubmitted: (d) {
                                      if (checkIsItValidHexString(d)) {
                                        e.hexColorString = d;
                                      } else {
                                        controller.text = e.hexColorString;
                                      }
                                      gradProvider.updateUi();
                                    },
                                  )
                                : SelectableText(
                                    e.hexColorString,
                                    style: TextStyle(fontSize: bh * 0.5),
                                  ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            if (gradProvider.colorStopModels.length > 2) {
                              gradProvider.colorStopModels.removeAt(i);
                              gradProvider.updateUi();
                            }
                          },
                          child: Container(
                            height: bh - pad * 2,
                            margin: EdgeInsets.all(editOptionW * 0.02),
                            padding: EdgeInsets.all(bh * 0.1),
                            width: bh - pad * 2,
                            // color: Colors.amber,
                            child:
                                const FittedBox(child: const Icon(Icons.close)),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }
}
