import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';

import 'page/home/controller/home_controller.dart';
import 'page/task_pages.dart';
import 'theme/theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final cont = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Task App',
      theme: TaskThemes.themeLigth,
      darkTheme: TaskThemes.themeDark,
      themeMode: ThemeMode.system,
      getPages: TaskPages.getAppPages,
      initialRoute: TaskPages.initialRoute,
      debugShowCheckedModeBanner: false,
    );
  }
}
