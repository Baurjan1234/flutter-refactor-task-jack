import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../model/item_model.dart';
import '../controller/home_controller.dart';

class CardWidget extends StatelessWidget {
  CardWidget({
    super.key,
    required this.item,
  });

  final ItemModel item;
  final cont = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.dialog(AlertDialog(
          title: Row(
            children: [
              Expanded(
                child: Text(
                  item.title ?? '',
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              IconButton(
                onPressed: () {
                  cont.liked(item.id - 1);
                  Get.back();
                },
                icon: Icon(item.like ? Icons.favorite : Icons.favorite_border),
              ),
            ],
          ),
          content: Text(
            item.body ?? "",
            // style: Get.textTheme.titleLarge,
          ),
        ));
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 8.0,
        ),
        margin: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 4,
        ),
        decoration: BoxDecoration(
          color: Get.theme.colorScheme.primaryContainer,
          // Colors.white,
          borderRadius: BorderRadius.circular(20.0),
          boxShadow: [
            BoxShadow(
              color: Get.theme.colorScheme.primaryContainer.withOpacity(.5),
              blurRadius: 6.0,
              spreadRadius: 2.0,
              offset: const Offset(0.0, 0.0),
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    "${item.id}. ${item.title ?? ''}",
                    style: Get.textTheme.titleMedium,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
                Icon(item.like ? Icons.favorite : Icons.favorite_border,
                    size: 14)
              ],
            ),
            Text(item.body ?? '', maxLines: 1),
          ],
        ),
      ),
    );
  }
}
