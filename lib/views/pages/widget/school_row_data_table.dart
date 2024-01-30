import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/models/school.dart';
import '/views/pages/widget/text_data_table_widget.dart';
import '/views/pages/widget/button_data_table.dart';
import '/views/pages/menu_management_page.dart';

class SchoolDataRow {
  final int index;
  final School school;

  const SchoolDataRow({
    required this.index,
    required this.school,
  });

  DataRow getRow() {
    return DataRow(
      cells: [
        DataCell(Text((index + 1).toString())),
        DataCell(
          TextDataTable(
            data: school.code.toString(),
            maxLines: 2,
            width: 100,
          ),
        ),
        DataCell(
          SizedBox(
            // height: ,
            width: 100,
            child: Image.network(
              school.imagePath.toString(),
              fit: BoxFit.fitWidth,
            ),
          ),
        ),
        DataCell(
          TextDataTable(
            data: school.name.toString(),
            maxLines: 2,
            width: 200,
          ),
        ),
        DataCell(Text(school.address.toString())),
        DataCell(Text(school.locationIds.toString())),
        DataCell(Text(school.kitchenId.toString())),
        DataCell(Text(school.profileIds.toString())),
        DataCell(Text(school.status.toString())),
        DataCell(Row(
          children: [
            const Spacer(),
            IconButton(
                onPressed: () => Get.toNamed('/menu-management'),
                icon: Icon(Icons.abc)),
            DetailButtonDataTable(goToPage: () {}),
            EditButtonDataTable(showDialog: () {}),
            DeleteButtonDataTable(agree: () {}),
          ],
        )),
      ],
    );
  }
}
