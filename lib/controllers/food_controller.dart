import 'package:beanfast_menumanager/views/pages/widget/text_data_table_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/data_table.dart';

class FoodController extends GetxController {
  final data = List<Map<String, dynamic>>;
  final searchController = TextEditingController();
  final Rx<String> searchString = ''.obs;

  Rx<int> columnIndex = 0.obs;
  Rx<bool> columnAscending = true.obs;
  List<DataRow> rows = getData();
  // final DataTableSource dataSource = MyDataTable(rows: rows);

  DataTableSource getDataTableSource() {
    return MyDataTable(rows: rows);
  }

  void sortByColumn(int index) {
    columnIndex.value = index;
    columnAscending.value = !columnAscending.value;
    for (var item in dataList) {
      if (item[index] is! Comparable) {
        // Hiển thị lỗi hoặc xử lý trường hợp không thể so sánh
        Get.snackbar("Lỗi", "Cột này không thể so sánh!");
        return;
      }
    }
    dataList.sort((a, b) => a[index].compareTo(b[index]));
    if (!columnAscending.value) {
      dataList = dataList.reversed.toList();
    }
    rows = getData();
    update(); // Thông báo giao diện cập nhật
  }

  @override
  void onInit() {
    super.onInit();
    // this.data. = dataList;
  }
}

List<DataRow> getData() {
  return dataList.map((dataMap) {
    // stt++;
    return DataRow(
      cells: [
        DataCell(Text(1.toString())),
        DataCell(TextDataTable(
          data: dataMap['Column1'].toString(),
          maxLines: 2,
          tooltipBgColor: Colors.red,
          width: 100,
        )),
        DataCell(TextDataTable(
          data: dataMap['Column2'].toString(),
          maxLines: 2,
          tooltipBgColor: Colors.red,
          width: 100,
        )),
        DataCell(Text(dataMap['Column3'].toString())),
        DataCell(Text(dataMap['Column4'].toString())),
        DataCell(Text(dataMap['Column5'].toString())),
        DataCell(Text(dataMap['Column6'].toString())),
        DataCell(Text(2.toString())),

        // Add more DataCell widgets as needed
      ],
    );
  }).toList();
}

List<Map<String, dynamic>> dataList = [
  {
    'Column1': '1',
    'Column2': 1,
    'Column3': 'Value3',
    'Column4': 'Value4',
    'Column5': 'Value5',
    'Column6': 'Value6'
  },
  // {
  //   'Column1': 'Value12222222222222222222222222222222222222222',
  //   'Column2': 'Value222222222222222222222222222',
  //   'Column3': 'Valu22222222222222222222222222222e3',
  //   'Column4': 'Val22222222222222222222222222222ue4',
  //   'Column5': 'Val222222222222222222222222222222ue5',
  //   'Column6': 'Valu222222222222222222222222222222e6'
  // },
  {
    'Column1': '2',
    'Column2': 2,
    'Column3': 'Value3',
    'Column4': 'Value4',
    'Column5': 'Value5',
    'Column6': 'Value6'
  },
  {
    'Column1': '3',
    'Column2': 3,
    'Column3': 'Value3',
    'Column4': 'Value4',
    'Column5': 'Value5',
    'Column6': 'Value6'
  },
  {
    'Column1': '4',
    'Column2': 4,
    'Column3': 'Value3',
    'Column4': 'Value4',
    'Column5': 'Value5',
    'Column6': 'Value6'
  },
  {
    'Column1': '5',
    'Column2': 5,
    'Column3': 'Value3',
    'Column4': 'Value4',
    'Column5': 'Value5',
    'Column6': 'Value6'
  },
  {
    'Column1': '6',
    'Column2': 6,
    'Column3': 'Value3',
    'Column4': 'Value4',
    'Column5': 'Value5',
    'Column6': 'Value6'
  },
  {
    'Column1': '7',
    'Column2': 7,
    'Column3': 'Value3',
    'Column4': 'Value4',
    'Column5': 'Value5',
    'Column6': 'Value6'
  },
  {
    'Column1': '8',
    'Column2': 8,
    'Column3': 'Value3',
    'Column4': 'Value4',
    'Column5': 'Value5',
    'Column6': 'Value6'
  },
  {
    'Column1': '9',
    'Column2': 9,
    'Column3': 'Value3',
    'Column4': 'Value4',
    'Column5': 'Value5',
    'Column6': 'Value6'
  },
  {
    'Column1': '10',
    'Column2': 10,
    'Column3': 'Value3',
    'Column4': 'Value4',
    'Column5': 'Value5',
    'Column6': 'Value6'
  },
  {
    'Column1': '10',
    'Column2': 10,
    'Column3': 'Value3',
    'Column4': 'Value4',
    'Column5': 'Value5',
    'Column6': 'Value6'
  },
  {
    'Column1': '10',
    'Column2': 10,
    'Column3': 'Value3',
    'Column4': 'Value4',
    'Column5': 'Value5',
    'Column6': 'Value6'
  },
  {
    'Column1': '10',
    'Column2': 10,
    'Column3': 'Value3',
    'Column4': 'Value4',
    'Column5': 'Value5',
    'Column6': 'Value6'
  },
  {
    'Column1': '10',
    'Column2': 10,
    'Column3': 'Value3',
    'Column4': 'Value4',
    'Column5': 'Value5',
    'Column6': 'Value6'
  },
  {
    'Column1': '10',
    'Column2': 10,
    'Column3': 'Value3',
    'Column4': 'Value4',
    'Column5': 'Value5',
    'Column6': 'Value6'
  },
  
  // Add more data as needed
];
