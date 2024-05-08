import 'package:beanfast_menumanager/views/pages/session_detail.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class SessionInformationPage extends StatelessWidget {
  const SessionInformationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chi tiết phiên'),
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text('Code: ', style: Get.textTheme.bodyMedium),
                          const SizedBox(width: 10),
                          Text('Phiên 1', style: Get.textTheme.bodyMedium),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Text('Mã thực đơn: ',
                              style: Get.textTheme.bodyMedium),
                          const SizedBox(width: 10),
                          Text('01-01-2021', style: Get.textTheme.bodyMedium),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Text('Trạng thái: ', style: Get.textTheme.bodyMedium),
                          const SizedBox(width: 10),
                          Text('Đã hoàn thành',
                              style: Get.textTheme.bodyMedium),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Text('Thời gian đặt hàng: ',
                              style: Get.textTheme.bodyMedium),
                          const SizedBox(width: 10),
                          Row(
                            children: [
                              Text('Từ 10:20 01/01/2021',
                                  style: Get.textTheme.bodyMedium),
                              Text(' đến 10:20 01/01/2021',
                                  style: Get.textTheme.bodyMedium),
                            ],
                          ),
                        ],
                      ), const SizedBox(height: 20),
                      Row(
                        children: [
                          Text('Thời gian nhận hàng: ',
                              style: Get.textTheme.bodyMedium),
                          const SizedBox(width: 10),
                          Row(
                            children: [
                              Text('Từ 10:20 01/01/2021',
                                  style: Get.textTheme.bodyMedium),
                              Text(' đến 10:20 01/01/2021',
                                  style: Get.textTheme.bodyMedium),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Text('Cổng giao hàng ', style: Get.textTheme.bodyMedium),
                      const SizedBox(height: 10),
                      Column(
                        children: List.generate(
                          3,
                          (index) => GestureDetector(
                            onTap: () {
                              Get.to(const SessionDetailPage());
                            },
                            child: ListTile(
                              leading: const Icon(
                                Iconsax.location,
                                size: 20,
                              ),
                              title: Text(
                                'Địa điểm ${index + 1}',
                                style: Get.textTheme.bodyMedium,
                              ),
                            ),
                          ),
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
