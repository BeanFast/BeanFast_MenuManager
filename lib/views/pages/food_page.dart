import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/utils/logger.dart';
import '/utils/data_table.dart';
import '/controllers/food_controller.dart';
// import '/controllers/home_controller.dart';
import '/views/pages/widget/drawer_wdget.dart';

class FoodView extends StatelessWidget {
  FoodView({super.key});
  // final HomeController _homeController = Get.find();
  final FoodController _foodController = Get.find();
  void _sort(int columnIndex, bool ascending) {
    // setState(() {
    //   _columnIndex = columnIndex;
    //   _columnAscending = ascending;
    //   dataSource.setData(episodes, _columnIndex, _columnAscending);
    // });
  }
  @override
  Widget build(BuildContext context) {
    final List<DataRow> rows = _foodController.rows;
    logger.i('build FoodView');
    return Scaffold(
      appBar: AppBar(),
      drawer: AppDrawer(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: ListBody(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: Row(
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
                    ElevatedButton(
                      onPressed: () {},
                      child: const Text('Nút nổi'),
                    ),
                  ],
                ),
              ),
              Obx(() => PaginatedDataTable(
                    // header:
                    sortColumnIndex: _foodController.columnIndex.value,
                    sortAscending: _foodController.columnAscending.value,
                    rowsPerPage: 10, // Number of rows per page
                    columns: <DataColumn>[
                      DataColumn(
                          label: Text('STT'), onSort: (index, ascending) => _foodController.sortByColumn(index),),
                      DataColumn(label: Text('Code'), onSort: (index, ascending) => _foodController.sortByColumn(index),),
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
      ),
    );
  }
}
