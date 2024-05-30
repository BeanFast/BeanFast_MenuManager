import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/controllers/category_controller.dart';
import '/models/category.dart';
import 'loading_page.dart';
import 'category_detail.dart';
import 'widget/search_widget.dart';
import 'widget/button_data_table.dart';
import 'widget/paginated_datatable_widget.dart';

class CategoryView extends GetView<CategoryController> {
  const CategoryView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(CategoryController());
    return LoadingView(
      future: controller.fetchData,
      child: Padding(
        padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                'Quản lý loại',
                textAlign: TextAlign.start,
                style: Get.textTheme.titleMedium,
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  SearchBox(search: controller.search),
                  const Spacer(),
                ],
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: Get.height * 0.7,
                child: const PaginatedDataTableView<CategoryController>(
                  title: 'Danh sách loại',
                  columns: <DataColumn>[
                    DataColumn(label: Text('Code')),
                    DataColumn(label: Text('Hình ảnh')),
                    DataColumn(label: Text('Tên loại')),
                    DataColumn(label: Text('')),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  DataRow setRow(Category category) {
    return DataRow(
      cells: [
        DataCell(Text(category.code.toString())),
        DataCell(
          SizedBox(
            width: 100,
            child: Image.network(
              category.imagePath.toString(),
              fit: BoxFit.fitWidth,
            ),
          ),
        ),
        DataCell(Text(category.name.toString())),
        DataCell(Row(
          children: [
            const Spacer(),
            DetailButtonDataTable(onPressed: () {
              Get.to(CategoryDetailView(category));
            }),
          ],
        )),
      ],
    );
  }
}
