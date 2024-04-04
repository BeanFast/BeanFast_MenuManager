import 'package:flutter/material.dart' hide MenuController;
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../dialog/delete_dialog.dart';
import '/models/menu.dart';
import '/controllers/menu_controller.dart';
import '/views/pages/widget/button_data_table.dart';
import '/views/pages/widget/text_data_table_widget.dart';
import '/views/pages/widget/data_table_page.dart';

class MenuView extends GetView<MenuController> {
  const MenuView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => DataTableView(
        title: 'Quản thực đơn',
        isShowCreateDialog: true,
        showCreateDialog: () => Get.toNamed('/menu-create'),
        refreshData: controller.refreshData,
        loadPage: (page) => controller.loadPage(page),
        search: (value) => controller.search(value),
        sortColumnIndex: controller.columnIndex.value,
        sortAscending: controller.columnAscending.value,
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
              onSort: (index, ascending) => controller.sortByCreateDate(index)),
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
        rows: controller.rows.value,
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
        DataCell(
            Text(menu.schools == null ? '0' : menu.schools!.length.toString())),
        DataCell(Text(menu.status.toString())),
        DataCell(Row(
          children: [
            const Spacer(),
            DetailButtonDataTable(
                onPressed: () => Get.toNamed('/menu-detail?code=123')),
            EditButtonDataTable(onPressed: () {}),
            DeleteButtonDataTable(
                onPressed:  DeleteDialog(onPressed: () {}).showDialogMenu()),
          ],
        )),
      ],
    );
  }
}
