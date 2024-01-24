import 'package:beanfast_menumanager/controllers/food_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/logger.dart';
import '../../utils/data_table.dart';
// import 'package:beanfast_menumanager/controllers/home_controller.dart';

class FoodView extends StatelessWidget {
  FoodView({super.key});
  final FoodController _foodController = Get.find();

  @override
  Widget build(BuildContext context) {
    final List<DataRow> rows = _foodController.rows;
    logger.i('build FoodView');

    return Scaffold(
      body: PaginatedDataTable(
        header: const Text('Data Table Header'),
        rowsPerPage: 10, // Number of rows per page
        columns: const [
          DataColumn(label: Text('STT')),
          DataColumn(label: Text('Code')),
          DataColumn(label: Text('Hình ảnh')),
          DataColumn(label: Text('Sản phẩm')),
          DataColumn(label: Text('Giá')),
          DataColumn(label: Text('Loại')),
          DataColumn(label: Text('Trạng thái')),
          DataColumn(label: Text(' ')),
          // Add more DataColumn widgets as needed
        ],
        source: MyDataTable(rows: rows),
      ),
    );
  }
}
