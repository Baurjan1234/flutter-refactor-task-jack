import 'package:get/get.dart';

import 'home/controller/home_binding.dart';
import 'home/view/home_page.dart';

class TaskPages {
  static const initialRoute = '/';
  static List<GetPage<dynamic>> getAppPages = [
    GetPage(
      name: '/',
      page: () => MyHomePage(),
      binding: HomeBindings(),
    ),
  ];
}
