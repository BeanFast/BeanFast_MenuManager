import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/controllers/food_controller.dart';
import '/enums/status_enum.dart';
import '/models/food.dart';
import '/views/pages/error_page.dart';
import '/views/pages/widget/text_data_table_widget.dart';

class FoodDetailView extends GetView<FoodController> {
  const FoodDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    controller.getByCode(Get.parameters['code']!);
    Rx<Food?> food = controller.model;

    return food.value == null
        ? ErrorView(
            errorMessage: 'Sản phẩm không tồn tại',
            tryAgain: () {},
          )
        : Scaffold(
            appBar: AppBar(
              title: const Center(child: Text('Chi tiết sản phẩm')),
              leading: IconButton(
                  onPressed: () => Get.back(),
                  icon: const Icon(Icons.arrow_back_ios_new)),
            ),
            body: Padding(
              padding: const EdgeInsets.only(
                  top: 40, left: 10, right: 10, bottom: 10),
              child: Obx(() => Column(
                    children: [
                      TextFieldItem(
                          title: 'Code: ', data: food.value!.code.toString()),
                      TextFieldItem(
                          title: 'Tên sản phẩm: ',
                          data: food.value!.name.toString()),
                      TextFieldItem(
                          title: 'Giá: ', data: food.value!.price.toString()),
                      TextFieldItem(
                          title: 'Mô tả: ',
                          data: food.value!.description.toString()),
                      TextFieldItem(
                          title: 'Trạng thái  hoạt động: ',
                          data: FooodStatus.active.message),
                    ],
                  )),
            ),
          );
  }
}
