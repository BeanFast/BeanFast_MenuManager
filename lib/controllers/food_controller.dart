// import 'package:beanfast_menumanager/views/pages/error_page.dart';
// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '/utils/format_data.dart';
import '/utils/logger.dart';
import '/models/food.dart';
import '/models/category.dart';
import '/controllers/data_table_controller.dart';
import '/views/pages/food_page.dart';
import '/services/food_service.dart';
import '/services/category_service.dart';

class FoodController extends DataTableController<Food> {
  final GlobalKey<FormState> formCreateKey = GlobalKey<FormState>();
  RxString imagePath = ''.obs;
  final TextEditingController foodName = TextEditingController();
  final TextEditingController foodPrice = TextEditingController();
  Rx<Category?> foodCategory = Rx<Category?>(null);
  RxList<Category> listCategories = <Category>[].obs;
  RxList<String> messageErrors = <String>[].obs;

  @override
  void search(String value) {
    if (value.isEmpty) {
      setDataTable(initModelList);
    } else {
      currentModelList = initModelList
          .where((e) =>
              e.code!.toLowerCase().contains(value.toLowerCase()) ||
              e.name!.toLowerCase().contains(value.toLowerCase()))
          .toList();
      setDataTable(currentModelList);
    }
  }

  @override
  Future getData(list) async {
    isError.value = false;
    try {
      var data = await FoodService().getAll();
      for (var e in data['data']) {
        initModelList.add(Food.fromJson(e));
      }
    } catch (e) {
      isError.value = true;
      logger.e('FoodController: $e');
    }
  }

  @override
  Future loadPage(int page) {
    // TODO: implement loadPage
    throw UnimplementedError();
  }

  @override
  void setDataTable(List<Food> list) {
    rows.value = list.map((dataMap) {
      return const FoodView().setRow(list.indexOf(dataMap), dataMap);
    }).toList();
  }

  void sortByName(int index) {
    columnIndex.value = index;
    columnAscending.value = !columnAscending.value;
    currentModelList.sort((a, b) => a.name!.compareTo(b.name!));
    if (!columnAscending.value) currentModelList = currentModelList.reversed.toList();
    setDataTable(currentModelList);
  }

  void sortByPrice(int index) {
    columnIndex.value = index;
    columnAscending.value = !columnAscending.value;
    currentModelList.sort((a, b) => a.price!.compareTo(b.price!));
    if (!columnAscending.value) currentModelList = currentModelList.reversed.toList();
    setDataTable(currentModelList);
  }

  Future getByCode(String code) async {
    try {
      var value = initModelList.firstWhereOrNull((e) => e.code == code);
      if (value == null) return model.value = null;
      var data = await FoodService().getById(value.id!);
      return model.value = Food.fromJson(data);
    } catch (e) {
      logger.e('FoodController: $e');
    }
  }

  Future<void> initDialog() async {
    imagePath.value = '';
    foodName.text = '';
    foodPrice.text = '';

    try {
      var data = await CategoryService().getAll();
      for (var e in data) {
        listCategories.add(Category.fromJson(e));
      }
    } catch (e) {
      logger.e('FoodController: $e');
    }
    foodCategory.value = listCategories[0];
  }

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      imagePath.value = pickedFile.path;
    }
  }

  void submitForm() {
    messageErrors.value = [];
    if (formCreateKey.currentState!.validate() &&
        imagePath.value.isNotEmpty &&
        foodCategory.value != null) {
      Food food = Food(
          name: foodName.text,
          price: Formatter.formatPriceToDouble(foodPrice.text),
          categoryId: foodCategory.value!.id,
          imagePath: imagePath.value);
      model.value = food;
      logger.i(foodCategory.value!.id);
      logger.i(model);
      Get.back();
      return;
    }
    if (imagePath.value.isEmpty) messageErrors.add('Ảnh trống');
  }
}
