import 'package:beanfast_menumanager/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/utils/logger.dart';
import '/models/school.dart';
import '/controllers/school_controller.dart';
import '/views/dialog/create_school_dialog.dart';
import '/views/pages/widget/data_table_page.dart';
import '/views/pages/widget/button_data_table.dart';
import '/views/pages/widget/text_data_table_widget.dart';

class SchoolView extends GetView<SchoolController> {
  const SchoolView({super.key});

  @override
  Widget build(BuildContext context) {
    final SchoolController controller = Get.find();
    logger.i('build SchoolView');
    return Obx(
      () => DataTableView(
        title: 'Quản lý trường',
        isShowCreateDialog: true,
        showCreateDialog: showCreateSchoolDialog,
        refreshData: controller.refreshData,
        loadPage: (page) => controller.loadPage(page),
        search: (value) {
          controller.searchString.value = value;
          controller.searchName();
        },
        sortColumnIndex: controller.columnIndex.value,
        sortAscending: controller.columnAscending.value,
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
              onSort: (index, ascending) => controller.sortByName(index)),
          const DataColumn(
            label: Text('Địa chỉ'),
          ),
          const DataColumn(
            label: Text('Số cổng'),
          ),
          const DataColumn(
            label: Text('Số học sinh'),
          ),
          const DataColumn(label: Text(' ')),
        ],
        // ignore: invalid_use_of_protected_member
        rows: controller.rows.value,
      ),
    );
  }

  DataRow setRow(int index, School school) {
    print(school.locations);
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
        DataCell(Text(school.locations!.length.toString())),
        DataCell(Text(school.studentCount.toString())),
        DataCell(Row(
          children: [
            const Spacer(),
            ManageMenuButtonTable(
                onPressed: () => Get.toNamed(AppRoutes.manageMenu,
                    parameters: {"schoolId": school.id!})),
            DetailButtonDataTable(onPressed: () {}),
            EditButtonDataTable(onPressed: () {}),
            DeleteButtonDataTable(onPressed: () {}),
          ],
        )),
      ],
    );
  }
}
