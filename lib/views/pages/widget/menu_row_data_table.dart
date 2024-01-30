import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '/models/menu.dart';
import '/views/pages/widget/text_data_table_widget.dart';
import '/views/pages/widget/button_data_table.dart';

class MenuDataRow {
  final int index;
  final Menu menu;

  const MenuDataRow({
    required this.index,
    required this.menu,
  });

  DataRow getRow() {
    return DataRow(
      cells: [
        DataCell(Text((index + 1).toString())),
        DataCell(
          TextDataTable(
            data: menu.code.toString(),
            maxLines: 2,
            width: 100,
          ),
        ),
        DataCell(
          TextDataTable(
            data: menu.kitchenId.toString(),
            maxLines: 2,
            width: 200,
          ),
        ),
        DataCell(Text(DateFormat('dd-MM-yyyy').format(menu.createDate!))),
        DataCell(Text(DateFormat('dd-MM-yyyy').format(menu.updateDate!))),
        DataCell(Text(menu.schoolIds == null
            ? '0'
            : menu.schoolIds!.length.toString())),
        DataCell(Text(menu.status.toString())),
        DataCell(Row(
          children: [
            const Spacer(),
            DetailButtonDataTable(goToPage: () {}),
            EditButtonDataTable(showDialog: () {}),
            DeleteButtonDataTable(agree: () {}),
          ],
        )),
      ],
    );
  }
}
