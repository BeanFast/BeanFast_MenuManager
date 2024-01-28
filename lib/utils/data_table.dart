import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyDataTable extends DataTableSource {
  final RxList<DataRow> rows;

  MyDataTable({required this.rows});

  @override
  DataRow? getRow(int index) {
    if (index >= rows.length) return null;
    return rows[index];
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => rows.length;

  @override
  int get selectedRowCount => 0;
}
