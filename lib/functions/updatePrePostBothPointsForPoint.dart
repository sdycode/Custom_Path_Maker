
import 'package:custom_path_maker/constants/global.dart';

import 'updatePrePostPointForSymmetry.dart';

updatePrePostBothPointsForPoint(int i) {
  int preI = i > 0 ? i - 1 : points.length - 1;
  int postI = (i + 1) % points.length;
  updatePrePostPointForSymmetry(true, i);
  updatePrePostPointForSymmetry(false, preI);
  updatePrePostPointForSymmetry(true, postI);
}
