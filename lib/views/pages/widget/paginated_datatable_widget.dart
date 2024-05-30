import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/controllers/paginated_data_table_controller.dart';
import '/views/pages/widget/button_data_table.dart';
import '/utils/data_table.dart';

class PaginatedDataTableView<T extends PaginatedDataTableController>
    extends StatelessWidget {
  final List<DataColumn> columns;
  final String title;

  const PaginatedDataTableView({
    super.key,
    required this.title,
    required this.columns,
  });

  @override
  Widget build(BuildContext context) {
    bool disableRefreshButton = false;
    return GetBuilder<T>(builder: (controller) {
      return Obx(
        () => PaginatedDataTable2(
          header: Row(
            children: [
              Text(title, style: Get.textTheme.titleLarge),
              const Spacer(),
              RefreshButtonDataTable(
                  disable: disableRefreshButton,
                  onPressed: () async {
                    try {
                      disableRefreshButton = true;
                      await controller.fetchData();
                    } finally {
                      disableRefreshButton = false;
                    }
                  }),
            ],
          ),
          sortColumnIndex: controller.sortColumnIndex.value,
          sortAscending: controller.sortAscending.value,
          availableRowsPerPage: const [2, 5, 10, 30, 100],
          columnSpacing: 10,
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
