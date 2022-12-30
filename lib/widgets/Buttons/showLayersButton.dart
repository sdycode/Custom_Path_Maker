import 'package:custom_path_maker/constants/consts.dart';
import 'package:custom_path_maker/providers/edit_option_provider.dart';
import 'package:custom_path_maker/providers/path_screen_provider.dart';
import 'package:custom_path_maker/screens/path_drawing_screen.dart';
import 'package:custom_path_maker/widgets%20data/textStyles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ShowLayersWidgetButton extends StatelessWidget {
  const ShowLayersWidgetButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PathScreenProvider p =
        Provider.of<PathScreenProvider>(context, listen: false);
    EditOptionProvider editProvider = Provider.of<EditOptionProvider>(
      context,
    );
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: () {
            showLayersList = !showLayersList;
            p.updateUI();
            editProvider.updateUI();
          },
          child: Container(
              width: editOptionW * 0.92,
              height: 30,
              decoration: BoxDecoration(
                  border: Border.all(
                      color: Color.fromARGB(255, 148, 146, 146), width: 0.5),
                  borderRadius: BorderRadius.circular(20)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    "Paths",
                    style: textFieldStyle.copyWith(fontSize: 14),
                  ),
                  Icon(
                    !showLayersList
                        ? Icons.check_circle_outline
                        : Icons.check_circle,
                    color: Colors.white,
                  )
                ],
              )),
        ));
  }
}
