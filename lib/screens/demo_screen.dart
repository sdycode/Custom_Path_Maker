import 'dart:convert';
import 'dart:typed_data';

import 'package:custom_path_maker/Painter/demopainter.dart';
import 'package:custom_path_maker/constants/consts.dart';
import 'package:custom_path_maker/functions/getPathModelFromMap.dart';
import 'package:custom_path_maker/widgets/CustomPathPainterFromAsset.dart';
import 'package:custom_path_maker/widgets/pathsListWidget.dart';
import 'package:file_picker/_internal/file_picker_web.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'dart:developer';
import 'dart:ui' as ui;

import 'package:custom_path_maker/2D%20Gerometry%20Functions/functions%20to%20fill%20CurvePoints%20data/get_enums_to_fill_curvePointsList_from_map_data.dart';
import 'package:custom_path_maker/2D%20Gerometry%20Functions/math/getRectBoundaryPointsFromGivenPoints.dart';
import 'package:custom_path_maker/constants/global.dart';
import 'package:custom_path_maker/constants/matrix.dart';
import 'package:custom_path_maker/enum/enums.dart';
import 'package:custom_path_maker/functions/checkIfIndexPresentInList.dart';
import 'package:custom_path_maker/models/PathModel.dart';
import 'package:custom_path_maker/screens/path_drawing_screen.dart';
import 'package:custom_path_maker/widgets/bottomBar.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DemoScreen extends StatefulWidget {
  DemoScreen({Key? key}) : super(key: key);

  @override
  State<DemoScreen> createState() => _DemoScreenState();
}

class _DemoScreenState extends State<DemoScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // openAndLoadFile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [

          CustomPathPainterFromAsset(
            filePath: "assets/thr111.json",
            size: Size(400, 360),
          ),
          // Container(
          //     width: w,
          //     // height: h * 0.3,
          //     color: Colors.pink.shade100,
          //     child: CustomPaint(
          //       size: Size(w * 0.4, h * 0.6),
          //       painter: SingeCustomPathPainter(
          //           pathModelIndex,
          //           pathModel: pathModels[pathModelIndex],
          //           getBoxForPoints(pathModels[pathModelIndex]
          //               .points
          //               .map((e) => e.point)
          //               .toList())),
          //       // child: Container(
          //       //   width: w * 0.4,
          //       //   height: h * 0.3,
          //       // ),
          //     ))
        
        
        ],
      ),
    );
  }

  void openAndLoadFile() async {
    String preJsonString = "preJsonString";
    String jsonConvertString = "jsonConvertString";
    try {
      FilePickerResult? filePickerResult =
          await FilePickerWeb.platform.pickFiles();
      PlatformFile file = filePickerResult!.files.first;
      if (file.extension != "json") {
        Fluttertoast.showToast(
            msg: "Please select json file", toastLength: Toast.LENGTH_LONG);
      }
      Uint8List bytes = file.bytes!;

      preJsonString = String.fromCharCodes(bytes);
      log("err preJsonString ${file.extension}  etxte/ $preJsonString");
      Map jsonData = {};
      try {
        jsonData = jsonDecode(preJsonString);
      } catch (e) {
        log("err preJsonString jsonData err $e / $jsonData");
      }

      log("err preJsonString jsonData $jsonData");
      try {
        List l = jsonData["pathModels"];
        pathModels.clear();
        Map firstMap = l.first as Map;
        int pn = 0;

        l.forEach((e) {
          PathModel? pathModel = getPathModelFromMap(e);
          // log("pointslen pnp $pn : ${pathModel!.points.length}");
          pn++;

          // resetColorStopPositiontoLastForGivenPathModel(pathModel);
          pathModels.add(pathModel!);
          // showHidePaths.add(true);
          log("pathss ${pathModels.length}");
        });
        // pathModels.reversed;
        try {
          // log("img ${jsonData['bgImage'] as List<int>.runtimeType}");
          pickedImageData = Uint8List.fromList(
              (jsonData['bgImage'] as List).map((e) => (e as int)).toList());
        } catch (e) {}
        pathModelIndex = 0;
        points = List.from(pathModels[pathModelIndex].points);
      } catch (e) {
        log("err $e");
        Fluttertoast.showToast(
            msg: "Json has incorrect data", toastLength: Toast.LENGTH_LONG);
      }

      return;
    } catch (e) {}
  }
}
