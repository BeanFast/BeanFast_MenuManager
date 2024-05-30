import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart' hide MenuController;
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '/routes/app_routes.dart';
import '/controllers/menu_controller.dart';
import '/models/menu.dart';
import 'loading_page.dart';
import 'widget/button_data_table.dart';
import 'widget/paginated_datatable_widget.dart';

class MenuView extends GetView<MenuController> {
  const MenuView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(MenuController());
    return LoadingView(
      future: controller.fetchData,
      child: Padding(
        padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
        child: SingleChildScrollView(
          child: Column(children: [
            Text(
              'Quản lý thực đơn',
              textAlign: TextAlign.start,
              style: Get.textTheme.titleMedium,
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Spacer(),
                CreateButtonDataTable(
                  onPressed: () => Get.toNamed(AppRoutes.menuCreate),
                ),
              ],
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: Get.height * 0.7,
              child: const PaginatedDataTableView<MenuController>(
                title: 'Danh sách món ăn',
                columns: <DataColumn>[
                  DataColumn2(label: Text('Code')),
                  DataColumn2(label: Text('Hình ảnh')),
                  DataColumn2(label: Text('Tên sản phẩm')),
                  DataColumn2(label: Text('Loại')),
                  DataColumn2(label: Text('Giá')),
                  DataColumn2(label: Text('')),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }

  DataRow setRow(Menu menu) {
    return DataRow(
      cells: [
        DataCell(Text(menu.code.toString())),
        DataCell(Text(menu.kitchen!.name.toString())),
        DataCell(Text(menu.createDate == null
            ? ""
            : DateFormat('dd/MM/yy').format(menu.createDate!))),
        DataCell(Text(menu.updateDate == null
            ? ""
            : DateFormat('dd/MM/yy').format(menu.updateDate!))),
        DataCell(Text(menu.menuDetails!.length.toString())),
        DataCell(Row(
          children: [
            const Spacer(),
            DetailButtonDataTable(
                onPressed: () => Get.toNamed('/menu-detail?code=${menu.code}')),
          ],
        )),
      ],
    );
  }
}
