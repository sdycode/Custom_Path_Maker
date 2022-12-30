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
  LayersListWidget({Key? key}) : super(key: key);
  ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    PathScreenProvider p =
        Provider.of<PathScreenProvider>(context, listen: false);
    EditOptionProvider editProvider = Provider.of<EditOptionProvider>(
      context,
    );
    // scrollController.addListener(() {
    //   if (scrollController.hasClients) {
    //     scrollController.animateTo(scrollController.position.maxScrollExtent,
    //         duration: Duration(milliseconds: 500), curve: Curves.decelerate);
    //   }
    //   p.updateUI();
    // });
    return Positioned(
        right: editOptionW,
        top: 0,
        child: Container(
          width: layersListWidgetW,
          child: ExpansionTile(
            title: Text(
              "Paths",
              style: TextStyle(color: Colors.white),
            ),
            iconColor: Colors.white,
            collapsedIconColor: Colors.white,
            // title: Text("Paths"),
            children: [
              Container(
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 48, 48, 48),
                      borderRadius: BorderRadius.circular(8)),
                  width: layersListWidgetW,
                  height: layersListWidgetH,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: InkWell(
                              onTap: () async {
                                PathModel newpathModel =
                                    PathModel.copyWithoutPoints(
                                        pathModels.last);
                                newpathModel.pathNo = newpathModel.pathNo + 1;
                                newpathModel.pathName =
                                    "Path${newpathModel.pathNo}";
                                newpathModel.points.clear();
                                newpathModel.hexColorString = hexColors[
                                    pathModels.length % hexColors.length];
                                log("hexx ${newpathModel.hexColorString}");
                                pathModels.add(newpathModel);

                                showHidePaths.add(true);
                                pathModelIndex = pathModels.length - 1;
                                points = List.from(
                                    pathModels[pathModelIndex].points);
                                selectedPoints.clear();
                                p.updateUI();
                                editProvider.updateUI();
                              },
                              child: Container(
                                  width: editOptionW * 0.92,
                                  height: 30,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Color.fromARGB(
                                              255, 148, 146, 146),
                                          width: 0.5),
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Text(
                                        "Add New Path",
                                        style: textFieldStyle.copyWith(
                                            fontSize: 14),
                                      ),
                                      Icon(
                                        Icons.add,
                                        color: Colors.white,
                                      )
                                    ],
                                  )),
                            ),
                          )),
                      Expanded(
                        child: RawScrollbar(
                          thickness: 10,
                          thumbVisibility: true,
                          trackVisibility: true,
                          child: ListView.builder(
                              controller: scrollController,
                              itemCount: pathModels.length,
                              itemBuilder: (c, i) {
                                return Container(
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 3, vertical: 2),
                                  padding: EdgeInsets.only(left: 6),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6),
                                      color: i == pathModelIndex
                                          ? Color.fromARGB(255, 88, 85, 85)
                                          : Colors.black),
                                  width: layersListWidgetW,
                                  height: 32,
                                  child: Row(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          log("1dt points $i  :${pathModels.first.points.length}");
                                          pathModelIndex = i;
                                          log("points bef $i : ${points.length}");
                                          points =
                                              List.from(pathModels[i].points);
                                          log("points afer $i : ${points.length}");
                                          p.updateUI();
                                          editProvider.updateUI();
                                        },
                                        child: Container(
                                          width: layersListWidgetW * 0.76 - 16,
                                          child: Text(
                                            pathModels[i].pathName,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: textFieldStyle,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: layersListWidgetW * 0.12,
                                        // color: Colors.red,
                                        child: IconButton(
                                            iconSize: 20,
                                            padding: EdgeInsets.zero,
                                            onPressed: () {
                                              showHidePaths[i] =
                                                  !showHidePaths[i];
                                              p.updateUI();
                                              editProvider.updateUI();
                                            },
                                            icon: Icon(
                                              showHidePaths[i]
                                                  ? Icons.remove_red_eye
                                                  : Icons
                                                      .remove_red_eye_outlined,
                                              color: Colors.white,
                                            )),
                                      ),
                                      Container(
                                        width: layersListWidgetW * 0.12,
                                        // color: Colors.purple,
                                        child: IconButton(
                                            iconSize: 20,
                                            padding: EdgeInsets.zero,
                                            onPressed: () {
                                              p.updateUI();
                                              editProvider.updateUI();
                                            },
                                            icon: const Icon(
                                              Icons.more_vert,
                                              color: Colors.white,
                                            )),
                                      )
                                    ],
                                  ),
                                );
                              }),
                        ),
                      ),
                    ],
                  )),
            ],
          ),
        ));
  }
}
