import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/models/category.dart';
import '/views/pages/widget/image_default.dart';

class CategoryDetailView extends StatelessWidget {
  const CategoryDetailView(this.category, {super.key});
  final Category category;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chi tiết loại sản phẩm'),
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
                        child: CustomNetworkImage(category.imagePath.toString(),
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
                                  child: Text(category.code.toString(),
                                      style: Get.textTheme.bodyMedium),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Tên loại: ',
                                    style: Get.textTheme.titleMedium),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Text(category.name.toString(),
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
