import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '/models/menu_detail.dart';
import '/models/food.dart';
import '/controllers/menu_create_update_controller.dart';
import '/utils/data_table.dart';
import '/utils/format_data.dart';
import 'loading_page.dart';
import 'widget/paginated_datatable_widget.dart';
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
                    style: Get.textTheme.titleMedium,
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: TextButton(
                      onPressed: showAddFoodToMenuDialog,
                      child: Text('Thêm sản phẩm',
                          style: Get.textTheme.bodyMedium),
                    ),
                  ),
                  const Spacer(flex: 8),
                  Expanded(
                    flex: 1,
                    child: TextButton(
                      onPressed: controller.createMenu,
                      child: Text('Tạo', style: Get.textTheme.bodyMedium),
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: Get.width,
                child: Obx(() => PaginatedDataTable(
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
                        source: MyDataTableSource(
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
        title: Text('Cập nhật giá bán', style: Get.textTheme.titleMedium),
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
            child: Text('Cập nhật', style: Get.textTheme.bodyMedium),
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
          width: Get.width * 0.5,
          child: LoadingView(
            future: controller.fetchData,
            child: const PaginatedDataTableView<MenuCreateController>(
              title: 'Danh sách loại',
              columns: [
                DataColumn(label: Text('Code')),
                DataColumn(label: Text('Hình ảnh')),
                DataColumn(label: Text('Tên sản phẩm')),
                DataColumn(label: Text('Loại')),
                DataColumn(label: Text('Combo')),
                DataColumn(label: Text('Giá')),
                DataColumn(label: Text(' ')),
              ],
            ),
          ),
        ),
      ),
    );
  }

  DataRow setRow(Food food) {
    return DataRow(
      cells: [
        DataCell(Text(food.code.toString())),
        DataCell(
          SizedBox(
            width: 100,
            child: Image.network(
              food.imagePath.toString(),
              fit: BoxFit.fitWidth,
            ),
          ),
        ),
        DataCell(Text(food.name.toString())),
        DataCell(Text(food.category!.name.toString())),
        DataCell(Text(food.isCombo! ? 'Combo' : 'Thức ăn')),
        DataCell(Text(Formatter.formatMoney(food.price.toString()))),
        DataCell(Row(
          children: [
            const Spacer(),
            IconButton(
              icon: const Icon(Iconsax.add_circle),
              onPressed: () =>
                  controller.addItemMenuDetails(food.id!, food.price!),
            ),
          ],
        )),
      ],
    );
  }
}
