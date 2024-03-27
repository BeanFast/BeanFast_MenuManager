import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/views/pages/widget/paginated_data_table_widget.dart';
import '/views/pages/widget/button_data_table.dart';

// ignore: must_be_immutable
class DataTableView extends StatelessWidget {
  final String title;
  final int sortColumnIndex;
  final bool sortAscending;
  final List<DataColumn> columns;
  final List<DataRow> rows;
  bool isShowCreateDialog = false;
  final void Function(String value) search;
  final void Function() refreshData;
  final void Function(int page) loadPage;
  final void Function()? showCreateDialog;

  DataTableView({
    super.key,
    required this.title,
    required this.sortColumnIndex,
    required this.sortAscending,
    required this.columns,
    required this.rows,
    required this.search,
    required this.refreshData,
    required this.loadPage,
    required this.isShowCreateDialog,
    this.showCreateDialog,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40, left: 10, right: 10, bottom: 10),
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
                  if (isShowCreateDialog)
                    CreateButtonDataTable(showDialog: showCreateDialog!),
                ],
              ),
            ),
          ),
          PaginatedDataTableView(
            sortColumnIndex: sortColumnIndex,
            sortAscending: sortAscending,
            columns: columns,
            rows: rows,
            search: search,
            refreshData: refreshData,
            loadPage: loadPage,
          )
        ],
      ),
    );
  }
}
