
  import 'package:custom_path_maker/functions/code/getStringOfCurvePOintsInListofObjectsFromInFunctionString.dart';
import 'package:custom_path_maker/models/PathModel.dart';

String getStringOfAllFunctionsOfCurvepointsList(List<PathModel> pathModels) {
    String allFunctionsString = '';
    for (var i = 0; i < pathModels.length; i++) {
      PathModel pathModel = pathModels[i];
      allFunctionsString +=
          getStringOfCurvePOintsInListofObjectsFromInFunctionString(pathModel);
    }

    return allFunctionsString;
  }