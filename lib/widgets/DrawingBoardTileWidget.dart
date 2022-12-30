// ignore_for_file: use_build_context_synchronously

import 'dart:typed_data';

import 'package:custom_path_maker/constants/consts.dart';
import 'package:custom_path_maker/constants/global.dart';
import 'package:custom_path_maker/enum/enums.dart';
import 'package:custom_path_maker/functions/updateWholeUI.dart';
import 'package:custom_path_maker/providers/edit_option_provider.dart';
import 'package:custom_path_maker/providers/path_screen_provider.dart';
import 'package:custom_path_maker/screens/path_drawing_screen.dart';
import 'package:custom_path_maker/widgets%20data/textStyles.dart';
import 'package:custom_path_maker/widgets/opacitySlider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

double minBoxSizeW = 200;
double maxBoxSizeW = 2000;
TextEditingController _wController =
    TextEditingController(text: drawingBoardW.toStringAsFixed(2));
TextEditingController _hController =
    TextEditingController(text: drawingBoardH.toStringAsFixed(2));

class DrawingBoardTileWidget extends StatelessWidget {
  const DrawingBoardTileWidget({Key? key}) : super(key: key);
  final double boxH = 32;
  final double textFieldBoxWFactor = 0.48;
  final double textFieldNameBoxWFactor = 0.2;

