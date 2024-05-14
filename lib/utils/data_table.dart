import 'package:flutter/material.dart';

class MyDataTableSource extends DataTableSource {
  final List<DataRow> rows;

  MyDataTableSource({required this.rows});

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