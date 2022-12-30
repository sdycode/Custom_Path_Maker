import 'package:custom_path_maker/constants/consts.dart';
import 'package:custom_path_maker/providers/path_screen_provider.dart';
import 'package:custom_path_maker/widgets/radius_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

double zoomValue = 1.0;
Offset zoomPanOffset = Offset(0, 0);
bool isZoomPanEnabled = false;

class BottomBar extends StatelessWidget {
  const BottomBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PathScreenProvider p = Provider.of<PathScreenProvider>(context);
    return Container(
        width: w,
        height: bottombarH,
        color: Colors.amber.shade200,
        child: Row(
          children: [
    
              Container(
            margin: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: isZoomPanEnabled ? Border.all(color: Colors.blue) : null,
                color:
                    Color.fromARGB(isZoomPanEnabled ? 150 : 0, 156, 206, 247)),
            child: InkWell(
              onTap: () {
                   isZoomPanEnabled = !isZoomPanEnabled;
                  p.updateUI();
              },
              child: Image.asset("assets/icons/pan.png"),
            ),
          ),
            Container(
              width: w*0.3,
              child: Slider(
                activeColor:  Colors.red,
                inactiveColor: Colors.red.shade200,
                  value: zoomValue,
                  min: 1,
                  max: 10,
                  onChanged: (d) {
                    zoomValue = d;
                    p.updateUI();
                  }),
            )
          ],
        )
        // const  RadiusSlider(),
        );
  }
}
