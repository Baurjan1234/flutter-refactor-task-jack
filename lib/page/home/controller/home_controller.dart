import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:refactor_task/model/item_model.dart';

class HomeController extends GetxService {
  late Box dataBox;
  final switchValue = false.obs;
  final dataValue = <ItemModel>[].obs;

  final _itemsController = StreamController<List<ItemModel>>.broadcast();
  Stream<List<ItemModel>> get itemsStream => _itemsController.stream;

  Future<void> fetchItemsFromDatabase() async {
    // print(dataBox.get("list_data"));
    final items = (await dataBox.get("list_data") ?? []) as List;
    dataValue.value = items.map((item) => ItemModel.fromJson(item)).toList();
    _itemsController.add(dataValue);
  }

  Future<void> fetchAndStoreItems() async {
    // await dataBox.delete('list_data');
    // return;
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body) as List;
      final itemList = data
          .map((item) => ItemModel.fromJson(item as Map<String, dynamic>))
          .toList();
      // itemList.forEach((item) {
      //   batch.insert('items', item.toJson(), conflictAlgorithm: ConflictAlgorithm.replace);
      // });

      await dataBox.put("list_data", data);

      _itemsController.add(itemList);
    } else {
      _itemsController.addError('Failed to fetch data from API');
    }
  }

  Future<void> liked(int index) async {
    dataValue[index] = ItemModel(
      id: dataValue[index].id,
      userId: dataValue[index].userId,
      like: !dataValue[index].like,
      body: dataValue[index].body,
      title: dataValue[index].title,
    );
    _itemsController.add(dataValue);
  }

  @override
  void onInit() async {
    super.onInit();
    dataBox = await Hive.openBox('data_box');
    fetchItemsFromDatabase();
  }

  @override
  void onClose() {
    super.onClose();
    _itemsController.close();
  }
}
