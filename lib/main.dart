import 'package:custom_path_maker/constants/consts.dart';
import 'package:custom_path_maker/functions/reinitalisegloablfields.dart';
import 'package:custom_path_maker/providers/gradprovider.dart';
import 'package:custom_path_maker/providers/path_screen_provider.dart';
import 'package:custom_path_maker/screens/path_drawing_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/edit_option_provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => PathScreenProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => GradProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => EditOptionProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Custom Path Maker',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Builder(builder: (context) {
          reInitiaiseGlobalFields(context);
          return const PathDrawingScreen();
        }),
      ),
    );
  }
}
