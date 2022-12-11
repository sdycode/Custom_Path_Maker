import 'package:custom_path_maker/constants/global.dart';

getStringOfListOfPathModelsInObjectListForm() {
    // PathModel pathModel=
    String total = ' List<PathModel> pathModels = [\n';

    pathModels.forEach((p) {
      String data = '''
      PathModel.withoutPoints(
          paint: Paint()..color= ${p.paint.color},
          stroke: ${p.stroke},
          open: ${p.open},
          pathName: "${p.pathName}",
          pathNo: ${p.pathNo}),\n
''';
      total += data;
    });
    return total + "\n];";
  }