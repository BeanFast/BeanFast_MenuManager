import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/models/food.dart';
import '/views/pages/widget/text_data_table_widget.dart';
import '/utils/logger.dart';
import '/utils/data_table.dart';

class FoodController extends GetxController {
  final searchController = TextEditingController();
  RxList<Food> dataList = <Food>[].obs;

  Rx<int> columnIndex = 0.obs;
  Rx<bool> columnAscending = true.obs;
  RxList<DataRow> rows = <DataRow>[].obs;

  List<Food> get filteredList => dataList
      .where((e) =>
          e.name!.toLowerCase().contains(searchController.text.toLowerCase()))
      .toList();

  // void sortByColumn(int index) {
  //   columnIndex.value = index;
  //   columnAscending.value = !columnAscending.value;
  //   for (var item in dataList) {
  //     if (item[index] is! Comparable) {
  //       // Hiển thị lỗi hoặc xử lý trường hợp không thể so sánh
  //       Get.snackbar("Lỗi", "Cột này không thể so sánh!");
  //       return;
  //     }
  //   }
  //   dataList.sort((a, b) => a[index].compareTo(b[index]));
  // if (!columnAscending.value) {
  //   dataList = dataList.reversed.toList();
  // }
  //   rows = getData();
  //   update(); // Thông báo giao diện cập nhật
  // }
  @override
  void onInit() {
    super.onInit();
    getFoods();
    rows.value = setDataTable();
    searchController.addListener(() {
      dataList.removeLast();
      // dataList.value = filteredList;
      // update();
    });
  }

  void getFoods() async {
    // final apiDataList = await Api().getData();
    for (var e in apiDataList) {
      dataList.add(Food.fromJson(e));
    }
  }

  List<DataRow> setDataTable() {
    return dataList.map((dataMap) {
      return DataRow(
        cells: [
          DataCell(Text((dataList.indexOf(dataMap) + 1).toString())),
          DataCell(TextDataTable(
            data: dataMap.code.toString(),
            maxLines: 2,
            width: 100,
          )),
          DataCell(TextDataTable(
            data: dataMap.imagePath.toString(),
            maxLines: 2,
            width: 100,
          )),
          DataCell(Text(dataMap.name!)),
          DataCell(Text(dataMap.price.toString())),
          DataCell(Text(dataMap.categoryId.toString())),
          DataCell(Text(dataMap.status.toString())),
          DataCell(Text(2.toString())),
        ],
      );
    }).toList();
  }
}

List<Map<String, dynamic>> apiDataList = [
  {
    'id': '1',
    'categoryId': '1',
    'code': 'Value1',
    'name': 'Value1',
    'price': 100000,
    'description': 'Value1',
    'isCombo': false,
    'imagePath': 'Value1',
    'status': 1,
  },
  {
    'id': '2',
    'categoryId': '2',
    'code': 'Value2',
    'name': 'Value2',
    'price': 100000,
    'description': 'Value2',
    'isCombo': false,
    'imagePath': 'Value2',
    'status': 1,
  },
  {
    'id': '3',
    'categoryId': '1',
    'code': 'Value3',
    'name': 'Value3',
    'price': 100000,
    'description': 'Value1',
    'isCombo': false,
    'imagePath': 'Value1',
    'status': 1,
  },
  {
    'id': '4',
    'categoryId': '4',
    'code': 'Value4',
    'name': 'Value4',
    'price': 100000,
    'description': 'Value1',
    'isCombo': false,
    'imagePath': 'Value1',
    'status': 1,
  },
  {
    'id': '5',
    'categoryId': '5',
    'code': 'Value5',
    'name': 'Value5',
    'price': 100000,
    'description': 'Value1',
    'isCombo': false,
    'imagePath': 'Value1',
    'status': 1,
  },
  {
    'id': '6',
    'categoryId': '1',
    'code': 'Value6',
    'name': 'Value6',
    'price': 100000,
    'description': 'Value1',
    'isCombo': false,
    'imagePath': 'Value1',
    'status': 1,
  },
  {
    'id': '7',
    'categoryId': '1',
    'code': 'Value7',
    'name': 'Value7',
    'price': 100000,
    'description': 'Value1',
    'isCombo': false,
    'imagePath': 'Value1',
    'status': 1,
  },
  {
    'id': '8',
    'categoryId': '1',
    'code': 'Value8',
    'name': 'Value8',
    'price': 100000,
    'description': 'Value1',
    'isCombo': false,
    'imagePath': 'Value1',
    'status': 1,
  },
  {
    'id': '9',
    'categoryId': '1',
    'code': 'Value9',
    'name': 'Value9',
    'price': 100000,
    'description': 'Value1',
    'isCombo': false,
    'imagePath': 'Value1',
    'status': 1,
  },
  {
    'id': '10',
    'categoryId': '1',
    'code': 'Value10',
    'name': 'Value10',
    'price': 100000,
    'description': 'Value1',
    'isCombo': false,
    'imagePath': 'Value1',
    'status': 1,
  },
  {
    'id': '11',
    'categoryId': '1',
    'code': 'Value11',
    'name': 'Value11',
    'price': 100000,
    'description': 'Value1',
    'isCombo': false,
    'imagePath': 'Value1',
    'status': 1,
  },
];
