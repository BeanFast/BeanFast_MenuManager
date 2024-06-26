import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '/models/food.dart';
import '/controllers/food_controller.dart';
import '/contains/theme_color.dart';
import '/utils/format_data.dart';
import 'loading_page.dart';
import 'food_detail.dart';
import 'widget/description_input_widget.dart';
import 'widget/button_data_table.dart';
import 'widget/search_widget.dart';
import 'widget/text_data_table_widget.dart';
import 'widget/image_default.dart';
import 'widget/paginated_datatable_widget.dart';

class FoodView extends GetView<FoodController> {
  const FoodView({super.key});

  @override
  Widget build(BuildContext context) {
    return LoadingView(
      future: controller.fetchData,
      child: Padding(
        padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
        child: SingleChildScrollView(
          child: Column(children: [
             Text(
                'Quản lý món ăn',
                textAlign: TextAlign.start,
                style: Get.textTheme.titleMedium,
              ),
              const SizedBox(height: 10),
            Row(
              children: [
                SearchBox(search: controller.search),
                const Spacer(),
                TextButton(
                  onPressed: () async {
                    await showDialog(false);
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.add_outlined,
                        size: 20,
                      ),
                      Text('Tạo thức ăn', style: Get.textTheme.bodyMedium),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                TextButton(
                  onPressed: () async {
                    await showDialog(true);
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.add_outlined,
                        size: 20,
                      ),
                      Text('Tạo combo', style: Get.textTheme.bodyMedium),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            SizedBox(
                height: Get.height * 0.7,
              child: const PaginatedDataTableView<FoodController>(
                title: 'Danh sách món ăn',
                columns: <DataColumn>[
                  DataColumn2(label: Text('Code')),
                  DataColumn2(label: Text('Hình ảnh')),
                  DataColumn2(label: Text('Tên sản phẩm')),
                  DataColumn2(label: Text('Loại')),
                  DataColumn2(label: Text('Giá')),
                  DataColumn2(label: Text('')),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }

  DataRow setRow(Food food) {
    return DataRow(
      cells: [
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
        DataCell(Text(food.category!.name.toString())),
        DataCell(Text(Formatter.formatMoney(food.price.toString()))),
        DataCell(Row(
          children: [
            const Spacer(),
            // DetailButtonDataTable(
            //     onPressed: () => Get.toNamed('/food-detail?code=${food.code}')),
            DetailButtonDataTable(
                onPressed: () => Get.to(FoodDetailView(food))),
            // EditButtonDataTable(onPressed: () {}),
          ],
        )),
      ],
    );
  }

  Future<void> showDialog(bool isCombo) async {
    controller.clearForm();
    Get.dialog(
      ConstrainedBox(
        constraints: BoxConstraints(maxWidth: Get.width * 0.8),
        child: AlertDialog(
          title: Text('Thông tin món ăn', style: Get.textTheme.titleMedium),
          content: Form(
            key: controller.formCreateKey,
            child: SingleChildScrollView(
              child: SizedBox(
                width: Get.width * 0.8,
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
                        child: TextButton(
                          onPressed: () {
                            controller.pickImage();
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Iconsax.add,
                                size: 20,
                              ),
                              Text('Thay đổi ảnh',
                                  style: Get.textTheme.bodyMedium),
                            ],
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
                    Text('Loại', style: Get.textTheme.bodyMedium),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 5.0, right: 5.0, bottom: 10.0, top: 10.0),
                      child: GestureDetector(
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: ThemeColor.inputColor,
                              width: 0.5,
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
                              child: TextButton(
                                onPressed: showFoodDialog,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(Iconsax.add),
                                    Text('Thêm thức ăn',
                                        style: Get.textTheme.bodyMedium),
                                  ],
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
                                      title: Text('${food.name}',
                                          style: Get.textTheme.bodyMedium),
                                      subtitle: Text(
                                          'Số lượng: ${controller.combos[food.id!]}',
                                          style: Get.textTheme.bodySmall),
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
                                                      title: Text(
                                                          'Cập nhật số lượng',
                                                          style: Get.textTheme
                                                              .titleMedium),
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
            TextButton(
              onPressed: () async {
                await controller.submitForm(isCombo);
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Iconsax.add,
                    size: 20,
                  ),
                  Text('Lưu', style: Get.textTheme.bodyMedium),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showCategoryDialog() {
    Get.dialog(AlertDialog(
      title: Text('Chọn loại', style: Get.textTheme.titleMedium),
      content: LoadingView(
        future: () async {
          await controller.getAllCategory();
        },
        child: SizedBox(
          width: Get.width * 0.5,
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
    var foodCreateController = Get.put(FoodCreateController());
    Get.dialog(
      AlertDialog(
        content: SizedBox(
          height: Get.height * 0.8,
          width: Get.width * 0.8,
          child: LoadingView(
              future: foodCreateController.fetchData,
              child: const PaginatedDataTableView<FoodCreateController>(
                title: 'Danh sách món ăn',
                columns: [
                  DataColumn(label: Text('Code')),
                  DataColumn(label: Text('Hình ảnh')),
                  DataColumn(label: Text('Tên sản phẩm')),
                  DataColumn(label: Text('Giá')),
                  DataColumn(label: Text('Loại')),
                  DataColumn(label: Text(' ')),
                ],
              )),
        ),
      ),
    );
  }

  DataRow setFoodRow(Food food) {
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
        DataCell(Text(Formatter.formatMoney(food.price.toString()))),
        DataCell(Text(food.category!.name.toString())),
        DataCell(Row(
          children: [
            const Spacer(),
            IconButton(
              icon: const Icon(Icons.add_outlined),
              onPressed: () {
                Get.find<FoodCreateController>().addFood(food.id!);
              },
            ),
          ],
        )),
      ],
    );
  }
}
