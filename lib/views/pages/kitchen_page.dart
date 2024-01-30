import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/utils/logger.dart';
import '/controllers/kitchen_controller.dart';
import '/views/dialog/create_kitchen_dialog.dart';
import '/views/pages/widget/data_table_page.dart';

class KitchenView extends StatelessWidget {
  KitchenView({super.key});
  final KitchenController _kitchenController = Get.find();

  @override
  Widget build(BuildContext context) {
    logger.i('build KitchenView');
    return Obx(
      () => DataTableView(
        title: 'Quản lý bếp',
        showCreateDialog: showCreateKitchenDialog,
        refreshData: _kitchenController.refreshData,
        search: (value) {
          _kitchenController.searchString.value = value;
          _kitchenController.searchName();
        },
        sortColumnIndex: _kitchenController.columnIndex.value,
        sortAscending: _kitchenController.columnAscending.value,
        columns: <DataColumn>[
          const DataColumn(
            label: Text('Stt'),
          ),
          const DataColumn(
            label: Text('Code'),
          ),
          const DataColumn(label: Text('Hình ảnh')),
          DataColumn(
              label: const Text('Tên trường'),
              onSort: (index, ascending) =>
                  _kitchenController.sortByName(index)),
          const DataColumn(
            label: Text('Địa chỉ'),
          ),
          const DataColumn(
            label: Text('Trường phụ trách'),
          ),
          const DataColumn(
            label: Text('Số trường'),
          ),
          const DataColumn(label: Text('Trạng thái')),
          const DataColumn(label: Text(' ')),
        ],
        // ignore: invalid_use_of_protected_member
        rows: _kitchenController.rows.value,
      ),
    );
  }
}
