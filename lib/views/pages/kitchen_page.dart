import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/utils/logger.dart';
import '/models/kitchen.dart';
import '/controllers/kitchen_controller.dart';
import '/views/dialog/create_kitchen_dialog.dart';
import '/views/pages/widget/data_table_page.dart';
import '/views/pages/widget/button_data_table.dart';
import '/views/pages/widget/text_data_table_widget.dart';

class KitchenView extends StatelessWidget {
  const KitchenView({super.key});

  @override
  Widget build(BuildContext context) {
  final KitchenController kitchenController = Get.find();
    logger.i('build KitchenView');
    return Obx(
      () => DataTableView(
        title: 'Quản lý bếp',
        isShowCreateDialog: true,
        showCreateDialog: showCreateKitchenDialog,
        refreshData: kitchenController.refreshData,
        search: (value) {
          kitchenController.searchString.value = value;
          kitchenController.searchName();
        },
        sortColumnIndex: kitchenController.columnIndex.value,
        sortAscending: kitchenController.columnAscending.value,
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
                  kitchenController.sortByName(index)),
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
        rows: kitchenController.rows.value,
      ),
    );
  }

  DataRow setRow(int index, Kitchen kitchen) {
    return DataRow(
      cells: [
        DataCell(Text((index + 1).toString())),
        DataCell(
          TextDataTable(
            data: kitchen.code.toString(),
            maxLines: 2,
            width: 100,
          ),
        ),
        DataCell(
          SizedBox(
            // height: ,
            width: 100,
            child: Image.network(
              kitchen.imagePath.toString(),
              fit: BoxFit.fitWidth,
            ),
          ),
        ),
        DataCell(
          TextDataTable(
            data: kitchen.name.toString(),
            maxLines: 2,
            width: 200,
          ),
        ),
        DataCell(Text(kitchen.address.toString())),
        DataCell(Text(kitchen.address.toString())),
        DataCell(Text(kitchen.schools == null
            ? '0'
            : kitchen.schools!.length.toString())),
        DataCell(Text(kitchen.status.toString())),
        DataCell(Row(
          children: [
            const Spacer(),
            // DetailButtonDataTable(goToPage: Get.to(MenuManagementView())!),
            EditButtonDataTable(showDialog: () {}),
            DeleteButtonDataTable(agree: () {}),
          ],
        )),
      ],
    );
  }
}
