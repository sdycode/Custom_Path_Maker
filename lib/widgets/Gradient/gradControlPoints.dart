import 'package:custom_path_maker/constants/colors.dart';
import 'package:custom_path_maker/constants/global.dart';
import 'package:custom_path_maker/providers/path_screen_provider.dart';
import 'package:custom_path_maker/screens/path_drawing_screen.dart';
import 'package:custom_path_maker/widgets/bottomBar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LinearGradControlPoints extends StatelessWidget {
  const LinearGradControlPoints({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PathScreenProvider provider =
        Provider.of<PathScreenProvider>(context, listen: false);

    return Stack(
      children: [
        Positioned(
            top: pathModels[pathModelIndex].linearFrom.dy -
                gradientControlPointRad +
                drawingBoardTopOffset +
                pathModels[pathModelIndex].offsetFromOrigin.dy,
            left: pathModels[pathModelIndex].linearFrom.dx -
                gradientControlPointRad +
                drawingBoardLeftOffset +
                pathModels[pathModelIndex].offsetFromOrigin.dx,
            child: CircleControlPoint(
                fillColor: radiusSliderColor,
                onPanUpdate: (DragUpdateDetails d) {
                  pathModels[pathModelIndex].linearFrom = Offset(
                      pathModels[pathModelIndex].linearFrom.dx + d.delta.dx,
                      pathModels[pathModelIndex].linearFrom.dy + d.delta.dy);
                  provider.updateUI();
                })),
        Positioned(
            top: pathModels[pathModelIndex].linearTo.dy -
                gradientControlPointRad +
                drawingBoardTopOffset +
                pathModels[pathModelIndex].offsetFromOrigin.dy,
            left: pathModels[pathModelIndex].linearTo.dx -
                gradientControlPointRad +
                drawingBoardLeftOffset +
                pathModels[pathModelIndex].offsetFromOrigin.dx,
            child: CircleControlPoint(
                fillColor: focalRadiusSliderColor,
                onPanUpdate: (DragUpdateDetails d) {
                  pathModels[pathModelIndex].linearTo = Offset(
                      pathModels[pathModelIndex].linearTo.dx + d.delta.dx,
                      pathModels[pathModelIndex].linearTo.dy + d.delta.dy);
                  provider.updateUI();
                })),
      ],
    );
  }
}

class RadialGradControlPoints extends StatelessWidget {
  const RadialGradControlPoints({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PathScreenProvider provider =
        Provider.of<PathScreenProvider>(context, listen: false);
    return Stack(
      children: [
        Positioned(
            top: pathModels[pathModelIndex].center.dy -
                gradientControlPointRad +
                drawingBoardTopOffset +
                pathModels[pathModelIndex].offsetFromOrigin.dy,
            left: pathModels[pathModelIndex].center.dx -
                gradientControlPointRad +
                drawingBoardLeftOffset +
                pathModels[pathModelIndex].offsetFromOrigin.dx,
            child: CircleControlPoint(
                fillColor: radiusSliderColor,
                onPanUpdate: (DragUpdateDetails d) {
                  pathModels[pathModelIndex].center = Offset(
                      pathModels[pathModelIndex].center.dx + d.delta.dx,
                      pathModels[pathModelIndex].center.dy + d.delta.dy);
                  provider.updateUI();
                })),
        Positioned(
            top: pathModels[pathModelIndex].focalCenter.dy -
                gradientControlPointRad +
                drawingBoardTopOffset +
                pathModels[pathModelIndex].offsetFromOrigin.dy,
            left: pathModels[pathModelIndex].focalCenter.dx -
                gradientControlPointRad +
                drawingBoardLeftOffset +
                pathModels[pathModelIndex].offsetFromOrigin.dx,
            child: CircleControlPoint(
                fillColor: focalRadiusSliderColor,
                onPanUpdate: (DragUpdateDetails d) {
                  pathModels[pathModelIndex].focalCenter = Offset(
                      pathModels[pathModelIndex].focalCenter.dx + d.delta.dx,
                      pathModels[pathModelIndex].focalCenter.dy + d.delta.dy);
                  provider.updateUI();
                })),
      ],
    );
  }
}

class SweepGradControlPoint extends StatelessWidget {
  const SweepGradControlPoint({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PathScreenProvider provider =
        Provider.of<PathScreenProvider>(context, listen: false);
    return Stack(
      children: [
        Positioned(
            top: pathModels[pathModelIndex].center.dy -
                gradientControlPointRad +
                drawingBoardTopOffset +
                pathModels[pathModelIndex].offsetFromOrigin.dy,
            left: pathModels[pathModelIndex].center.dx -
                gradientControlPointRad +
                drawingBoardLeftOffset +
                pathModels[pathModelIndex].offsetFromOrigin.dx,
            child: CircleControlPoint(onPanUpdate: (DragUpdateDetails d) {
              pathModels[pathModelIndex].center = Offset(
                  pathModels[pathModelIndex].center.dx + d.delta.dx,
                  pathModels[pathModelIndex].center.dy + d.delta.dy);
              provider.updateUI();
            })),
      ],
    );
  }
}

final double gradientControlPointRad = 8;

class CircleControlPoint extends StatelessWidget {
  final Function onPanUpdate;
  final Color borderColor;
  final Color fillColor;
  const CircleControlPoint(
      {Key? key,
      required this.onPanUpdate,
      this.borderColor = Colors.white,
      this.fillColor = Colors.grey})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: (DragUpdateDetails d) {
        onPanUpdate(d);
      },
      child: CircleAvatar(
        radius: gradientControlPointRad,
        backgroundColor: borderColor,
        child: CircleAvatar(
          radius: gradientControlPointRad - 2,
          backgroundColor: fillColor,
        ),
      ),
    );
  }
}
