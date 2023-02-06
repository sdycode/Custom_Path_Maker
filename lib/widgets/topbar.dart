import 'dart:convert';
import 'dart:developer';
import 'dart:html';
import 'dart:io';
import 'dart:typed_data';

import 'package:custom_path_maker/2D%20Gerometry%20Functions/functions%20to%20fill%20CurvePoints%20data/get_enums_to_fill_curvePointsList_from_map_data.dart';
import 'package:custom_path_maker/constants/colors.dart';
import 'package:custom_path_maker/constants/consts.dart';
import 'package:custom_path_maker/constants/global.dart';
import 'package:custom_path_maker/constants/iconImagesPaths.dart';
import 'package:custom_path_maker/enum/enums.dart';
import 'package:custom_path_maker/functions/Data%20from%20String/offsetFromString.dart';
import 'package:custom_path_maker/functions/Data%20from%20String/sizeFromString.dart';
import 'package:custom_path_maker/functions/getPathModelFromMap.dart';
import 'package:custom_path_maker/functions/resetColorStopPositiontoLast.dart';
import 'package:custom_path_maker/models/PathModel.dart';
import 'package:custom_path_maker/models/colorStopModel.dart';
import 'package:custom_path_maker/models/curve_point.dart';
import 'package:custom_path_maker/models/projectModel.dart';
import 'package:custom_path_maker/providers/path_screen_provider.dart';
import 'package:custom_path_maker/screens/demo_screen.dart';
import 'package:custom_path_maker/screens/path_drawing_screen.dart';
import 'package:custom_path_maker/widgets%20data/textStyles.dart';
import 'package:custom_path_maker/widgets/pathsListWidget.dart';
import 'package:file_picker/_internal/file_picker_web.dart';
import 'package:file_picker/file_picker.dart';
import 'package:file_saver/file_saver.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'dart:html' as html;

String preJsonString = "preJsonString";
String jsonConvertString = "jsonConvertString";

// FileOptions fileOptions =
//
class TopBar extends StatefulWidget {
  TopBar({Key? key}) : super(key: key);

  @override
  State<TopBar> createState() => _TopBarState();
}

