import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/utils/logger.dart';
import '/views/pages/widget/button_data_table.dart';
import '/utils/data_table.dart';

class DataTableView extends StatelessWidget {
  final String title;
  final int sortColumnIndex;
  final bool sortAscending;
  final List<DataColumn> columns;
  final List<DataRow> rows;
  final void Function(String value) search;
  final void Function() refreshData;
  final void Function() showCreateDialog;

  const DataTableView(
      {super.key,
      required this.title,
      required this.sortColumnIndex,
      required this.sortAscending,
      required this.columns,
      required this.rows,
      required this.search,
      required this.refreshData,
      required this.showCreateDialog});

  @override
  Widget build(BuildContext context) {
    logger.i('build DataTableView');
    return Scaffold(
      body: Padding(
        padding:
            const EdgeInsets.only(top: 40, left: 10, right: 10, bottom: 10),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: SizedBox(
                height: 40,
                child: Row(
                  children: [
                    Text(
                      title,
                      style: Get.textTheme.headlineMedium,
                    ),
                    const Spacer(),
                    CreateButtonDataTable(showDialog: showCreateDialog),
                  ],
                ),
              ),
            ),
            PaginatedDataTable(
              sortColumnIndex: sortColumnIndex,
              sortAscending: sortAscending,
              rowsPerPage: 10,
              columnSpacing: 10,
              header: SizedBox(
                height: 40,
                child: Row(
                  children: [
                    SizedBox(
                      width: 400,
                      child: TextField(
                        onChanged: (value) => search(value),
                        decoration: const InputDecoration(
                          labelText: 'Tìm kiếm',
                        ),
                        style: Get.theme.textTheme.bodyMedium,
                      ),
                    ),
                    const Spacer(),
                    RefreshButtonDataTable(refreshData: refreshData)
                  ],
                ),
              ),
              columns: columns,
              source: MyDataTable(rows: rows),
            ),
          ],
        ),
      ),
    );
  }
}
