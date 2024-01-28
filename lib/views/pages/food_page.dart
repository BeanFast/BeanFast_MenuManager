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
                    Expanded(
                      child: SizedBox(
                        width: 400,
                        child: TextField(
                          // controller: _foodController.searchController,
                          onChanged: (value) {
                            _foodController.searchString.value = value;
                            _foodController.searchName();
                          },
                          decoration: const InputDecoration(
                            labelText: 'Tìm kiếm',
                          ),
                          style: Get.theme.textTheme.bodyMedium,
                        ),
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
            Obx(() => PaginatedDataTable(
                  sortColumnIndex: _foodController.columnIndex.value,
                  sortAscending: _foodController.columnAscending.value,
                  rowsPerPage: 10,
                  columns: <DataColumn>[
                    DataColumn(
                      label: const Text('Stt'),
                      onSort: (index, ascending) => {

                      },
                    ),
                    DataColumn(
                      label: const Text('Code'),
                      onSort: (index, ascending) {},
                    ),
                    const DataColumn(label: Text('Hình ảnh')),
                    DataColumn(
                      label: const Text('Tên sản phẩm'),
                      onSort: (index, ascending) {},
                    ),
                    DataColumn(
                      label: const Text('Giá'),
                      onSort: (index, ascending) {},
                    ),
                    DataColumn(
                      label: const Text('Loại'),
                      onSort: (index, ascending) {},
                    ),
                    const DataColumn(label: Text('Trạng thái')),
                    const DataColumn(label: Text(' ')),
                  ],
                  // ignore: invalid_use_of_protected_member
                  source: MyDataTable(rows: _foodController.rows.value),
                )),
            Obx(() => Text(_foodController.searchString.value)),
          ],
        ),
      ),
    );
  }
}
