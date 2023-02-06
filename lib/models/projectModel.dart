import 'package:custom_path_maker/models/PathModel.dart';
import 'package:flutter/material.dart';

class ProjectModel {
  String projectName;
  List<int> bgImage;
  List<PathModel> pathModels;
  Size size;

  ProjectModel({
    required this.projectName,
    required this.bgImage,
    required this.pathModels,
    required this.size
  });
  Map<String, dynamic> toJson() {
    return {
      "projectName": this.projectName,
      "pathModels": [
        ...(this.pathModels.map((e) {
          return e.toJson();
        }))
      ],
      "bgImage": this.bgImage,
      "size":this.size.toString()
    };
  }

  factory ProjectModel.fromJson(Map<String, dynamic> map) {
    return ProjectModel(
        projectName: map["projectName"],
        bgImage: map["bgImage"],
        pathModels: [map["pathModels"]],
        
        size: map["size"]
        );
  }
}
