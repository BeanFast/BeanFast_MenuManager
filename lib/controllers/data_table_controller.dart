import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class DataTableController<T> extends GetxController {
  TextEditingController searchController = TextEditingController();
  List<T> initData = <T>[];
  List<T> dataList = <T>[];
  Rx<int> rowSize = 10.obs;
  RxList<DataRow> rows = <DataRow>[].obs;
  Rx<String> searchString = ''.obs;
  RxString imagePath = ''.obs;
  Rx<int> columnIndex = 0.obs;
  Rx<bool> columnAscending = true.obs;

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

  void getData(List<T> list);
  void setDataTable(List<T> list);
  void search();
}