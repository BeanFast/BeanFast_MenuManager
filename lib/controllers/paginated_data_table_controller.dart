import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class PaginatedDataTableController<T> extends GetxController {
  RxList<DataRow> rows = <DataRow>[].obs;
  List<T> dataList = [];
  var currentPage = 1.obs;
  var rowsPerPage = PaginatedDataTable.defaultRowsPerPage.obs;
  Rx<int?> sortColumnIndex = Rx<int?>(null);
  Rx<bool> sortAscending = true.obs;

  // Future<void> refreshData() async {
  //   await fetchData();
  //   // await fetchData(currentPage.value, rowsPerPage.value);
  //   setDataTable(dataList);
  // }

  // Future<void> changePage(int page) async {
  //   // Cập nhật trang hiện tại
  //   currentPage.value = page;
  //   // Load data for the new page
  //   await fetchData();
  // }

  Future<void> changeRowsPerPage(int rows) async {
    // Cập nhật số hàng trên mỗi trang
    rowsPerPage.value = rows;
    // Load data for the new page with updated rowsPerPage
    // await fetchData();
  }

  // void sort<T>(
  //   Comparable<T> Function(T) getField,
  //   int columnIndex,
  //   bool ascending,
  // ) {
  //   dessertsDataSource.sort<T>(getField, ascending);

  //   sortColumnIndex = columnIndex;
  //   sortAscending = ascending;
  // }

  Future fetchData();
  void setDataTable(List<T> list);
}
