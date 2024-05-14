import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/controllers/paginated_data_table_controller.dart';
import '/views/pages/widget/button_data_table.dart';
import '/utils/data_table.dart';

class PaginatedDataTableView<T extends PaginatedDataTableController>
    extends StatelessWidget {
  final List<DataColumn> columns;

  const PaginatedDataTableView({
    super.key,
    required this.columns,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<T>(builder: (controller) {
      return Obx(
        () => PaginatedDataTable2(
          header: Row(
            children: [
              const Spacer(),
              RefreshButtonDataTable(onPressed: () async {
                await controller.fetchData();
              }),
            ],
          ),
          sortColumnIndex: controller.sortColumnIndex.value,
          sortAscending: controller.sortAscending.value,
          availableRowsPerPage: const [2, 5, 10, 30, 100],
          columnSpacing: 0,
          rowsPerPage: controller.rowsPerPage.value,
          onRowsPerPageChanged: (value) {
            controller.changeRowsPerPage(value!);
          },
          columns: columns,
          // ignore: invalid_use_of_protected_member
          source: MyDataTableSource(rows: controller.rows.value),
        ),
      );
    });
  }
}
