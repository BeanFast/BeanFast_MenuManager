import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class DataTableController<T> extends GetxController {
  TextEditingController searchController = TextEditingController();
  List<T> initData = <T>[];
  Rx<int> rowSize = 10.obs;
  RxList<DataRow> rows = <DataRow>[].obs;
  Rx<int> columnIndex = 0.obs;
  Rx<bool> columnAscending = true.obs;
  Rx<T?> model = Rx<T?>(null);

  Future<void> refreshData() async {
    initData.clear();
    await getData();
    setDataTable(initData);
  }

  @override
  Future<void> onInit() async {
    super.onInit();
    await getData(); // init data
    setDataTable(initData); // init data table
  }

  Future getData();
  void setDataTable(List<T> list);
  void search(String value);
}
