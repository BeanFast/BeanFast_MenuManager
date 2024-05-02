import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '/contains/theme_color.dart';
import '/views/pages/widget/description_input_widget.dart';
import '/views/pages/loading_page.dart';
import '/utils/format_data.dart';
import '/models/food.dart';
import '/controllers/food_controller.dart';
import '/views/pages/widget/button_data_table.dart';
import '/views/pages/widget/text_data_table_widget.dart';
import '/views/pages/widget/data_table_page.dart';
import 'widget/image_default.dart';

class FoodView extends GetView<FoodController> {
  const FoodView({super.key});

  @override
  Widget build(BuildContext context) {
    return LoadingView(
      future: controller.refreshData,
      child: Obx(
        () => DataTableView(
          title: 'Quản lý sản phẩm',
          header: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: FloatingActionButton.extended(
                  icon: const Icon(Icons.add_outlined),
                  onPressed: () async {
                    await showDialog(false);
                  },
                  label: const Text('Tạo thức ăn'),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: FloatingActionButton.extended(
                  icon: const Icon(Icons.add_outlined),
                  onPressed: () async {
                    await showDialog(true);
                  },
                  label: const Text('Tạo combo'),
                ),
              ),
            ],
          ),
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
            DataColumn(
                label: const Text('Giá'),
                onSort: (index, ascending) => controller.sortByPrice(index)),
            const DataColumn(
              label: Text('Loại'),
            ),
            const DataColumn(label: Text(' ')),
          ],
          // ignore: invalid_use_of_protected_member
          rows: controller.rows.value,
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
            child: CustomNetworkImage(
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
        DataCell(Text(Formatter.formatMoney(food.price.toString()))),
        DataCell(Text(food.category!.name.toString())),
        DataCell(Row(
          children: [
            const Spacer(),
            DetailButtonDataTable(
                onPressed: () => Get.toNamed('/food-detail?code=${food.code}')),
            EditButtonDataTable(onPressed: () {}),
          ],
        )),
      ],
    );
  }

  Future<void> showDialog(bool isCombo) async {
    controller.clearForm();
    Get.dialog(
      ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1000),
        child: AlertDialog(
          title: const Text('Thông tin món ăn'),
          content: Form(
            key: controller.formCreateKey,
            child: SingleChildScrollView(
              child: SizedBox(
                width: 990,
                child: ListBody(
                  mainAxis: Axis.vertical,
                  children: [
                    Obx(() => Padding(
                          padding: const EdgeInsets.only(
                              left: 5.0, right: 5.0, bottom: 10.0, top: 10.0),
                          child: controller.selectedImageFile.value == null
                              ? const Text('Chưa có ảnh')
                              : Image.memory(
                                  controller.selectedImageFile.value!.files
                                      .single.bytes!,
                                  width: 200,
                                  height: 200,
                                ),
                        )),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 5.0, right: 5.0, bottom: 10.0, top: 10.0),
                        child: SizedBox(
                          width: 140,
                          height: 40,
                          child: FloatingActionButton.extended(
                            icon: const Icon(Icons.add),
                            label: const Text('Thay đổi ảnh'),
                            onPressed: () {
                              controller.pickImage();
                            },
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 5.0, right: 5.0, bottom: 10.0, top: 10.0),
                      child: TextFormField(
                        controller: controller.nameText,
                        maxLength: 200,
                        decoration: const InputDecoration(
                          labelText: 'Tên Sản Phẩm',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
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
                        controller: controller.priceText,
                        maxLength: 15,
                        decoration: const InputDecoration(
                          labelText: 'Giá',
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        onChanged: (value) {
                          if (value.isNotEmpty) {
                            final formattedValue =
                                Formatter.formatPriceToString(value);
                            controller.priceText.value =
                                controller.priceText.value.copyWith(
                              text: formattedValue,
                              selection: TextSelection.collapsed(
                                  offset: formattedValue.length),
                            );
                          }
                        },
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Vui lòng nhập giá';
                          }
                          double? price = Formatter.formatPriceToDouble(value);
                          if (price == null) {
                            return 'Giá không hợp lệ';
                          } else {
                            if (price < 1000 || price > 500000) {
                              return 'Giá đồ ăn phải trong khoảng từ 1000 đến 500000';
                            }
                          }
                          return null;
                        },
                      ),
                    ),
                    const Text('Loại'),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 5.0, right: 5.0, bottom: 10.0, top: 10.0),
                      child: GestureDetector(
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: ThemeColor.inputColor,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Obx(
                            () => Text(controller.selectedCategory.value == null
                                ? 'Chưa chọn loại'
                                : '${controller.selectedCategory.value!.name}'),
                          ),
                        ),
                        onTap: () => showCategoryDialog(),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 5.0, right: 5.0, bottom: 10.0, top: 10.0),
                      child: DescriptionInput(
                          quillController: controller.descriptionText),
                    ),
                    if (isCombo)
                      Column(
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 5.0,
                                  right: 5.0,
                                  bottom: 10.0,
                                  top: 10.0),
                              child: SizedBox(
                                height: 40,
                                child: FloatingActionButton.extended(
                                  icon: const Icon(Icons.add),
                                  label: const Text('Thêm thức ăn'),
                                  onPressed: showFoodDialog,
                                ),
                              ),
                            ),
                          ),
                          Obx(
                            () => Column(
                              children: controller.listCombo.map(
                                (food) {
                                  return Card(
                                    child: ListTile(
                                      leading: SizedBox(
                                        width: 50,
                                        height: 50,
                                        child: Image.network(
                                          food.imagePath.toString(),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      title: Text('${food.name}'),
                                      subtitle: Text(
                                          'Số lượng: ${controller.combos[food.id!]}'),
                                      trailing: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          IconButton(
                                              icon: const Icon(
                                                  Icons.edit_outlined),
                                              onPressed: () {
                                                final formKey =
                                                    GlobalKey<FormState>();
                                                Get.dialog(
                                                  Form(
                                                    key: formKey,
                                                    child: AlertDialog(
                                                      title: const Text(
                                                          'Cập nhật số lượng'),
                                                      content: TextFormField(
                                                        controller: controller
                                                            .quantiyText,
                                                        keyboardType:
                                                            TextInputType
                                                                .number,
                                                        inputFormatters: <TextInputFormatter>[
                                                          FilteringTextInputFormatter
                                                              .digitsOnly,
                                                        ],
                                                        decoration:
                                                            const InputDecoration(
                                                                labelText:
                                                                    'Số lượng'),
                                                        validator: (value) {
                                                          if (value == null) {
                                                            return 'Số lượng không hợp lệ';
                                                          } else {
                                                            int quantity =
                                                                int.parse(
                                                                    value);
                                                            if (quantity < 1) {
                                                              return 'Số lượng phải lớn hơn 1';
                                                            }
                                                          }
                                                          return null;
                                                        },
                                                      ),
                                                      actions: [
                                                        TextButton(
                                                          onPressed: () {
                                                            controller
                                                                .quantiyText
                                                                .clear();
                                                            Get.back();
                                                          },
                                                          child: const Text(
                                                              'Đóng'),
                                                        ),
                                                        TextButton(
                                                          onPressed: () {
                                                            if (formKey
                                                                .currentState!
                                                                .validate()) {
                                                              int quantity = int
                                                                  .parse(controller
                                                                      .quantiyText
                                                                      .text);
                                                              controller
                                                                  .updateFood(
                                                                      food.id!,
                                                                      quantity);
                                                              controller
                                                                  .quantiyText
                                                                  .clear();
                                                              Get.back();
                                                            }
                                                          },
                                                          child: const Text(
                                                              'Cập nhật'),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              }),
                                          IconButton(
                                            icon: const Icon(Icons.delete),
                                            onPressed: () {
                                              controller.removeFood(food.id!);
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ).toList(),
                            ),
                          ),
                        ],
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
              onPressed: () async {
                await controller.submitForm(isCombo);
              },
            ),
          ],
        ),
      ),
    );
  }

  void showCategoryDialog() {
    Get.dialog(AlertDialog(
      title: const Text('Chọn loại'),
      content: LoadingView(
        future: () async {
          await controller.getAllCategory();
        },
        child: SizedBox(
          width: Get.width,
          height: Get.height * 0.5,
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: TextField(
                  onChanged: (value) => controller.searchCategory(value),
                  decoration: const InputDecoration(
                    labelText: 'Tìm kiếm',
                  ),
                  style: Get.theme.textTheme.bodyMedium,
                ),
              ),
              SizedBox(
                height: Get.height * 0.44,
                child: SingleChildScrollView(
                  child: Obx(
                    () => Column(
                      children: controller.listCategory.map(
                        (category) {
                          return Card(
                            child: ListTile(
                              title: Text('${category.name}'),
                              onTap: () {
                                Get.back();
                                controller.selectedCategory(category);
                              },
                            ),
                          );
                        },
                      ).toList(),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }

  void showFoodDialog() {
    Get.dialog(
      AlertDialog(
        content: SizedBox(
          height: Get.height * 0.8,
          width: Get.width,
          child: LoadingView(
            future: controller.getAllFood,
            child: Obx(
              () => DataTableView(
                title: 'Danh sách sản phẩm',
                sortColumnIndex: controller.columnIndex.value,
                sortAscending: controller.columnAscending.value,
                search: (value) => controller.searchFood(value),
                refreshData: controller.getAllFood,
                loadPage: (page) => (page),
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
                          controller.sortByName(index)),
                  DataColumn(
                      label: const Text('Giá'),
                      onSort: (index, ascending) =>
                          controller.sortByPrice(index)),
                  const DataColumn(
                    label: Text('Loại'),
                  ),
                  const DataColumn(label: Text(' ')),
                ],
                // ignore: invalid_use_of_protected_member
                rows: controller.foodRows.value,
              ),
            ),
          ),
        ),
      ),
    );
  }

  DataRow setFoodRow(int index, Food food) {
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
        DataCell(Text(Formatter.formatMoney(food.price.toString()))),
        DataCell(Text(food.category!.name.toString())),
        DataCell(Row(
          children: [
            const Spacer(),
            IconButton(
              icon: const Icon(Icons.add_outlined),
              onPressed: () {
                controller.addFood(food.id!);
              },
            ),
          ],
        )),
      ],
    );
  }
}
