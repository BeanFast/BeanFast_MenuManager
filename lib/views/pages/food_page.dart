import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/utils/logger.dart';
import '/models/food.dart';
import '/controllers/food_controller.dart';
import '/views/pages/widget/button_data_table.dart';
import '/views/pages/widget/text_data_table_widget.dart';
import '/views/pages/widget/data_table_page.dart';
import '/views/dialog/create_food_dialog.dart';

class FoodView extends StatelessWidget {
  const FoodView({super.key});

  @override
  Widget build(BuildContext context) {
  final FoodController foodController = Get.find();
    logger.i('build FoodView');
    return Obx(
      () => DataTableView(
        title: 'Quản lý sản phẩm',
        isShowCreateDialog: true,
        showCreateDialog: showCreateFoodDialog,
        refreshData: foodController.refreshData,
        search: (value) {
          foodController.searchString.value = value;
          foodController.search;
        },
        sortColumnIndex: foodController.columnIndex.value,
        sortAscending: foodController.columnAscending.value,
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
              onSort: (index, ascending) => foodController.sortByName(index)),
          DataColumn(
              label: const Text('Giá'),
              onSort: (index, ascending) => foodController.sortByPrice(index)),
          const DataColumn(
            label: Text('Loại'),
          ),
          const DataColumn(label: Text('Trạng thái')),
          const DataColumn(label: Text(' ')),
        ],
        // ignore: invalid_use_of_protected_member
        rows: foodController.rows.value,
      ),
    );
  }

  DataRow setRow(int index, Food food) {
    return DataRow(
      cells: [
        DataCell(Text((index + 1).toString())),
        DataCell(
          TextDataTable(
            data: food.code.toString(),
            maxLines: 2,
            width: 100,
          ),
        ),
        DataCell(
          SizedBox(
            width: 100,
            child: Image.network(
              food.imagePath.toString(),
              fit: BoxFit.fitWidth,
            ),
          ),
        ),
        DataCell(
          TextDataTable(
            data: food.name.toString(),
            maxLines: 2,
            width: 200,
          ),
        ),
        DataCell(Text(food.price.toString())),
        DataCell(Text(food.categoryId.toString())),
        DataCell(Text(food.status.toString())),
        DataCell(Row(
          children: [
            const Spacer(),
            DetailButtonDataTable(goToPage: () => Get.toNamed('/food-detail?code=${food.code}')),
            EditButtonDataTable(showDialog: () {}),
            DeleteButtonDataTable(agree: () {}),
          ],
        )),
      ],
    );
  }
}
