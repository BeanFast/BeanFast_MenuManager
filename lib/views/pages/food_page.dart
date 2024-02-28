import 'package:beanfast_menumanager/models/category.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// import '/utils/logger.dart';
import '/models/food.dart';
import '/controllers/food_controller.dart';
import '/views/pages/widget/button_data_table.dart';
import '/views/pages/widget/text_data_table_widget.dart';
import '/views/pages/widget/data_table_page.dart';

class FoodView extends GetView<FoodController> {
  const FoodView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => DataTableView(
        title: 'Quản lý sản phẩm',
        isShowCreateDialog: true,
        showCreateDialog: showDialog,
        refreshData: controller.refreshData,
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
          DataColumn(
              label: const Text('Giá'),
              onSort: (index, ascending) => controller.sortByPrice(index)),
          const DataColumn(
            label: Text('Loại'),
          ),
          const DataColumn(label: Text('Trạng thái')),
          const DataColumn(label: Text(' ')),
        ],
        // ignore: invalid_use_of_protected_member
        rows: controller.rows.value,
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
        DataCell(Text(food.price.toString())),
        DataCell(Text(food.categoryId.toString())),
        DataCell(Text(food.status.toString())),
        DataCell(Row(
          children: [
            const Spacer(),
            DetailButtonDataTable(
                goToPage: () => Get.toNamed('/food-detail?code=${food.code}')),
            EditButtonDataTable(showDialog: () {}),
            DeleteButtonDataTable(agree: () {}),
          ],
        )),
      ],
    );
  }

  Future<void> showDialog() async {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    await controller.initDialog();
    var selected = controller.listCategories[0];
    Get.dialog(
      ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1000),
        child: AlertDialog(
          title: const Text('Thông tin món ăn'),
          content: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: SizedBox(
                width: 990,
                child: ListBody(
                  mainAxis: Axis.vertical,
                  children: [
                    Obx(() => Padding(
                          padding: const EdgeInsets.only(
                              left: 5.0, right: 5.0, bottom: 10.0, top: 10.0),
                          child: controller.imagePath.isEmpty
                              ? const Text('No image selected')
                              : Image.network(
                                  controller.imagePath.value,
                                  fit: BoxFit.cover,
                                ),
                        )),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 5.0, right: 5.0, bottom: 10.0, top: 10.0),
                      child: FloatingActionButton.extended(
                        icon: const Icon(Icons.add),
                        label: const Text('Chọn Ảnh'),
                        onPressed: () {
                          controller.pickImage();
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 5.0, right: 5.0, bottom: 10.0, top: 10.0),
                      child: TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Tên Sản Phẩm',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Vui lòng nhập tên sản phẩm';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 5.0, right: 5.0, bottom: 10.0, top: 10.0),
                      child: TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Giá',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Vui lòng nhập giá';
                          }
                          // Check if the value is a number
                          if (double.tryParse(value) == null) {
                            return 'Giá không hợp lệ';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 5.0, right: 5.0, bottom: 10.0, top: 10.0),
                      child: DropdownButtonFormField<Category>(
                        value: selected,
                        decoration: const InputDecoration(labelText: 'Loại'),
                        items: controller.listCategories.map((e) {
                          return DropdownMenuItem<Category>(
                            value: e,
                            child: Text(e.name!),
                          );
                        }).toList(),
                        validator: (Category? value) {
                          return value == null
                              ? 'Please select an object'
                              : null;
                        },
                        onChanged: (Category? value) {
                          // selected = value!;
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          actions: <Widget>[
            FloatingActionButton.extended(
              icon: const Icon(Icons.add),
              label: const Text('Lưu'),
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  // Handle form submission
                  Get.back();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
