import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../home/controller/home_controller.dart';

class LikedScreen extends StatelessWidget {
  LikedScreen({super.key});
  final cont = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Liked screen"),
      ),
      body: ListView.builder(
          itemCount: cont.dataValue.length,
          itemBuilder: (context, index) {
            if (cont.dataValue[index].like) {
              return ListTile(
                title: Text(
                  "${index + 1}. ${cont.dataValue[index].title ?? ""}",
                  maxLines: 1,
                ),
              );
            } else {
              return const SizedBox();
            }
          }),
    );
  }
}
