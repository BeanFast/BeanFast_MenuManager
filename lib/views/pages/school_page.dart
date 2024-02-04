import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/utils/logger.dart';
import '/models/school.dart';
import '/controllers/school_controller.dart';
import '/views/dialog/create_school_dialog.dart';
import '/views/pages/widget/data_table_page.dart';
import '/views/pages/widget/button_data_table.dart';
import '/views/pages/widget/text_data_table_widget.dart';

class SchoolView extends StatelessWidget {
  const SchoolView({super.key});

  @override
  Widget build(BuildContext context) {
  final SchoolController schoolController = Get.find();
    logger.i('build SchoolView');
    return Obx(
      () => DataTableView(
        title: 'Quản lý bếp',
        isShowCreateDialog: true,
        showCreateDialog: showCreateSchoolDialog,
        refreshData: schoolController.refreshData,
        search: (value) {
          schoolController.searchString.value = value;
          schoolController.searchName();
        },
        sortColumnIndex: schoolController.columnIndex.value,
        sortAscending: schoolController.columnAscending.value,
        columns: <DataColumn>[
          const DataColumn(
            label: Text('Stt'),
          ),
          const DataColumn(
            label: Text('Code'),
          ),
          const DataColumn(label: Text('Hình ảnh')),
          DataColumn(
              label: const Text('Tên trường'),
              onSort: (index, ascending) =>
                  schoolController.sortByName(index)),
          const DataColumn(
            label: Text('Địa chỉ'),
          ),
          const DataColumn(
            label: Text('Các cổng'),
          ),
          const DataColumn(
            label: Text('Bếp phụ trách'),
          ),
          const DataColumn(
            label: Text('Số học sinh'),
          ),
          const DataColumn(label: Text('Trạng thái')),
          const DataColumn(label: Text(' ')),
        ],
        // ignore: invalid_use_of_protected_member
        rows: schoolController.rows.value,
      ),
    );
  }

  DataRow setRow(int index, School school) {
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