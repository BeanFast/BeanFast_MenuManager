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
  RxBool isError = false.obs;

  Future<void> refreshData() async {
    initModelList.clear();
    await getData(initModelList);
    currentModelList = initModelList;
    setDataTable(initModelList);
  }

  @override
  Future<void> onInit() async {
    super.onInit();
    await getData(initModelList);
    currentModelList = initModelList;
    setDataTable(initModelList);
  }

  Future getData(List<T> list);
  void setDataTable(List<T> list);
  void search(String value);
  Future loadPage(int page);
}
