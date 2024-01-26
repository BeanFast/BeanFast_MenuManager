import 'package:beanfast_menumanager/views/dialog/create_food_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/utils/logger.dart';
import '/utils/data_table.dart';
import '/controllers/food_controller.dart';

class FoodView extends StatelessWidget {
  FoodView({super.key});
  final FoodController _foodController = Get.find();
  void _sort(int columnIndex, bool ascending) {}

  @override
  Widget build(BuildContext context) {
    final List<DataRow> rows = _foodController.rows;
    logger.i('build FoodView');
    // final _formKey = GlobalKey<FormState>();
    return Scaffold(
      // appBar: AppBar(),
      // drawer: AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: ListView(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _foodController.searchController,
                    decoration: const InputDecoration(
                      labelText: 'Tìm kiếm',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const Spacer(),
                FloatingActionButton.extended(
                  icon: const Icon(Icons.update),
                  onPressed: () {
                    showCreateFoodDialog();
                  },
                  label: const Text('Cập nhật món ăn'),
                ),
              ],
            ),
            Obx(() => PaginatedDataTable(
                  // header:
                  sortColumnIndex: _foodController.columnIndex.value,
                  sortAscending: _foodController.columnAscending.value,
                  rowsPerPage: 10, // Number of rows per page
                  columns: <DataColumn>[
                    DataColumn(
                      label: Text('STT'),
                      onSort: (index, ascending) =>
                          _foodController.sortByColumn(index),
                    ),
                    DataColumn(
                      label: Text('Code'),
                      onSort: (index, ascending) =>
                          _foodController.sortByColumn(index),
                    ),
                    DataColumn(label: Text('Hình ảnh')),
                    DataColumn(label: Text('Tên sản phẩm')),
                    DataColumn(label: Text('Giá')),
                    DataColumn(label: Text('Loại')),
                    DataColumn(label: Text('Trạng thái')),
                    DataColumn(label: Text(' ')),
                  ],
                  source: MyDataTable(rows: rows),
                )),
          ],
        ),
      ),
    );
  }
}
