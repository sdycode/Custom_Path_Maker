import 'dart:developer';
import 'dart:io';

import 'package:custom_path_maker/constants/consts.dart';
import 'package:custom_path_maker/constants/global.dart';
import 'package:custom_path_maker/functions/code/getModelAndEnumsStringData.dart';
import 'package:custom_path_maker/widgets/dartCodeWithCopyButton.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:custom_path_maker/functions/code/getAllStringData.dart';
import 'package:custom_path_maker/functions/code/getImportLinessString.dart';

import 'package:custom_path_maker/functions/code/getPaintContainerWidgetAsString.dart';

import 'package:custom_path_maker/functions/code/getStringOfAllFunctionsOfCurvepointsList.dart';
import 'package:custom_path_maker/functions/code/getStringOfCommonCanvasFunction.dart';
import 'package:custom_path_maker/functions/code/getStringOfListOfPathModelsInObjectListForm.dart';
import 'package:custom_path_maker/functions/code/getStringofAllCanvasFunctions.dart';
import 'package:custom_path_maker/functions/resetAdjcentCubicToQuadBezeirifSelectedPointIsArc.dart';

showCodeInDialog(BuildContext context) async {
  showDialog(
      context: context,
      builder: (context) => Dialog(
            child: Container(
              height: h * 0.9,
              color: const Color.fromARGB(255, 241, 238, 220),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ExpansionTile(
                      title: Row(
                        children: [
                          const Text(
                              "Models & Enums : Add Only Once In Project"),
                          const Spacer(),
                          ElevatedButton(
                              onPressed: () async {
                                Directory? dir = await getDownloadsDirectory();
                                log("dirpath ${dir?.path}");
                                File file = File(
                                    "${dir?.path}/Painter_Models_Enums.dart");
                                String totalDataIn1File =
                                    getModelAndEnumsStringData();
                                file.writeAsString(totalDataIn1File);
                              },
                              child: const Text("Download Models & Enums")),
                          ElevatedButton(
                              onPressed: () async {
                                Directory? dir = await getDownloadsDirectory();
                                log("dirpath ${dir?.path}");
                                String painterClassName = "MyFirstPainter";
                                File file = File(
                                    "${dir?.path}/${painterClassName}.dart");

                                String totalDataIn1File = getImportLinessString() +
                                    getPaintContainerWidgetAsString(
                                        painterClassName) +
                                    getAllStringData(painterClassName) +
                                    getStringOfListOfPathModelsInObjectListForm() +
                                    getStringofAllCanvasFunctions(pathModels) +
                                    getStringOfAllFunctionsOfCurvepointsList(
                                        pathModels) +
                                    getStringOfCommonCanvasFunction();
                                file.writeAsString(totalDataIn1File);
                              },
                              child: const Text("Download Paint File"))
                        ],
                      ),
                      children: [
                        DartCodeWithCopyButton(
                          w: w * 0.8,
                          h: h * 0.3,
                          title: "Model - Enums",
                          content: getModelAndEnumsStringData(),
                        ),
                      ],
                    ),
                    DartCodeWithCopyButton(
                      w: w * 0.8,
                      h: 80,
                      title: "Import Lines",
                      content: getImportLinessString(),
                    ),
                    DartCodeWithCopyButton(
                      w: w * 0.8,
                      h: 120,
                      title: "Widget",
                      content:
                          getPaintContainerWidgetAsString(painterClassName),
                    ),
                    DartCodeWithCopyButton(
                      w: w * 0.8,
                      h: h * 0.3,
                      title: "Painter",
                      content: getAllStringData(painterClassName),
                    ),
                    DartCodeWithCopyButton(
                      w: w * 0.8,
                      h: h * 0.3,
                      title: "PathModels",
                      content: getStringOfListOfPathModelsInObjectListForm(),
                    ),
                    DartCodeWithCopyButton(
                      w: w * 0.8,
                      h: h * 0.3,
                      title: "CanvasFunctions",
                      content: getStringofAllCanvasFunctions(pathModels),
                    ),
                    DartCodeWithCopyButton(
                      w: w * 0.8,
                      h: h * 0.3,
                      title: "Points List",
                      content:
                          getStringOfAllFunctionsOfCurvepointsList(pathModels),
                    ),
                    DartCodeWithCopyButton(
                      w: w * 0.8,
                      h: h * 0.3,
                      title: "Canvas Function",
                      content: getStringOfCommonCanvasFunction(),
                    ),
                  ],
                ),
              ),
            ),
          ));
}
