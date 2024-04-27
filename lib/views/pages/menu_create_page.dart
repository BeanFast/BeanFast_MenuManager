import 'package:beanfast_menumanager/models/menu_detail.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/utils/data_table.dart';
import '/models/food.dart';
import '/utils/format_data.dart';
import '/controllers/menu_create_update_controller.dart';
import '/views/pages/loading_page.dart';
import '/views/pages/widget/data_table_page.dart';
import 'widget/text_data_table_widget.dart';

class MenuCreateView extends GetView<MenuCreateController> {
  const MenuCreateView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(MenuCreateController());
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: ListBody(
            mainAxis: Axis.vertical,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 30),
                child: Center(
                  child: Text(
                    'Tạo thực đơn',
                    style: Get.textTheme.headlineMedium,
                  ),
                ),
              ),
              SizedBox(
                height: 40,
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: FloatingActionButton.extended(
                          onPressed: showAddFoodToMenuDialog,
                          label: const Text('Thêm sản phẩm'),
                        ),
                      ),
                    ),
                    const Spacer(flex: 8),
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: FloatingActionButton.extended(
                          onPressed: controller.createMenu,
                          label: const Text('Tạo'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: Get.width,
                child: Obx(() => PaginatedDataTable(
                        // sortColumnIndex: controller.columnIndex.value,
                        // sortAscending: controller.columnAscending.value,
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
                                  (index, ascending) {}),
                          const DataColumn(label: Text('Loại')),
                          const DataColumn(label: Text('Combo')),
                          const DataColumn(label: Text('Giá bán')),
                          DataColumn(
                              label: const Text('Giá'),
                              onSort: (index, ascending) =>
                                  (index, ascending) {}),
                          const DataColumn(label: Text('')),
                        ],
                        source: MyDataTable(
                            // ignore: invalid_use_of_protected_member
                            rows: controller.menuDetailRows.value))),
              ),
            ],
          ),
        ),
      ),
    );
  }

  DataRow setMenuDetailRow(int index, MenuDetail menuDetail) {
    return DataRow(
      cells: [
        DataCell(Text((index + 1).toString())),
        DataCell(
          TextDataTable(
            data: menuDetail.food!.code.toString(),
            maxLines: 2,
            width: 100,
          ),
        ),
        DataCell(
          SizedBox(
            width: 100,
            child: Image.network(
              menuDetail.food!.imagePath.toString(),
              fit: BoxFit.fitWidth,
            ),
          ),
        ),
        DataCell(
          TextDataTable(
            data: menuDetail.food!.name.toString(),
            maxLines: 2,
            width: 200,
          ),
        ),
        DataCell(Text(menuDetail.food!.category!.name.toString())),
        DataCell(Text(menuDetail.food!.isCombo! ? 'Combo' : 'Thức ăn')),
        DataCell(Text(Formatter.formatMoney(
            controller.mapMenuDetails[menuDetail.food!.id!].toString()))),
        DataCell(
            Text(Formatter.formatMoney(menuDetail.food!.price.toString()))),
        DataCell(Row(
          children: [
            const Spacer(),
            IconButton(
              icon: const Icon(Icons.edit_outlined),
              onPressed: () {
                showChangeMenuDetailPrice(menuDetail.food!.id!);
              },
            ),
            IconButton(
              icon: const Icon(Icons.remove_circle_outline),
              onPressed: () => controller.removeItemMenuDetails(menuDetail),
            ),
          ],
        )),
      ],
    );
  }

  void showChangeMenuDetailPrice(String foodId) {
    controller.priceController.text =
        controller.mapMenuDetails[foodId].toString();
    Get.dialog(
      AlertDialog(
        title: const Text('Cập nhật giá bán'),
        content: TextField(
          controller: controller.priceController,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(labelText: 'Giá bán'),
        ),
        actions: [
          TextButton(
            onPressed: () {
              double newPrice =
                  double.tryParse(controller.priceController.text) ?? 0.0;
              controller.addItemMenuDetails(foodId, newPrice);
              Get.back(); // Đóng dialog
            },
            child: const Text('Cập nhật'),
          ),
        ],
      ),
    );
  }

  void showAddFoodToMenuDialog() {
    // final MenuFoodController controller = Get.find<MenuFoodController>();
    Get.dialog(
      AlertDialog(
        content: SizedBox(
          height: Get.height * 0.8,
          width: Get.width,
          child: LoadingView(
            future: controller.refreshData,
            child: Obx(
              () => DataTableView(
                title: 'Danh sách sản phẩm',
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
                      onSort: (index, ascending) => (index, ascending) {}),
                  const DataColumn(label: Text('Loại')),
                  const DataColumn(label: Text('Combo')),
                  DataColumn(
                      label: const Text('Giá'),
                      onSort: (index, ascending) => (index, ascending) {}),
                  const DataColumn(label: Text(' ')),
                ],
                // ignore: invalid_use_of_protected_member
                rows: controller.rows.value,
              ),
            ),
          ),
        ),
      ),
    );
  }

  DataRow setRow(int index, Food food) {
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
        DataCell(Text(food.category!.name.toString())),
        DataCell(Text(food.isCombo! ? 'Combo' : 'Thức ăn')),
        DataCell(Text(Formatter.formatMoney(food.price.toString()))),
        DataCell(Row(
          children: [
            const Spacer(),
            IconButton(
              icon: const Icon(Icons.add_circle_outline),
              onPressed: () =>
                  controller.addItemMenuDetails(food.id!, food.price!),
            ),
          ],
        )),
      ],
    );
  }
}
