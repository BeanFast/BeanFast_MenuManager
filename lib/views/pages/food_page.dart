import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/utils/logger.dart';
import '/controllers/food_controller.dart';
import '/views/pages/widget/data_table_page.dart';
import '/views/dialog/create_food_dialog.dart';

class FoodView extends StatelessWidget {
  FoodView({super.key});
  final FoodController _foodController = Get.find();
  // void _sort(int columnIndex, bool ascending) {}

  @override
  Widget build(BuildContext context) {
    logger.i('build FoodView');
    return Obx(
      () => DataTableView(
        title: 'Quản lý sản phẩm',
        showCreateDialog: showCreateFoodDialog,
        refreshData: _foodController.refreshData,
        search: (value) {
          _foodController.searchString.value = value;
          _foodController.searchName();
        },
        sortColumnIndex: _foodController.columnIndex.value,
        sortAscending: _foodController.columnAscending.value,
        columns: <DataColumn>[
          const DataColumn(
            label: Text('Stt'),
          ),
          const DataColumn(
            label: Text('Code'),
          ),
          const DataColumn(label: Text('Hình ảnh')),
          DataColumn(
              label: const Text('Tên sản phẩm'),
              onSort: (index, ascending) => _foodController.sortByName(index)),
          DataColumn(
              label: const Text('Giá'),
              onSort: (index, ascending) => _foodController.sortByPrice(index)),
          const DataColumn(
            label: Text('Loại'),
          ),
          const DataColumn(label: Text('Trạng thái')),
          const DataColumn(label: Text(' ')),
        ],
        // ignore: invalid_use_of_protected_member
        rows: _foodController.rows.value,
      ),
    );
  }
}
