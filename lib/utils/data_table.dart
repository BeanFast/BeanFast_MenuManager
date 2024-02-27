import 'package:flutter/material.dart';

class MyDataTable extends DataTableSource {
  final List<DataRow> rows;

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