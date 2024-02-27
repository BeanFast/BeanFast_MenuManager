import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/controllers/food_controller.dart';

void showCreateFoodDialog() {
  final FoodController foodController = Get.find();
  Get.dialog(
    ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 1000),
      child: AlertDialog(
        title: const Text('Thông tin món ăn'),
        content: SingleChildScrollView(
          child: SizedBox(
            width: 990,
            child: ListBody(
              mainAxis: Axis.vertical,
              children: [
                Obx(() => Padding(
                      padding: const EdgeInsets.only(
                          left: 5.0, right: 5.0, bottom: 10.0, top: 10.0),
                      child: foodController.imagePath.isEmpty
                          ? const Text('No image selected')
                          : Image.network(
                              foodController.imagePath.value,
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
                      foodController.pickImage();
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
                  child: DropdownButtonFormField<String>(
                    decoration: const InputDecoration(labelText: 'Loại'),
                    items: <String>[
                      'Loại 1',
                      'Loại 2',
                      'Loại 3',
                      'Loại 4',
                      'Loại 5',
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Vui Lòng chọn loại';
                      }
                      return null;
                    },
                    onChanged: (String? newValue) {},
                  ),
                ),
              ],
            ),
          ),
        ),
        actions: <Widget>[
          FloatingActionButton.extended(
            icon: const Icon(Icons.add),
            label: const Text('Lưu'),
            onPressed: () {},
          ),
        ],
      ),
    ),
  );
}
