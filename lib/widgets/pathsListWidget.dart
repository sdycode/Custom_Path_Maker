import 'dart:developer';

import 'package:custom_path_maker/constants/consts.dart';
import 'package:custom_path_maker/constants/global.dart';
import 'package:custom_path_maker/models/PathModel.dart';
import 'package:custom_path_maker/providers/edit_option_provider.dart';
import 'package:custom_path_maker/providers/path_screen_provider.dart';
import 'package:custom_path_maker/widgets%20data/textStyles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

List<bool> showHidePaths = [true];

class LayersListWidget extends StatelessWidget {
  const LayersListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PathScreenProvider p =
        Provider.of<PathScreenProvider>(context, listen: false);
    EditOptionProvider editProvider = Provider.of<EditOptionProvider>(
      context,
    );
 

    return Positioned(
      right: editOptionW,
      top: 0,
      child: Container(
          color: Color.fromARGB(255, 48, 48, 48),
          width: layersListWidgetW,
          height: layersListWidgetH,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              ElevatedButton.icon(
                  onPressed: () {
                    log("points bef icon ${points.length}");

                    PathModel newpathModel =
                        PathModel.copyWithoutPoints(pathModels.last);
                    newpathModel.pathNo = newpathModel.pathNo + 1;
                    newpathModel.pathName = "Path${newpathModel.pathNo}";
                    newpathModel.points.clear();
                    log("points afer icon ${points.length}");
                    pathModels.add(newpathModel);

                    showHidePaths.add(true);
                    pathModelIndex = pathModels.length - 1;
                    points = List.from(pathModels[pathModelIndex].points);
                    log("points afer icon aff ${pathModels.last.points.length}");
                    p.updateUI();
                    editProvider.updateUI();

                    log("points afer icon aff ${pathModels.first.points.length}");
                  },
                  icon: const Icon(Icons.add_box_outlined),
                  label: const Text(
                    "Add New Path",
                    style: textFieldStyle,
                  )),
              Expanded(
                child: ListView.builder(
                    itemCount: pathModels.length,
                    itemBuilder: (c, i) {
                      return Container(
                        decoration: BoxDecoration(
                            color: i == pathModelIndex
                                ? Color.fromARGB(255, 88, 85, 85)
                                : Colors.black),
                        width: layersListWidgetW,
                        height: 40,
                        child: Row(
                          children: [
                            InkWell(
                              onTap: () {
                                log("1dt points $i  :${pathModels.first.points.length}");
                                pathModelIndex = i;
                                log("points bef $i : ${points.length}");
                                points = List.from(pathModels[i].points);
                                log("points afer $i : ${points.length}");
                                p.updateUI();
                                editProvider.updateUI();
                              },
                              child: Container(
                                width: layersListWidgetW * 0.7,
                                child: Text(
                                  pathModels[i].pathName,
                                  style: textFieldStyle,
                                ),
                              ),
                            ),
                            Container(
                              color: Colors.transparent,
                              child: IconButton(
                                  onPressed: () {
                                    showHidePaths[i] = !showHidePaths[i];
                                    p.updateUI();
                                    editProvider.updateUI();
                                  },
                                  icon: Icon(
                                    showHidePaths[i]
                                        ? Icons.remove_red_eye
                                        : Icons.remove_red_eye_outlined,
                                    color: Colors.white,
                                  )),
                            )
                          ],
                        ),
                      );
                    }),
              ),
            ],
          )),
    );
  }
}
