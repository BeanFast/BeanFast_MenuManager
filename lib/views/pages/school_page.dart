import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/utils/logger.dart';
import '/controllers/school_controller.dart';
import '/views/dialog/create_school_dialog.dart';
import '/views/pages/widget/data_table_page.dart';

class SchoolView extends StatelessWidget {
  SchoolView({super.key});
  final SchoolController _schoolController = Get.find();

  @override
  Widget build(BuildContext context) {
    logger.i('build SchoolView');
    return Obx(
      () => DataTableView(
        title: 'Quản lý bếp',
        showCreateDialog: showCreateSchoolDialog,
        refreshData: _schoolController.refreshData,
        search: (value) {
          _schoolController.searchString.value = value;
          _schoolController.searchName();
        },
        sortColumnIndex: _schoolController.columnIndex.value,
        sortAscending: _schoolController.columnAscending.value,
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
                  _schoolController.sortByName(index)),
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
        rows: _schoolController.rows.value,
      ),
    );
  }
}
