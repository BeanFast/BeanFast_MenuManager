import 'package:beanfast_menumanager/utils/logger.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '/models/kitchen.dart';
import '/services/init_data.dart';
import '/views/pages/widget/kitchen_row_data_table.dart';

class KitchenController extends GetxController {
  TextEditingController searchController = TextEditingController();
  List<Kitchen> initData = <Kitchen>[];
  List<Kitchen> dataList = <Kitchen>[];
  RxList<DataRow> rows = <DataRow>[].obs;
  Rx<String> searchString = ''.obs;
  RxString imagePath = ''.obs;

  Rx<String> a = 'a'.obs;

  Rx<int> columnIndex = 0.obs;
  Rx<bool> columnAscending = true.obs;

  void searchName() {
    logger.i('message');
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
    initData.clear();
    getData(initData); // init data
    dataList = initData;
    setDataTable(initData); // init data table
  }

  void getData(List<Kitchen> list) async {
    // final apiDataList = await Api().getData();
    logger.i('kitchen getData');
    for (var e in apiDataKitchenList) {
      list.add(Kitchen.fromJson(e));
    }
  }

  void setDataTable(List<Kitchen> list) {
    rows.value = list.map((dataMap) {
      return KitchenDataRow(index: list.indexOf(dataMap), kitchen: dataMap).getRow();
    }).toList();
  }
}