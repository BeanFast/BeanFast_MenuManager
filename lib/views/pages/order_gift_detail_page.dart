import 'package:beanfast_menumanager/controllers/exchange_gift_controller.dart';
import 'package:beanfast_menumanager/enums/status_enum.dart';
import 'package:beanfast_menumanager/utils/format_data.dart';
import 'package:beanfast_menumanager/views/pages/loading_page.dart';
import 'package:beanfast_menumanager/views/pages/widget/image_default.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';

class OrderGiftDetailScreen extends GetView<ExchangeGiftController> {
  const OrderGiftDetailScreen({super.key, required this.orderGiftId});
  final String orderGiftId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chi tiết đơn quà'),
        centerTitle: true,
      ),
      body: LoadingView(
        future: () => controller.getById(orderGiftId),
        child: Obx(
          () => SingleChildScrollView(
            child: Align(
              alignment: Alignment.topCenter,
              child: Card(
                child: SizedBox(
                  width: Get.width * 0.4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        child: GestureDetector(
                          onTap: () {
                            // Get.to( () => OrderTimeline(
                            //   order: controller.model.value,
                            // ));
                          },
                          child: Column(
                            children: [
                              ListTile(
                                leading:
                                    const Icon(Iconsax.notification_status),
                                title: Text('Trạng thái đơn hàng',
                                    style: Get.textTheme.titleMedium),
                                subtitle: Text(
                                    ExchangeGiftStatus.fromInt(
                                            controller.model.value!.status!)
                                        .message
                                        .toString(),
                                    style: Get.textTheme.bodyMedium),
                              ),
                              ListTile(
                                leading: const Icon(Iconsax.location),
                                title: Text('Địa chỉ nhận hàng',
                                    style: Get.textTheme.titleMedium),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        controller.model.value!.sessionDetail!
                                            .location!.school!.name
                                            .toString(),
                                        style: Get.textTheme.bodyMedium),
                                    Text(
                                        controller.model.value!.sessionDetail!
                                            .location!.name
                                            .toString(),
                                        style: Get.textTheme.bodyMedium),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 5),
                              if (controller.model.value!.sessionDetail!
                                          .session!.deliveryStartTime !=
                                      null &&
                                  controller.model.value!.sessionDetail!
                                          .session!.deliveryEndTime !=
                                      null)
                                ListTile(
                                  leading: const Icon(Iconsax.truck_time),
                                  title: Text('Thời gian nhận hàng',
                                      style: Get.textTheme.titleMedium),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          "Từ ${DateFormat('HH:mm').format(controller.model.value!.sessionDetail!.session!.deliveryStartTime!)} đến ${DateFormat('HH:mm, dd/MM/yy').format(controller.model.value!.sessionDetail!.session!.deliveryEndTime!)}",
                                          style: Get.textTheme.bodyMedium),
                                    ],
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          children: [
                            const SizedBox(height: 5),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(controller.model.value!.profile!.fullName!,
                                    style: Get.textTheme.titleSmall),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Column(
                              children: [
                                SizedBox(
                                  height: 80,
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CustomNetworkImage(
                                        controller
                                            .model.value!.gift!.imagePath!,
                                        width: 80,
                                        height: 80,
                                        fit: BoxFit.cover,
                                      ),
                                      Container(
                                        height: 80,
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                                controller
                                                    .model.value!.gift!.name
                                                    .toString(),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style:
                                                    Get.textTheme.bodyMedium),
                                            Align(
                                              alignment: Alignment.centerRight,
                                              child: Text('x1',
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style:
                                                      Get.textTheme.bodySmall),
                                            ),
                                            Align(
                                              alignment: Alignment.centerRight,
                                              child: Text(
                                                Formatter.formatPoint(
                                                  controller
                                                      .model.value!.gift!.point
                                                      .toString(),
                                                ),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: Get.textTheme.bodySmall!
                                                    .copyWith(
                                                  color: const Color.fromARGB(
                                                      255, 26, 128, 30),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const Divider(thickness: 1, color: Colors.grey),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '1 sản phẩm',
                                  style: Get.textTheme.bodySmall,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'Tổng ',
                                      style: Get.textTheme.bodySmall,
                                    ),
                                    Text(
                                      Formatter.formatPoint(controller
                                          .model.value!.gift!.point
                                          .toString()),
                                      style: Get.textTheme.bodySmall!.copyWith(
                                        color: const Color.fromARGB(
                                            255, 26, 128, 30),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Mã đơn hàng',
                                    style: Get.textTheme.bodyMedium),
                                GestureDetector(
                                  onTap: () {
                                    Get.snackbar(
                                        'Hệ thống', 'Đã sao chép mã đơn hàng',
                                        snackPosition: SnackPosition.TOP);
                                    Clipboard.setData(ClipboardData(
                                        text: controller.model.value!.code
                                            .toString()));
                                  },
                                  child: Text(
                                      '#${controller.model.value!.code.toString()}',
                                      style: Get.textTheme.bodySmall),
                                ),
                              ],
                            ),
                            const SizedBox(height: 5),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Thời gian đặt hàng',
                                    style: Get.textTheme.bodyMedium),
                                Text(
                                    DateFormat('HH:mm dd/MM/yy').format(
                                        controller.model.value!.paymentDate!),
                                    style: Get.textTheme.bodySmall),
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
          ),
        ),
      ),
    );
  }
}
