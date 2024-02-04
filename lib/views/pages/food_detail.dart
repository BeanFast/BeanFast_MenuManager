import 'package:beanfast_menumanager/controllers/food_controller.dart';
import 'package:beanfast_menumanager/enums/status_enum.dart';
import 'package:beanfast_menumanager/models/food.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/views/pages/widget/text_data_table_widget.dart';

class FoodDetailView extends StatelessWidget {
  const FoodDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    FoodController foodController = Get.find();
    foodController.currentCode = Get.parameters['code']!;
    Food food = foodController.getByCode(foodController.currentCode);
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Chi tiết sản phẩm')),
        leading: IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(Icons.arrow_back_ios_new)),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 40, left: 300, right: 10, bottom: 10),
        child: Column(
          children: [
            TextFieldItem(title: 'Code: ', data: food.code.toString()),
            TextFieldItem(title: 'Tên sản phẩm: ', data: food.name.toString()),
            TextFieldItem(title: 'Giá: ', data: food.price.toString()),
            TextFieldItem(title: 'Mô tả: ', data: food.description.toString()),
            TextFieldItem(
                title: 'Trạng thái  hoạt động: ', data: Status.active.message),
          ],
        ),
      ),
    );
  }
}
