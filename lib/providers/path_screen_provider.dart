import 'package:custom_path_maker/constants/global.dart';
import 'package:flutter/foundation.dart';

class PathScreenProvider with ChangeNotifier {
  updateUI() {
    notifyListeners();
    pathModels[pathModelIndex].points = List.from(points);
  }
}
