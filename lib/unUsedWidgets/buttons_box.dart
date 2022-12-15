import 'package:custom_path_maker/constants/global.dart';
import 'package:flutter/material.dart';
/*
buttonBoxUnUsed(){
  return    Positioned(
                      right: 0,
                      bottom: 0,
                      child: Container(
                        width: w * 0.5,
                        height: 40,
                        child: Row(
                          children: [
                            ...List.generate(pathModels.length, (i) {
                              return TextButton(
                                  onPressed: () {
                                    points = pathModels[i].points;
                                    pathModelIndex = i;
                                    selectedPoint = -1;
                                    selectedPoints.clear();
                                    setState(() {});
                                  },
                                  child: Text(
                                    i.toString(),
                                    style: TextStyle(
                                        fontSize:
                                            pathModelIndex == i ? 25 : 18),
                                  ));
                            }),
                            IconButton(
                                onPressed: () {
                                  pathModels.add(
                                    PathModel.withCurvePoints([],
                                        paint: Paint()
                                          ..color = Colors.primaries[
                                              (pathModels.length) %
                                                  Colors.primaries.length]
                                          ..strokeWidth = 3,
                                        pathName: "path${pathModels.length}"),
                                  );
                                  points = pathModels.last.points;
                                  selectedPoint = -1;
                                  selectedPoints.clear();
                                  setState(() {});
                                },
                                icon: const Icon(
                                  Icons.add,
                                  color: Colors.white,
                                ))
                          ],
                        ),
                      ))
;
}
*/