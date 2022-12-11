import 'package:custom_path_maker/models/PathModel.dart';

String getStringofAllCanvasFunctions(List<PathModel> pathModels) {
  String data = '';
  for (var i = 0; i < pathModels.length; i++) {
    String pointsName = "${pathModels[i].pathName}Points";
    data += '''
 
drawCanvasForPath${pathModels[i].pathName}(PathModel pathModel, Canvas canvas,List<CurvePoint> $pointsName){
  List<CurvePoint>pathPoints =$pointsName;
    bool stroke = pathModel.stroke;
    Paint paint = pathModel.paint..style=stroke?PaintingStyle.stroke:PaintingStyle.fill;
  
    bool open=pathModel.open;

  drawCanvasCommonFunction(pathPoints,paint,  stroke,  open,canvas );

}
''';
  }

  return data;
}
