import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/utils/logger.dart';
// import '/views/dialog/create_menu_dialog.dart';
import '/views/pages/widget/data_table_page.dart';
import '/controllers/menu_controller.dart' as controller;

class MenuView extends StatelessWidget {
  MenuView({super.key});
  final controller.MenuController _menuController = Get.find();

  @override
  Widget build(BuildContext context) {
    logger.i('build MenuView');
    return Obx(
      () => DataTableView(
        title: 'Quản lý bếp',
        showCreateDialog: () => Get.toNamed('/menu-create'),
        refreshData: _menuController.refreshData,
        search: (value) {
          _menuController.searchString.value = value;
          _menuController.searchName();
        },
        sortColumnIndex: _menuController.columnIndex.value,
        sortAscending: _menuController.columnAscending.value,
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
                  _menuController.sortByCreateDate(index)),
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
        rows: _menuController.rows.value,
      ),
    );
  }
}
