import 'package:beanfast_menumanager/views/pages/menu_management_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/models/kitchen.dart';
import '/views/pages/widget/text_data_table_widget.dart';
import '/views/pages/widget/button_data_table.dart';

class KitchenDataRow {
  final int index;
  final Kitchen kitchen;

  const KitchenDataRow({
    required this.index,
    required this.kitchen,
  });

  DataRow getRow() {
    return DataRow(
      cells: [
        DataCell(Text((index + 1).toString())),
        DataCell(
          TextDataTable(
            data: kitchen.code.toString(),
            maxLines: 2,
            width: 100,
          ),
        ),
        DataCell(
          SizedBox(
            // height: ,
            width: 100,
            child: Image.network(
              kitchen.imagePath.toString(),
              fit: BoxFit.fitWidth,
            ),
          ),
        ),
        DataCell(
          TextDataTable(
            data: kitchen.name.toString(),
            maxLines: 2,
            width: 200,
          ),
        ),
        DataCell(Text(kitchen.address.toString())),
        DataCell(Text(kitchen.schoolIds.toString())),
        DataCell(Text(kitchen.schoolIds == null
            ? '0'
            : kitchen.schoolIds!.length.toString())),
        DataCell(Text(kitchen.status.toString())),
        DataCell(Row(
          children: [
            const Spacer(),
            // DetailButtonDataTable(goToPage: Get.to(MenuManagementView())!),
            EditButtonDataTable(showDialog: () {}),
            DeleteButtonDataTable(agree: () {}),
          ],
        )),
      ],
    );
  }
}
