import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/models/kitchen.dart';
import '/views/pages/widget/image_default.dart';

class KitchenDetailView extends StatelessWidget {
  const KitchenDetailView(this.kitchen, {super.key});
  final Kitchen kitchen;
  @override
  Widget build(BuildContext context) {
   return Scaffold(
      appBar: AppBar(
        title: const Text('Chi tiết bếp'),
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
                        child: CustomNetworkImage(kitchen.imagePath.toString(),
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
                                  child: Text(kitchen.code.toString(),
                                      style: Get.textTheme.bodyMedium),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Tên bếp: ',
                                    style: Get.textTheme.titleMedium),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Text(kitchen.name.toString(),
                                      style: Get.textTheme.bodyMedium),
                                ),
                              ],
                            ),
                             const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Số trường phụ thuộc: ',
                                    style: Get.textTheme.titleMedium),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Text(kitchen.schoolCount!.toString(),
                                      style: Get.textTheme.bodyMedium),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                           
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Địa chỉ: ',
                                    style: Get.textTheme.titleMedium),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Text('${kitchen.address.toString()}, ${kitchen.area!.ward.toString()}, ${kitchen.area!.district.toString()}, ${kitchen.area!.city.toString()}',
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