  @override
  Widget build(BuildContext context) {
    PathScreenProvider p =
        Provider.of<PathScreenProvider>(context, listen: false);
    EditOptionProvider editProvider = Provider.of<EditOptionProvider>(
      context,
    );
    return Container(
        // color: Colors.green,
        width: editOptionW,
        child: ExpansionTile(
          // childrenPadding: EdgeInsets.zero,
          // tilePadding: EdgeInsets.zero,
          title: const Text(
            "Drawing Board",
            style: TextStyle(color: Colors.white),
          ),
          iconColor: Colors.white,
          collapsedIconColor: Colors.white,
          children: [
            Container(
              // color: Colors.orange,
              // height: 40,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      width: editOptionW * textFieldBoxWFactor,
                      height: boxH,
                      // color: Colors.purple,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          MouseRegion(
                            cursor: SystemMouseCursors.resizeUpDown,
                            child: GestureDetector(
                              onVerticalDragUpdate: (d) {
                                if ((drawingBoardW + d.delta.dy) >
                                        minBoxSizeW &&
                                    (drawingBoardW + d.delta.dy) <
                                        maxBoxSizeW) {
                                  drawingBoardW += d.delta.dy;
                                  _wController.text =
                                      drawingBoardW.toStringAsFixed(2);
                                  _wController.selection =
                                      TextSelection.fromPosition(TextPosition(
                                          offset: _wController.text.length));

                                  p.updateUI();
                                  editProvider.updateUI();
                                }
                              },
                              child: Container(
                                  color: Color.fromARGB(0, 21, 21, 21),
                                  width: editOptionW * textFieldNameBoxWFactor,
                                  height: boxH,
                                  child: const Center(
                                    child: Text(
                                      "W",
                                      style: textFieldStyle,
                                    ),
                                  )),
                            ),
                          ),
                          Container(
                            height: boxH,
                            width: editOptionW * textFieldBoxWFactor -
                                editOptionW * textFieldNameBoxWFactor,
                            child: TextField(
                              onSubmitted: (v) {
                                if (double.tryParse(v) != null) {
                                  if (double.parse(v) > minBoxSizeW &&
                                      double.parse(v) < maxBoxSizeW) {
                                    drawingBoardW = double.parse(v);
                                  } else {}
                                }
                                _wController.text =
                                    drawingBoardW.toStringAsFixed(2);
                                _wController.selection =
                                    TextSelection.fromPosition(TextPosition(
                                        offset: _wController.text.length));
                                p.updateUI();
                                editProvider.updateUI();
                              },
                              onChanged: (v) {
                                if (double.tryParse(v) != null) {
                                  if (double.parse(v) > minBoxSizeW &&
                                      double.parse(v) < maxBoxSizeW) {
                                    drawingBoardW = double.parse(v);
                                  }
                                } else {}
                                p.updateUI();
                                editProvider.updateUI();
                              },
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                contentPadding: EdgeInsets.only(left: 8),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.white, width: 1.0),
                                ),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.white, width: 1.0),
                                ),
                              ),
                              controller: _wController,
                              style: textFieldStyle,
                            ),
                          ),
                        ],
                      )),
                  Container(
                      width: editOptionW * textFieldBoxWFactor,
                      height: boxH,
                      // color: Colors.purple,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          MouseRegion(
                            cursor: SystemMouseCursors.resizeUpDown,
                            child: GestureDetector(
                              onVerticalDragUpdate: (d) {
                                if ((drawingBoardH + d.delta.dy) >
                                        minBoxSizeW &&
                                    (drawingBoardH + d.delta.dy) <
                                        maxBoxSizeW) {
                                  drawingBoardH += d.delta.dy;

                                  _hController.text =
                                      drawingBoardH.toStringAsFixed(2);
                                  _hController.selection =
                                      TextSelection.fromPosition(TextPosition(
                                          offset: _hController.text.length));
                                  p.updateUI();
                                  editProvider.updateUI();
                                }
                              },
                              child: Container(
                                  color: Color.fromARGB(0, 21, 21, 21),
                                  width: editOptionW * textFieldNameBoxWFactor,
                                  height: boxH,
                                  child: const Center(
                                    child: Text(
                                      "H",
                                      style: textFieldStyle,
                                    ),
                                  )),
                            ),
                          ),
                          Container(
                            height: boxH,
                            //  color: Colors.red,
                            width: editOptionW * textFieldBoxWFactor -
                                editOptionW * textFieldNameBoxWFactor,
                            child: TextField(
                              onSubmitted: (v) {
                                if (double.tryParse(v) != null) {
                                  if (double.parse(v) > minBoxSizeW &&
                                      double.parse(v) < maxBoxSizeW) {
                                    drawingBoardH = double.parse(v);
                                  } else {}
                                }
                                _hController.text =
                                    drawingBoardW.toStringAsFixed(2);
                                _hController.selection =
                                    TextSelection.fromPosition(TextPosition(
                                        offset: _hController.text.length));
                                p.updateUI();
                                editProvider.updateUI();
                              },
                              onChanged: (v) {
                                if (double.tryParse(v) != null) {
                                  if (double.parse(v) > minBoxSizeW &&
                                      double.parse(v) < maxBoxSizeW) {
                                    drawingBoardH = double.parse(v);
                                  }
                                } else {}

                                p.updateUI();
                                editProvider.updateUI();
                              },
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                contentPadding: EdgeInsets.only(left: 8),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.white, width: 1.0),
                                ),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.white, width: 1.0),
                                ),
                              ),
                              controller: _hController,
                              style: textFieldStyle,
                            ),
                          ),
                        ],
                      )),
                ],
              ),
            ),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                    width: editOptionW * 0.92,
                    height: 30,
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: Color.fromARGB(255, 148, 146, 146),
                            width: 0.5),
                        borderRadius: BorderRadius.circular(20)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        TextButton(
                            onPressed: () async {
                              backgroundImageStatus =
                                  BackgroundImageStatus.asset;

                              pickedImageData =
                                  Uint8List.fromList(assetImageData!);
                              p.updateUI();
                              editProvider.updateUI();
                            },
                            child: Text(
                              "BG Image",
                              style: textFieldStyle.copyWith(fontSize: 14),
                            )),
                        Spacer(),
                        IconButton(
                            iconSize: 20,
                            padding: EdgeInsets.zero,
                            onPressed: () async {
                              await pickAndLoadImageFromDevice();
                              p.updateUI();
                              editProvider.updateUI();
                            },
                            icon: const Icon(
                              Icons.add,
                              color: Colors.white,
                            )),
                        IconButton(
                            iconSize: 20,
                            padding: EdgeInsets.zero,
                            onPressed: () {
                              
                              if (backgroundImageStatus ==
                                  BackgroundImageStatus.none) {
                                backgroundImageStatus =
                                    BackgroundImageStatus.asset;
                              } else {
                                backgroundImageStatus =
                                    BackgroundImageStatus.none;
                              }
                              p.updateUI();
                              editProvider.updateUI();
                            },
                            icon: Icon(
                              backgroundImageStatus ==
                                      BackgroundImageStatus.none
                                  ? Icons.check_circle_outline
                                  : Icons.check_circle,
                              color: Colors.white,
                            ))
                        // backgroundImageStatus
                      ],
                    ))),
            if (pickedImageData != null &&
                backgroundImageStatus != BackgroundImageStatus.none)
              Padding(
                padding: EdgeInsets.all(4),
                child: Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    ...List.generate(
                        BoxFit.values.length,
                        (i) => Padding(
                              padding: const EdgeInsets.all(editOptionW * 0.01),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(4),
                                child: InkWell(
                                  onTap: () {
                                    bgImageFitIndex = i;
                                    p.updateUI();
                                    editProvider.updateUI();
                                  },
                                  child: Container(
                                      width: editOptionW * 0.18,
                                      height: editOptionW * 0.18,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(4),
                                        border: bgImageFitIndex == i
                                            ? Border.all(
                                                color: Colors.red, width: 3)
                                            : null,
                                        image: DecorationImage(
                                            image:
                                                MemoryImage(pickedImageData!),
                                            fit: BoxFit.values[i]),
                                      )),
                                ),
                              ),
                            ))
                  ],
                ),
              ),
            if (pickedImageData != null &&
                backgroundImageStatus != BackgroundImageStatus.none)
              BGImageOpacitySlider()
          ],
        ));
  }
}
