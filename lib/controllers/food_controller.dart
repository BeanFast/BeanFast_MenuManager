import 'package:beanfast_menumanager/services/category_service.dart';
import 'package:beanfast_menumanager/views/pages/error_page.dart';
// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '/utils/logger.dart';
import '/models/food.dart';
import '/models/category.dart';
import '/controllers/data_table_controller.dart';
import '/views/pages/food_page.dart';
import '/services/food_service.dart';

class FoodController extends DataTableController<Food> {
  // String currentCode = '';
  //popup create/update
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  RxString imagePath = ''.obs;
  final TextEditingController foodName = TextEditingController();
  final TextEditingController foodPrice = TextEditingController();
  RxList<Category> listCategories = <Category>[].obs;

  @override
  void search(String value) {
    if (value.isEmpty) {
      setDataTable(initData);
    } else {
      var dataList = initData
          .where((e) =>
              e.code!.toLowerCase().contains(value.toLowerCase()) ||
              e.name!.toLowerCase().contains(value.toLowerCase()))
          .toList();
      setDataTable(dataList);
    }
  }

  void sortByName(int index) {
    columnIndex.value = index;
    columnAscending.value = !columnAscending.value;
    var dataList = initData;
    dataList.sort((a, b) => a.name!.compareTo(b.name!));
    if (!columnAscending.value) dataList = dataList.reversed.toList();
    setDataTable(dataList);
  }

  void sortByPrice(int index) {
    columnIndex.value = index;
    columnAscending.value = !columnAscending.value;
    var dataList = initData;
    dataList.sort((a, b) => a.price!.compareTo(b.price!));
    if (!columnAscending.value) dataList = dataList.reversed.toList();
    setDataTable(dataList);
  }

  @override
  void setDataTable(List<Food> list) {
    rows.value = list.map((dataMap) {
      return const FoodView().setRow(list.indexOf(dataMap), dataMap);
    }).toList();
  }

  @override
  Future getData() async {
    try {
      var data = await FoodService().getAll();
      for (var e in data) {
        initData.add(Food.fromJson(e));
      }
    } catch (e) {
      logger.e('FoodController: $e');
    }
  }

  Future getByCode(String code) async {
    try {
      var value = initData.firstWhereOrNull((e) => e.code == code);
      if (value == null) return model.value = null;
      var data = await FoodService().getById(value.id!);
      return model.value = Food.fromJson(data);
    } catch (e) {
      logger.e('FoodController: $e');
    }
  }

  Future<void> initDialog() async {
    imagePath.value = '';
    try {
      var data = await CategoryService().getAll();
      for (var e in data) {
        listCategories.add(Category.fromJson(e));
      }
    } catch (e) {
      logger.e('FoodController: $e');
    }
  }

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      imagePath.value = pickedFile.path;
    }
  }

  void submitForm() {
    print('object');
    // if (formKey.currentState!.validate()) {
    //   Food food = Food(
    //     name: foodName.text,
    //     price: double.parse(foodPrice.text),
    //     // Khởi tạo các thuộc tính khác từ form
    //   );

    //   model.value = food;
    //   Get.back(); // Đóng dialog
    // }
  }
}
