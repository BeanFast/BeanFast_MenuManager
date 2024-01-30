import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '/models/food.dart';
import '/services/init_data.dart';
import '/views/pages/widget/food_row_data_table.dart';

class FoodController extends GetxController {
  TextEditingController searchController = TextEditingController();
  List<Food> initData = <Food>[];
  List<Food> dataList = <Food>[];
  RxList<DataRow> rows = <DataRow>[].obs;
  Rx<String> searchString = ''.obs;
  RxString imagePath = ''.obs;

  Rx<int> columnIndex = 0.obs;
  Rx<bool> columnAscending = true.obs;

  void searchName() {
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

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      imagePath.value = pickedFile.path;
    }
  }

  @override
  void onInit() {
    super.onInit();
    getData(initData); // init data
    dataList = initData;
    setDataTable(initData); // init data table
  }

  void getData(List<Food> list) async {
    // final apiDataList = await Api().getData();
    for (var e in apiDataFoodList) {
      list.add(Food.fromJson(e));
    }
  }

  void setDataTable(List<Food> list) {
    rows.value = list.map((dataMap) {
      return FoodDataRow(index: list.indexOf(dataMap), food: dataMap).getRow();
    }).toList();
  }
}