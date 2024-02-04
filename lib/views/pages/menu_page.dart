import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '/utils/logger.dart';
import '/models/menu.dart';
import '/controllers/menu_controller.dart' as controller;
import '/views/pages/widget/button_data_table.dart';
import '/views/pages/widget/text_data_table_widget.dart';
import '/views/pages/widget/data_table_page.dart';

class MenuView extends StatelessWidget {
  const MenuView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller.MenuController menuController = Get.find();
    logger.i('build MenuView');
    return Obx(
      () => DataTableView(
        title: 'Quản lý bếp',
        isShowCreateDialog: true,
        showCreateDialog: () => Get.toNamed('/menu-create'),
        refreshData: menuController.refreshData,
        search: (value) {
          menuController.searchString.value = value;
          menuController.search();
        },
        sortColumnIndex: menuController.columnIndex.value,
        sortAscending: menuController.columnAscending.value,
        columns: <DataColumn>[
          const DataColumn(
            label: Text('Stt'),
          ),
          const DataColumn(
            label: Text('Code'),
          ),
          const DataColumn(label: Text('Bếp')),
          DataColumn(
              label: const Text('Ngày tạo'),
              onSort: (index, ascending) =>
                  menuController.sortByCreateDate(index)),
          const DataColumn(
            label: Text('Ngày cập nhật'),
          ),
          const DataColumn(
            label: Text('Số sản phẩm'),
          ),
          const DataColumn(label: Text('Trạng thái')),
          const DataColumn(label: Text(' ')),
        ],
        // ignore: invalid_use_of_protected_member
        rows: menuController.rows.value,
      ),
    );
  }

  DataRow setRow(int index, Menu menu) {
    return DataRow(
      cells: [
        DataCell(Text((index + 1).toString())),
        DataCell(
          TextDataTable(
            data: menu.code.toString(),
            maxLines: 2,
            width: 100,
          ),
        ),
        DataCell(
          TextDataTable(
            data: menu.kitchenId.toString(),
            maxLines: 2,
            width: 200,
          ),
        ),
        DataCell(Text(DateFormat('dd-MM-yyyy').format(menu.createDate!))),
        DataCell(Text(DateFormat('dd-MM-yyyy').format(menu.updateDate!))),
        DataCell(Text(
            menu.schoolIds == null ? '0' : menu.schoolIds!.length.toString())),
        DataCell(Text(menu.status.toString())),
        DataCell(Row(
          children: [
            const Spacer(),
            DetailButtonDataTable(
                goToPage: () =>
                    Get.toNamed('/menu-detail?code=123')),
            EditButtonDataTable(showDialog: () {}),
            DeleteButtonDataTable(agree: () {}),
          ],
        )),
      ],
    );
  }
}
