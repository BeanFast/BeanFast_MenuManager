import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/controllers/category_controller.dart';
import '/views/pages/loading_page.dart';
import '/models/category.dart';
import '/views/pages/widget/button_data_table.dart';
import '/views/pages/widget/text_data_table_widget.dart';
import '/views/pages/widget/data_table_page.dart';

class CategoryView extends GetView<CategoryController> {
  const CategoryView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(CategoryController());
    return LoadingView(
      future: controller.refreshData,
      child: Obx(
        () => DataTableView(
          title: 'Quản lý loại sản phẩm',
          refreshData: controller.refreshData,
          loadPage: (page) => controller.loadPage(page),
          search: (value) => controller.search(value),
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
                label: const Text('Tên sản phẩm'),
                onSort: (index, ascending) => controller.sortByName(index)),
            const DataColumn(label: Text(' ')),
          ],
          // ignore: invalid_use_of_protected_member
          rows: controller.rows.value,
        ),
      ),
    );
  }

  DataRow setRow(int index, Category category) {
    return DataRow(
      cells: [
        DataCell(Text((index + 1).toString())),
        DataCell(
          TextDataTable(
            data: category.code.toString(),
            maxLines: 2,
            width: 100,
          ),
        ),
        DataCell(
          SizedBox(
            width: 100,
            child: Image.network(
              category.imagePath.toString(),
              fit: BoxFit.fitWidth,
            ),
          ),
        ),
        DataCell(
          TextDataTable(
            data: category.name.toString(),
            maxLines: 2,
            width: 200,
          ),
        ),
        DataCell(Row(
          children: [
            const Spacer(),
            EditButtonDataTable(onPressed: () {}),
          ],
        )),
      ],
    );
  }
}
