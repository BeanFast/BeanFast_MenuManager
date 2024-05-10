import 'package:beanfast_menumanager/utils/format_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/enums/status_enum.dart';
import '/models/food.dart';
import '/views/pages/widget/image_default.dart';

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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(14),
                        child: CustomNetworkImage(food.imagePath.toString(),
                            height: Get.height * 0.3, width: Get.height * 0.3),
                      ),
                      const SizedBox(width: 40),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Code: ',
                                    style: Get.textTheme.titleMedium),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Text(food.code.toString(),
                                      style: Get.textTheme.bodyMedium),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Tên sản phẩm: ',
                                    style: Get.textTheme.titleMedium),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Text(food.name.toString(),
                                      style: Get.textTheme.bodyMedium),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Giá: ', style: Get.textTheme.titleMedium),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                      Formatter.formatMoney(
                                          food.price.toString()),
                                      style: Get.textTheme.bodyMedium),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Mô tả: ',
                                    style: Get.textTheme.titleMedium),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Text(food.description.toString(),
                                      style: Get.textTheme.bodyMedium),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Trạng thái hoạt động: ',
                                    style: Get.textTheme.titleMedium),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Text(FooodStatus.active.message,
                                      style: Get.textTheme.bodyMedium),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                          ],
                        ),
                      ),
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
