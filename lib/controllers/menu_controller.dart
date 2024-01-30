import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '/models/menu.dart';
import '/services/init_data.dart';
import '/views/pages/widget/menu_row_data_table.dart';
import '/utils/logger.dart';

class MenuController extends GetxController {
  TextEditingController searchController = TextEditingController();
  List<Menu> initData = <Menu>[];
  List<Menu> dataList = <Menu>[];
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
              e.code!.toLowerCase().contains(searchString.value.toLowerCase()))
          .toList();
      setDataTable(dataList);
    }
  }

  void sortByCreateDate(int index) {
    columnIndex.value = index;
    columnAscending.value = !columnAscending.value;
    dataList.sort((a, b) => a.createDate!.compareTo(b.createDate!));
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
    getData(initData); // init data
    dataList = initData;
    setDataTable(initData); // init data table
  }

  void getData(List<Menu> list) async {
    logger.i('menu getData');
    // final apiDataList = await Api().getData();
    for (var e in apiDataMenuList) {
      list.add(Menu.fromJson(e));
    }
  }

  void setDataTable(List<Menu> list) {
    rows.value = list.map((dataMap) {
      return MenuDataRow(index: list.indexOf(dataMap), menu: dataMap).getRow();
    }).toList();
  }
}