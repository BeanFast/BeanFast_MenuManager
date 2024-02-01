import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/controllers/menu_controller.dart' as controller;

class MenuDetailView extends StatelessWidget {
  const MenuDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller.MenuController menuController = Get.find();
    menuController.currentCode = Get.parameters['code']!;

    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Chi tiết thực đơn')),
        leading: IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(Icons.arrow_back_ios_new)),
      ),
      body: Padding(
        padding:
            const EdgeInsets.only(top: 40, left: 10, right: 10, bottom: 10),
        child: Row(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Get.theme.cardTheme.color,
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  border: Border.all()
                ),
                child: DataTable(
                  columns: const [
                    DataColumn(label: Text('Column 1')),
                    DataColumn(label: Text('Column 2')),
                    // Thêm các cột khác nếu cần
                  ],
                  rows: menuController.initData.map((rowData) {
                    return DataRow(
                      cells: [
                        DataCell(Text(rowData.id.toString())),
                        DataCell(Text(rowData.code.toString())),
                        // Thêm các ô dữ liệu khác nếu cần
                      ],
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
