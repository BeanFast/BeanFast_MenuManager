import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/views/pages/widget/button_data_table.dart';
import '/utils/data_table.dart';

class PaginatedDataTableView extends StatelessWidget {
  final int sortColumnIndex;
  final bool sortAscending;
  final List<DataColumn> columns;
  final List<DataRow> rows;
  final void Function(String value) search;
  final void Function() refreshData;
  final void Function(int page) loadPage;
  final Widget? header;

  const PaginatedDataTableView({
    super.key,
    required this.sortColumnIndex,
    required this.sortAscending,
    required this.columns,
    required this.rows,
    required this.search,
    required this.refreshData,
    required this.loadPage,
    this.header,
  });

  @override
  Widget build(BuildContext context) {
    return PaginatedDataTable(
      sortColumnIndex: sortColumnIndex,
      sortAscending: sortAscending,
      rowsPerPage: 10,
      columnSpacing: 10,
      header: SizedBox(
        height: 40,
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: TextField(
                onChanged: (value) => search(value),
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.only(left: 10, right: 10),
                  labelText: 'Tìm kiếm',
                ),
                style: Get.theme.textTheme.bodyMedium,
              ),
            ),
            const Spacer(flex: 3),
            header == null ? const Spacer() : header!,
            SizedBox(
              // height: 60,
              width: 60,
              child: DropdownButtonFormField<String>(
                
                padding: const EdgeInsets.all(9),
                style: const TextStyle(fontSize: 13),
                decoration: const InputDecoration(
                  suffixIcon: Icon(Icons.keyboard_arrow_down),
                ),
                // backgroundColor: Colors.green,
                value: [
                  'Loại 1',
                  'Loại 2',
                  'Loại 3',
                  'Loại 4',
                  'Loại 5',
                ].first,
                // style: TextStyle(fontSize: 16),
                items: <String>[
                  'Loại 1',
                  'Loại 2',
                  'Loại 3',
                  'Loại 4',
                  'Loại 5',
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value,  style:  Get.textTheme.bodySmall),
                  );
                }).toList(),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui Lòng chọn loại';
                  }
                  return null;
                },
                onChanged: (String? newValue) {},
              ),
            ),
            RefreshButtonDataTable(onPressed: refreshData)
          ],
        ),
      ),
      onPageChanged: (page) => loadPage(page),
      columns: columns,
      source: MyDataTable(rows: rows),
    );
  }
}
