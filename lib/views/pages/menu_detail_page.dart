import 'package:beanfast_menumanager/models/menu_detail.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/controllers/menu_detail_controller.dart';
import '/views/pages/widget/button_data_table.dart';
import '/views/pages/widget/text_data_table_widget.dart';
import '/views/pages/widget/paginated_data_table_widget.dart';

class MenuDetailView extends GetView<MenuDetailController> {
  List<MenuDetail>? menuDetails = [];
  MenuDetailView({this.menuDetails, super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(MenuDetailController());
    print(menuDetails.toString());
    if (menuDetails != null && menuDetails!.length > 0) {
      for (var i = 0; i < menuDetails!.length; i++) {
        var menuDetail = menuDetails![i];
        print(menuDetail.toString());
        controller.rows.add(setMenuDetailRow(i, menuDetail));
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Chi tiết thực đơn')),
        leading: IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(Icons.arrow_back_ios_new)),
      ),
      body: Padding(
        padding:
            const EdgeInsets.only(top: 40, left: 10, right: 10, bottom: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: Get.height * 0.2,
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: Get.width,
                child: Obx(() => PaginatedDataTableView(
                    sortColumnIndex: controller.columnIndex.value,
                    sortAscending: controller.columnAscending.value,
                    search: (value) => controller.search(value),
                    refreshData: controller.refreshData,
                    loadPage: (page) => controller.loadPage(page),
                    columns: [
                      const DataColumn(
                        label: Text('Stt'),
                      ),
                      const DataColumn(
                        label: Text('Code'),
                      ),
                      const DataColumn(label: Text('Hình ảnh')),
                      DataColumn(
                          label: const Text('Tên sản phẩm'),
                          onSort: (index, ascending) =>
                              controller.sortFoodByName(index)),
                      DataColumn(
                          label: const Text('Giá'),
                          onSort: (index, ascending) =>
                              controller.sortFoodByPrice(index)),
                      const DataColumn(
                        label: Text('Loại'),
                      ),
                      const DataColumn(label: Text(' ')),
                    ],
                    // ignore: invalid_use_of_protected_member
                    rows: controller.rows.value)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  DataRow setMenuDetailRow(int index, MenuDetail menuDetail) {
    print(menuDetail);
    var food = menuDetail.food!;
    return DataRow(
      cells: [
        DataCell(Text((index + 1).toString())),
        DataCell(
          TextDataTable(
            data: food.code.toString(),
            maxLines: 2,
            width: 100,
          ),
        ),
        DataCell(
          SizedBox(
            width: 100,
            child: Image.network(
              food.imagePath.toString(),
              fit: BoxFit.fitWidth,
            ),
          ),
        ),
        DataCell(
          TextDataTable(
            data: food.name.toString(),
            maxLines: 2,
            width: 200,
          ),
        ),
        DataCell(Text(food.price.toString())),
        DataCell(Text(food.categoryId.toString())),
        DataCell(Row(
          children: [
            const Spacer(),
            DetailButtonDataTable(
                onPressed: () => Get.toNamed('/food-detail?code=${food.code}')),
            EditButtonDataTable(onPressed: () {}),
            DeleteButtonDataTable(onPressed: () {}),
          ],
        )),
      ],
    );
  }
}
