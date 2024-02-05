import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '/utils/logger.dart';
import '/models/food.dart';
import '/services/init_data.dart';
import '/views/pages/food_page.dart';

class FoodController extends GetxController {
  TextEditingController searchController = TextEditingController();
  List<Food> initData = <Food>[];
  List<Food> dataList = <Food>[];
  RxList<DataRow> rows = <DataRow>[].obs;
  Rx<String> searchString = ''.obs;
  RxString imagePath = ''.obs;

  Rx<int> columnIndex = 0.obs;
  Rx<bool> columnAscending = true.obs;

  String currentCode = '';

  void search() {
    if (searchString.value == '') {
      setDataTable(initData);
    } else {
      dataList = initData
          .where((e) =>
              e.name!.toLowerCase().contains(searchString.value.toLowerCase()))
          .toList();
      setDataTable(dataList);
    }
  }

  void sortByName(int index) {
    columnIndex.value = index;
    columnAscending.value = !columnAscending.value;
    dataList.sort((a, b) => a.name!.compareTo(b.name!));
    if (!columnAscending.value) {
      dataList = dataList.reversed.toList();
    }
    setDataTable(dataList);
  }

  void sortByPrice(int index) {
    columnIndex.value = index;
    columnAscending.value = !columnAscending.value;
    dataList.sort((a, b) => a.price!.compareTo(b.price!));
    if (!columnAscending.value) {
      dataList = dataList.reversed.toList();
    }
    setDataTable(dataList);
  }

  Food getByCode(String code){
    return initData.firstWhere((e) => e.code == currentCode);
  }

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      imagePath.value = pickedFile.path;
    }
  }

  void refreshData() {
    initData.clear();
    getData(initData);
    dataList = initData;
    setDataTable(initData);
  }

  @override
  void onInit() {
    super.onInit();
    logger.i('onInit');
    initData.clear;
    getData(initData); // init data
    dataList = initData;
    setDataTable(initData); // init data table
  }

  void getData(List<Food> list) async {
    logger.i('food getData');
    // final apiDataList = await Api().getData();
    for (var e in apiDataFoodList) {
      list.add(Food.fromJson(e));
    }
  }

  void setDataTable(List<Food> list) {
    logger.i('setDataTable');
    rows.value = list.map((dataMap) {
      return const FoodView().setRow(list.indexOf(dataMap), dataMap);
    }).toList();
  }
}