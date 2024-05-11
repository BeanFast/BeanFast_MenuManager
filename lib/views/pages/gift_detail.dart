import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/models/gift.dart';
import '/views/pages/widget/image_default.dart';

class GiftDetailView extends StatelessWidget {
  const GiftDetailView(this.gift, {super.key});
  final Gift gift;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chi tiết quà tặng'),
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
                        child: CustomNetworkImage(gift.imagePath.toString(),
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
                                  child: Text(gift.code.toString(),
                                      style: Get.textTheme.bodyMedium),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Tên quà: ',
                                    style: Get.textTheme.titleMedium),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Text(gift.name.toString(),
                                      style: Get.textTheme.bodyMedium),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Điểm: ',
                                    style: Get.textTheme.titleMedium),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Text(gift.point.toString(),
                                      style: Get.textTheme.bodyMedium),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Tồn kho: ',
                                    style: Get.textTheme.titleMedium),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Text(gift.inStock.toString(),
                                      style: Get.textTheme.bodyMedium),
                                ),
                              ],
                            ),
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
