import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class DataTableController<T> extends GetxController {
  TextEditingController searchController = TextEditingController();
  List<T> initModelList = <T>[];
  List<T> currentModelList = <T>[];
  Rx<int> rowSize = 10.obs;
  RxList<DataRow> rows = <DataRow>[].obs;
  Rx<int> columnIndex = 0.obs;
  Rx<bool> columnAscending = true.obs;
  Rx<T?> model = Rx<T?>(null);
  RxString message = ''.obs;

  Future<void> refreshData() async {
    message.value = '';
    initModelList.clear();
    await getData(initModelList);
    currentModelList.clear();
    currentModelList.addAll(initModelList);
    setDataTable(initModelList);
  }

  Future getData(List<T> list);
  void setDataTable(List<T> list);
  void search(String value);
  Future loadPage(int page);
}