class _TopBarState extends State<TopBar> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // document.onContextMenu.listen((event) => event.preventDefault());
  }

  final GlobalKey<PopupMenuButtonState> _menuKey =
      GlobalKey<PopupMenuButtonState>();

  Map<String, FileOptions> fileOptionssPopupMap = {
    IconsImagesPaths.openFileIcon: FileOptions.open,
    // IconsImagesPaths.saveFileIcon: FileOptions.save,
    IconsImagesPaths.saveAsFileIcon: FileOptions.saveas,
  };

  Map<String, String> fileOptionssNamesPopupMap = {
    IconsImagesPaths.openFileIcon: "Open",
    // IconsImagesPaths.saveFileIcon: "Save",
    IconsImagesPaths.saveAsFileIcon: "Save",
  };

  late PathScreenProvider p;

  @override
  Widget build(BuildContext context) {
    p = Provider.of<PathScreenProvider>(context);
    return Container(
      width: w,
      height: topbarH,
      color: topBarColor,
      child: Row(
        children: [
          fileOptionButton(context),
          Container(
            margin: EdgeInsets.all(4),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: moveShapeWidget ? Border.all(color: Colors.blue) : null,
                color:
                    Color.fromARGB(moveShapeWidget ? 150 : 0, 156, 206, 247)),
            child: InkWell(
              onTap: () {
                moveShapeWidget = !moveShapeWidget;
                p.updateUI();
              },
              child: Image.asset("assets/icons/translate.png"),
            ),
          ),
          Spacer(),
          // "G:\Shubham Personal Projects\Personal projects\custom_path_maker\assets\icons\youtube.png"

          Container(
            decoration: BoxDecoration(
              border: Border.all(),
              // color:topbarColor,
              borderRadius: BorderRadius.circular(30.0),
              //  boxShadow: [BoxShadow(color: Colors.blue, spreadRadius: 1, blurRadius: 3, offset: Offset(0,0))]
            ),
            child: TextButton.icon(
                onPressed: () async {
                  html.window.open(
                      'https://www.youtube.com/watch?v=jHOHo_xu9f4', "_blank");
                },
                icon: Container(
                    height: topbarH * 0.8,
                    child: Image.asset(
                      "assets/icons/youtube.png",
                      fit: BoxFit.contain,
                    )),
                label: const Text(
                  "Tutorial",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black),
                )),
          ),
          TextButton(
              onPressed: () async {
                showHowToUseDialog(context);
              },
              child: Text("How to Use"))
        ],
      ),
    );
  }

  fileOptionButton(BuildContext context) {
    return PopupMenuButton(
      color: Colors.black,
      key: _menuKey,
      tooltip: "File",
      itemBuilder: (_) => <PopupMenuItem<FileOptions>>[
        ...(fileOptionssPopupMap.entries
            .map((MapEntry<String, FileOptions> item) {
          return PopupMenuItem<FileOptions>(
              padding: const EdgeInsets.all(4),
              value: item.value,
              child: Row(
                children: [
                  Container(
                      margin: EdgeInsets.only(right: 8),
                      height: topbarH * 0.9,
                      width: topbarH * 0.9,
                      child: Image.asset(item.key)),
                  // Spacer(),

                  Container(
                    // padding: EdgeInsets.only(right: 6),
                    child: Text(
                      fileOptionssNamesPopupMap[item.key] ?? "",
                      textAlign: TextAlign.left,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  Spacer(),
                ],
              ));
        })),
      ],
      onSelected: (FileOptions d) async {
        switch (d) {
          case FileOptions.open:
            try {
              FilePickerResult? filePickerResult =
                  await FilePickerWeb.platform.pickFiles();
              PlatformFile file = filePickerResult!.files.first;
              if (file.extension != "json") {
                Fluttertoast.showToast(
                    msg: "Please select json file",
                    toastLength: Toast.LENGTH_LONG);
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
                  showHidePaths.add(true);
                  log("pathss ${pathModels.length}");
                });
                // pathModels.reversed;
                try {
                  // log("img ${jsonData['bgImage'] as List<int>.runtimeType}");
                  pickedImageData = Uint8List.fromList(
                      (jsonData['bgImage'] as List)
                          .map((e) => (e as int))
                          .toList());
                } catch (e) {}
                pathModelIndex = 0;
                points = List.from(pathModels[pathModelIndex].points);

                p.updateUI();
              } catch (e) {
                log("err $e");
                Fluttertoast.showToast(
                    msg: "Json has incorrect data",
                    toastLength: Toast.LENGTH_LONG);
              }

              return;
            } catch (e) {}

            break;
          case FileOptions.save:
            break;
          case FileOptions.saveas:
            try {
              if (kIsWeb) {
                // Map<String, dynamic> jsonModel =
                //     pathModels[pathModelIndex].toJson();
                showDialog(
                  context: context,
                  builder: (context) {
                    TextEditingController controller = TextEditingController();
                    return Dialog(
                      insetPadding: EdgeInsets.symmetric(horizontal: w * 0.3),
                      child: StatefulBuilder(
                          builder: (BuildContext context, StateSetter setter) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "Enter file name",
                                style: TextStyle(color: Colors.black),
                                textAlign: TextAlign.left,
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              TextField(
                                controller: controller,
                                onChanged: (value) {
                                  setter(
                                    () {},
                                  );
                                },
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.teal)),
                                  suffix: Text(
                                    ".json",
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                  // suffixIcon: Text(".json",style: TextStyle(color: Colors.grey),
                                  // )
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: controller.text.trim().length < 2
                                        ? Colors.grey
                                        : Colors.black,
                                    minimumSize:
                                        const Size.fromHeight(50), // NEW
                                  ),
                                  onPressed: () async {
                                    if (controller.text.trim().length < 2) {
                                      return;
                                    }
                                    Map<String, dynamic> proejctjsonModel =
                                        ProjectModel(
                                                bgImage:
                                                    pickedImageData!.toList(),
                                                projectName: "pathmakerproj1",
                                                pathModels: pathModels,
                                                size: Size(drawingBoardW,
                                                    drawingBoardH))
                                            .toJson();
                                    String jsonDecodedString =
                                        jsonEncode(proejctjsonModel);
                                    List<int> list =
                                        jsonDecodedString.codeUnits;
                                    Uint8List jsonDataAsUint8List =
                                        Uint8List.fromList(list);

                                    await FileSaver.instance.saveFile(
                                        controller.text.trim(),
                                        jsonDataAsUint8List,
                                        ".json",
                                        mimeType: MimeType.JSON);
                                    Navigator.maybePop(context);
                                  },
                                  child: Text(
                                    "Save",
                                    style: TextStyle(color: Colors.white),
                                  ))
                            ],
                          ),
                        );
                      }),
                    );
                  },
                );
              }
            } catch (e) {
              log("dirpath ee ${e}");
            }
            break;
          default:
        }
      },
      child: GestureDetector(
          onSecondaryTap: () {},
          onTap: () {
            _menuKey.currentState!.showButtonMenu();
          },
          child: Padding(
            padding: const EdgeInsets.all(3.0),
            child: Image.asset("assets/icons/file.png"),
          )
//  Icon(Icons.menu),
          ),
    );
  }

  void showHowToUseDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          insetPadding: EdgeInsets.symmetric(horizontal: w * 0.2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              RoundedBox(
                child: Text(
                  "import package path_maker: ^0.0.2",
                  style: whiteText,
                ),
              ),
              RoundedBox(
                  child: Text(
                "Create your custom path from FlutterPathMaker and save in .json format",
                style: whiteText,
              )),
              RoundedBox(
                  child: Text(
                "Checkout example given in path_maker package",
                style: whiteText,
              )),
              Container(
                  margin: EdgeInsets.all(8),
                  padding: EdgeInsets.all(8),
                  height: 200,
                  width: 300,
                  child: Image.asset(
                    "assets/sampleImage/code1.png",
                    height: 200,
                    width: 300,
                  ))
            ],
          ),
        );
      },
    );
  }
}

class RoundedBox extends StatelessWidget {
  final Widget child;
  const RoundedBox({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(8),
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8), color: Colors.black),
      child: child,
    );
  }
}
