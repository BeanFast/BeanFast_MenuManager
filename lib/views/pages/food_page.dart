import 'package:beanfast_menumanager/controllers/food_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/logger.dart';
import '../../utils/data_table.dart';
// import 'package:beanfast_menumanager/controllers/home_controller.dart';



class FoodView extends StatelessWidget {
  FoodView({super.key});

  FoodController _foodController = Get.find();
  
  final List<DataRow> _rows = dataList.map((dataMap) {
    int stt = 0;
    return DataRow(
      cells: [
        DataCell(Text(stt.toString())),
        DataCell(Text(dataMap['Column1'].toString())),
        DataCell(Text(dataMap['Column2'].toString())),
        DataCell(Text(dataMap['Column3'].toString())),
        DataCell(Text(dataMap['Column4'].toString())),
        DataCell(Text(dataMap['Column5'].toString())),
        DataCell(Text(dataMap['Column6'].toString())),
        DataCell(Text('Action')),
        // Add more DataCell widgets as needed
      ],
    );
  }).toList();
  @override
  Widget build(BuildContext context) {
    logger.i('build FoodView');
    
    return PaginatedDataTable(
      header: Text('Data Table Header'),
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
      source: MyDataTable(rows: _rows),
    );
  }
}