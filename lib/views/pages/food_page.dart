import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/utils/logger.dart';
import '/utils/data_table.dart';
import '/controllers/food_controller.dart';
import '/views/dialog/create_food_dialog.dart';

class FoodView extends StatelessWidget {
  FoodView({super.key});
  final FoodController _foodController = Get.find();
  // void _sort(int columnIndex, bool ascending) {}

  @override
  Widget build(BuildContext context) {
    final List<DataRow> rows = _foodController.rows;
    logger.i('build FoodView');
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 30),
              child: Center(
                child: Text(
                  'Quản lý sản phẩm',
                  style: Get.textTheme.headlineMedium,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: SizedBox(
                height: 40,
                child: Row(
                  children: [
                    SizedBox(
                      width: 400,
                      child: TextField(
                        controller: _foodController.searchController,
                        decoration: const InputDecoration(
                          labelText: 'Tìm kiếm',
                        ),
                        style: Get.theme.textTheme.bodyMedium,
                      ),
                    ),
                    const Spacer(),
                    FloatingActionButton.extended(
                      icon: const Icon(Icons.add),
                      onPressed: () {
                        showCreateFoodDialog();
                      },
                      label: const Text('Thêm'),
                    ),
                  ],
                ),
              ),
            ),
            Obx(
              () => PaginatedDataTable(
                // header:
                sortColumnIndex: _foodController.columnIndex.value,
                sortAscending: _foodController.columnAscending.value,
                rowsPerPage: 10, // Number of rows per page
                columns: <DataColumn>[
                  DataColumn(
                    label: const Text('STT'),
                    onSort: (index, ascending) => {},
                  ),
                  DataColumn(
                    label: const Text('Code'),
                    onSort: (index, ascending) {
                      _foodController.dataList
                          .sort((a, b) => a.code!.compareTo(b.name!));
                      if (!_foodController.columnAscending.value) {
                        _foodController.dataList =
                            _foodController.dataList.reversed.toList().obs;
                      }
                    },
                  ),
                  DataColumn(label: Text('Hình ảnh')),
                  DataColumn(label: Text('Tên sản phẩm')),
                  DataColumn(label: Text('Giá')),
                  DataColumn(label: Text('Loại')),
                  DataColumn(label: Text('Trạng thái')),
                  DataColumn(label: Text(' ')),
                ],
                source: MyDataTable(rows: rows),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
