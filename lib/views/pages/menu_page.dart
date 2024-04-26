import 'package:flutter/material.dart' hide MenuController;
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '/controllers/menu_create_update_controller.dart';
import '/views/pages/loading_page.dart';
import '/routes/app_routes.dart';
import '/controllers/menu_controller.dart';
import '/models/menu.dart';
import '/views/dialog/delete_dialog.dart';
import '/views/pages/widget/button_data_table.dart';
import '/views/pages/widget/data_table_page.dart';
import '/views/pages/widget/text_data_table_widget.dart';

class MenuView extends GetView<MenuController> {
  const MenuView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(MenuController());
    return LoadingView(
        future: controller.refreshData,
        child: Obx(
          () => DataTableView(
            title: 'Quản thực đơn',
            isShowCreateDialog: true,
            showCreateDialog: () async {
              await controller.getKitchens();
              showKichenDialog(() => {Get.toNamed(AppRoutes.menuCreate)});
            },
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
                  onSort: (index, ascending) =>
                      controller.sortByCreateDate(index)),
              const DataColumn(
                label: Text('Ngày cập nhật'),
              ),
              const DataColumn(
                label: Text('Số sản phẩm'),
              ),
              const DataColumn(label: Text(' ')),
            ],
            // ignore: invalid_use_of_protected_member
            rows: controller.rows.value,
          ),
        ));
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
            data: menu.kitchen!.name!,
            maxLines: 2,
            width: 200,
          ),
        ),
        DataCell(Text(menu.createDate == null
            ? ""
            : DateFormat('dd-MM-yyyy').format(menu.createDate!))),
        DataCell(Text(menu.updateDate == null
            ? ""
            : DateFormat('dd-MM-yyyy').format(menu.updateDate!))),
        DataCell(Text(menu.menuDetails!.length.toString())),
        DataCell(Row(
          children: [
            const Spacer(),
            DetailButtonDataTable(
                onPressed: () => Get.toNamed('/menu-detail?code=${menu.code}')),
            EditButtonDataTable(onPressed: () {}),
          ],
        )),
      ],
    );
  }

  void showKichenDialog(Function() onPressed) {
    Get.dialog(AlertDialog(
      title: const Text('Chọn bếp'),
      content: SizedBox(
        width: Get.width,
        height: Get.height * 0.5,
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: TextField(
                onChanged: (value) => (value),
                decoration: const InputDecoration(
                  labelText: 'Tìm kiếm',
                ),
                style: Get.theme.textTheme.bodyMedium,
              ),
            ),
            SizedBox(
              height: Get.height * 0.44,
              child: SingleChildScrollView(
                child: Obx(
                  () => Column(
                    children: controller.listKitchen.map(
                      (kitchen) {
                        return Card(
                          child: ListTile(
                            title: Text(kitchen.name.toString()),
                            subtitle: Text(
                                '${kitchen.address}, ${kitchen.area!.ward}, ${kitchen.area!.district}, ${kitchen.area!.city}'),
                            onTap: () {
                              kitchenId = kitchen.id!;
                              Get.back();
                              onPressed();
                            },
                          ),
                        );
                      },
                    ).toList(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
