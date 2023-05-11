import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:refactor_task/theme/theme.dart';

import '../../../model/item_model.dart';
import '../../screen/liked_screen.dart';
import '../controller/home_controller.dart';
import '../widget/card_widget.dart';

class MyHomePage extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          title: const Text('Refactor Task App '),
          actions: [
            IconButton(
              onPressed: () => Get.to(LikedScreen()),
              icon: const Icon(Icons.favorite),
            ),
            Switch(
              value: controller.switchValue.value,
              onChanged: (bool value) {
                Get.changeTheme(Get.isDarkMode
                    ? TaskThemes.themeLigth
                    : TaskThemes.themeDark);
                Get.changeThemeMode(
                    Get.isDarkMode ? ThemeMode.light : ThemeMode.dark);

                controller.switchValue.value = value;
              },
            ),
          ],
        ),
        body: StreamBuilder<List<ItemModel>>(
          stream: controller.itemsStream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data?.length ?? 0,
                itemBuilder: (context, index) {
                  final item = snapshot.data![index];
                  return CardWidget(item: item);
                },
              );
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: controller.fetchAndStoreItems,
          tooltip: 'Fetch Data',
          child: const Icon(Icons.refresh),
        ),
      ),
    );
  }
}
