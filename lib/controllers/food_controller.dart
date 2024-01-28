import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/models/food.dart';
import '/views/pages/widget/text_data_table_widget.dart';
// import '/utils/logger.dart';

class FoodController extends GetxController {
  TextEditingController searchController = TextEditingController();
  List<Food> initData = <Food>[];
  List<Food> dataList = <Food>[];
  RxList<DataRow> rows = <DataRow>[].obs;
  Rx<String> searchString = ''.obs;

  Rx<int> columnIndex = 0.obs;
  Rx<bool> columnAscending = true.obs;

  void searchName() {
    if (searchString.value == '') {
      setDataTable(initData);
    } else {
      dataList = initData
          .where((e) =>
              e.name!.toLowerCase().contains(searchString.value.toLowerCase()))
          .toList();
      setDataTable(dataList);
    }
  }

  void sortByName(int index) {
    columnIndex.value = index;
    columnAscending.value = !columnAscending.value;
    dataList.sort((a, b) => a.name!.compareTo(b.name!));
    if (!columnAscending.value) {
      dataList = dataList.reversed.toList();
    }
    setDataTable(dataList);
  }

  void sortByPrice(int index) {
    columnIndex.value = index;
    columnAscending.value = !columnAscending.value;
    dataList.sort((a, b) => a.price!.compareTo(b.price!));
    if (!columnAscending.value) {
      dataList = dataList.reversed.toList();
    }
    setDataTable(dataList);
  }

  @override
  void onInit() {
    super.onInit();
    getData(initData); // init data
    dataList = initData;
    setDataTable(initData); // init data table
  }

  void getData(List<Food> list) async {
    // final apiDataList = await Api().getData();
    for (var e in apiDataList) {
      list.add(Food.fromJson(e));
    }
  }

  void setDataTable(List<Food> list) {
    rows.value = list.map((dataMap) {
      return DataRow(
        cells: [
          DataCell(Text((list.indexOf(dataMap) + 1).toString())),
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
    'price': 1000010,
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
    'price': 1002000,
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
    'price': 1000300,
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
    'price': 1000040,
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
    'price': 1000005,
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
    'price': 1000100,
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
    'price': 1000030,
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
