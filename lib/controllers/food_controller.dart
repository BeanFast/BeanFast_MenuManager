import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FoodController extends GetxController {
  final data = List<Map<String, dynamic>>;
  int stt = 0;
  final List<DataRow> rows = dataList.map((dataMap) {
    // stt++;
    return DataRow(
      cells: [
        DataCell(Text(1.toString())),
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
  void onInit() {
    super.onInit();
    // this.data. = dataList;
  }
}

List<Map<String, dynamic>> dataList = [
  {
    'Column1': 'Value122222222222222222222222222222222222222222222',
    'Column2': 'Value2',
    'Column3': 'Value3',
    'Column4': 'Value4',
    'Column5': 'Value5',
    'Column6': 'Value6'
  },
  {
    'Column1': 'Value12222222222222222222222222222222222222222',
    'Column2': 'Value222222222222222222222222222',
    'Column3': 'Valu22222222222222222222222222222e3',
    'Column4': 'Val22222222222222222222222222222ue4',
    'Column5': 'Val222222222222222222222222222222ue5',
    'Column6': 'Valu222222222222222222222222222222e6'
  },
  {
    'Column1': 'Valu2222222222222222222222222222e1',
    'Column2': 'Value2',
    'Column3': 'Value3',
    'Column4': 'Value4',
    'Column5': 'Value5',
    'Column6': 'Value6'
  },
  {
    'Column1': 'Value222222222222222222222221',
    'Column2': 'Value2',
    'Column3': 'Value3',
    'Column4': 'Value4',
    'Column5': 'Value5',
    'Column6': 'Value6'
  },
  {
    'Column1': 'Value1222222222222222222222222',
    'Column2': 'Value2',
    'Column3': 'Value3',
    'Column4': 'Value4',
    'Column5': 'Value5',
    'Column6': 'Value6'
  },
  {
    'Column1': 'Valu222222222222222222222222222222e1',
    'Column2': 'Value2',
    'Column3': 'Value3',
    'Column4': 'Value4',
    'Column5': 'Value5',
    'Column6': 'Value6'
  },
  {
    'Column1': 'Valu2222222222222222222222222222222e1',
    'Column2': 'Value2',
    'Column3': 'Value3',
    'Column4': 'Value4',
    'Column5': 'Value5',
    'Column6': 'Value6'
  },
  {
    'Column1': 'Value1',
    'Column2': 'Value2',
    'Column3': 'Value3',
    'Column4': 'Value4',
    'Column5': 'Value5',
    'Column6': 'Value6'
  },
  {
    'Column1': 'Value1',
    'Column2': 'Value2',
    'Column3': 'Value3',
    'Column4': 'Value4',
    'Column5': 'Value5',
    'Column6': 'Value6'
  },
  {
    'Column1': 'Value1',
    'Column2': 'Value2',
    'Column3': 'Value3',
    'Column4': 'Value4',
    'Column5': 'Value5',
    'Column6': 'Value6'
  },
  {
    'Column1': 'Value1',
    'Column2': 'Value2',
    'Column3': 'Value3',
    'Column4': 'Value4',
    'Column5': 'Value5',
    'Column6': 'Value6'
  },
  {
    'Column1': 'Value1',
    'Column2': 'Value2',
    'Column3': 'Value3',
    'Column4': 'Value4',
    'Column5': 'Value5',
    'Column6': 'Value6'
  },
  {
    'Column1': 'Value1',
    'Column2': 'Value2',
    'Column3': 'Value3',
    'Column4': 'Value4',
    'Column5': 'Value5',
    'Column6': 'Value6'
  },
  {
    'Column1': 'Value1',
    'Column2': 'Value2',
    'Column3': 'Value3',
    'Column4': 'Value4',
    'Column5': 'Value5',
    'Column6': 'Value6'
  },
  {
    'Column1': 'Value1',
    'Column2': 'Value2',
    'Column3': 'Value3',
    'Column4': 'Value4',
    'Column5': 'Value5',
    'Column6': 'Value6'
  },
  {
    'Column1': 'Value1',
    'Column2': 'Value2',
    'Column3': 'Value3',
    'Column4': 'Value4',
    'Column5': 'Value5',
    'Column6': 'Value6'
  },
  {
    'Column1': 'Value1',
    'Column2': 'Value2',
    'Column3': 'Value3',
    'Column4': 'Value4',
    'Column5': 'Value5',
    'Column6': 'Value6'
  },
  // Add more data as needed
];
