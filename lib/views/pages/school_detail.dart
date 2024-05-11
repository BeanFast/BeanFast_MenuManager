import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/school.dart';
import '/views/pages/widget/image_default.dart';

class SchoolDetailView extends StatelessWidget {
  const SchoolDetailView(this.school, {super.key});
  final School school;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chi tiết trường học'),
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
                        child: CustomNetworkImage(school.imagePath.toString(),
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
                                  child: Text(school.code.toString(),
                                      style: Get.textTheme.bodyMedium),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Tên trường: ',
                                    style: Get.textTheme.titleMedium),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Text(school.name.toString(),
                                      style: Get.textTheme.bodyMedium),
                                ),
                              ],
                            ),
                             const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Số cổng: ',
                                    style: Get.textTheme.titleMedium),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Text(school.locations!.length.toString(),
                                      style: Get.textTheme.bodyMedium),
                                ),
                              ],
                            ),
                             const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Số học sinh: ',
                                    style: Get.textTheme.titleMedium),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Text(school.studentCount.toString(),
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
                                  child: Text(
                                      '${school.address.toString()}, ${school.area!.ward.toString()}, ${school.area!.district.toString()}, ${school.area!.city.toString()}',
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
