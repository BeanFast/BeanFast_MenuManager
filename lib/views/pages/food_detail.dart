import 'package:beanfast_menumanager/utils/format_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '/views/pages/widget/image_default.dart';
import '/models/food.dart';
import '/enums/status_enum.dart';
import 'widget/row_info_item_widget.dart';

class FoodDetailView extends StatelessWidget {
  const FoodDetailView(this.food, {super.key});
  final Food food;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chi tiết sản phẩm'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              child: Card(
                child: Container(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text('Code: ', style: Get.textTheme.bodyMedium),
                          const SizedBox(width: 10),
                          Text(food.code.toString(),
                              style: Get.textTheme.bodyMedium),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Text('Tên sản phẩm: ',
                              style: Get.textTheme.bodyMedium),
                          const SizedBox(width: 10),
                          Text(food.name.toString(),
                              style: Get.textTheme.bodyMedium),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Text('Giá: ', style: Get.textTheme.bodyMedium),
                          const SizedBox(width: 10),
                          Text(Formatter.formatMoney(food.price.toString()),
                              style: Get.textTheme.bodyMedium),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Text('Mô tả: ', style: Get.textTheme.bodyMedium),
                          const SizedBox(width: 10),
                          Text(food.description.toString(),
                              style: Get.textTheme.bodyMedium),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Text('Trạng thái hoạt động: ',
                              style: Get.textTheme.bodyMedium),
                          const SizedBox(width: 10),
                          Text(FooodStatus.active.message,
                              style: Get.textTheme.bodyMedium),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                           Text('Ảnh: ',
                              style: Get.textTheme.bodyMedium),
                               const SizedBox(width: 10),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(14),
                            child: CustomNetworkImage(food.imagePath.toString(),
                                height: Get.height * 0.3, width: Get.height * 0.3),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
