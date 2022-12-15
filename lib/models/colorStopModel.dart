
 
class ColorStopModel {
  double colorStop;
  String hexColorString;
  double left;
   ColorStopModel(this.colorStop, this.hexColorString, this.left);
  ColorStopModel.withStopValue(this.colorStop,
      [this.hexColorString = "ffffffff", this.left = 0]);
  factory ColorStopModel.copy(ColorStopModel model) {
    return ColorStopModel(model.colorStop, model.hexColorString, model.left);
  }
}