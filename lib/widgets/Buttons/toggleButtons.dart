import 'package:custom_path_maker/constants/consts.dart';
import 'package:custom_path_maker/constants/global.dart';
import 'package:custom_path_maker/enum/enums.dart';
import 'package:custom_path_maker/providers/edit_option_provider.dart';
import 'package:custom_path_maker/providers/path_screen_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ToggleButtonsWithNames extends StatelessWidget {
  final List<String> names;
  final selectedIndex;
  final Function onTap;
  const ToggleButtonsWithNames(
      {Key? key,
      required this.names,
      this.selectedIndex = 0,
      required this.onTap})
      : assert(names != null),
        assert(names.length > selectedIndex),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    PathScreenProvider p =
        Provider.of<PathScreenProvider>(context, listen: false);
    EditOptionProvider editProvider = Provider.of<EditOptionProvider>(
      context,
    );
    return Container(
        padding: EdgeInsets.all(4),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(28),
            color: Color.fromARGB(255, 62, 58, 58)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ...List.generate(
              names.length,
              (i) => ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: InkWell(
                  onTap: () {
                    onTap();
                
                    editProvider.updateUI();
                    p.updateUI();
                  },
                  child: Container(
                    height: 32,
                    // constraints: BoxConstraints(mi),
                    width: editOptionW * 0.5 - 16,
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: i == selectedIndex
                            ? Colors.black
                            : Color.fromARGB(255, 35, 33, 33)),
                    child: Center(
                      child: Text(
                        names[i],
                        style: TextStyle(
                            color: i == selectedIndex
                                ? Color.fromARGB(255, 242, 237, 237)
                                : Color.fromARGB(255, 170, 170, 170)),
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        )
        //  false ? Container() :

        );
  }
}
