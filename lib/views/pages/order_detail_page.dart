import 'package:beanfast_menumanager/enums/status_enum.dart';
import 'package:beanfast_menumanager/views/pages/data_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';

import '/controllers/order_controller.dart';
import '/utils/format_data.dart';
import 'loading_page.dart';
import 'widget/image_default.dart';

class OrderDetailView extends GetView<OrderController> {
  const OrderDetailView(this.orderId, {super.key});
  final String orderId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Chi tiết đơn hàng')),
      ),
      body: LoadingView(
        future: () => controller.fetchOrder(orderId),
        child: Obx(
          () => DataView(
            hasData: controller.order.value != null,
            message: 'Không có dữ liệu',
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 10, left: 10, right: 10, bottom: 10),
              child: SingleChildScrollView(
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
                            child: Column(
                              children: [
                                ListTile(
                                  leading:
                                      const Icon(Iconsax.notification_status),
                                  title: Text('Trạng thái đơn hàng',
                                      style: Get.textTheme.titleMedium),
                                  subtitle: Text(
                                      OrderStatus.fromInt(
                                              controller.order.value!.status!)
                                          .message
                                          .toString(),
                                      style: Get.textTheme.bodyMedium),
                                ),
                                ListTile(
                                  leading: const Icon(Iconsax.location),
                                  title: Text('Địa chỉ nhận hàng',
                                      style: Get.textTheme.titleMedium),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          "Trường: ${controller.order.value!.sessionDetail!.location!.school!.name}",
                                          style: Get.textTheme.bodyMedium),
                                      Text(
                                          "Cổng: ${controller.order.value!.sessionDetail!.location!.name}",
                                          style: Get.textTheme.bodyMedium),
                                    ],
                                  ),
                                ),
                                if (controller.order.value!.sessionDetail!
                                            .session!.deliveryStartTime !=
                                        null &&
                                    controller.order.value!.sessionDetail!
                                            .session!.deliveryEndTime !=
                                        null)
                                  ListTile(
                                    leading: const Icon(Iconsax.truck_time),
                                    title: Text('Thời gian dự kiến nhận hàng',
                                        style: Get.textTheme.titleMedium),
                                    subtitle: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                            "Từ ${DateFormat('HH:mm').format(controller.order.value!.sessionDetail!.session!.deliveryStartTime!)} đến ${DateFormat('HH:mm, dd/MM/yy').format(controller.order.value!.sessionDetail!.session!.deliveryEndTime!)}",
                                            style: Get.textTheme.bodyMedium),
                                      ],
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                          Container(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              children: [
                                const SizedBox(height: 5),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                        controller.order.value!.profile!.fullName
                                            .toString(),
                                        style: Get.textTheme.titleSmall),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Column(
                                  children: controller.order.value!.orderDetails!
                                      .map(
                                        (e) => Column(
                                          children: [
                                            SizedBox(
                                              height: 80,
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  CustomNetworkImage(
                                                    e.food!.imagePath!,
                                                    width: 80,
                                                    height: 80,
                                                    fit: BoxFit.cover,
                                                  ),
                                                  Container(
                                                    height: 80,
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 10),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                            e.food!.name
                                                                .toString(),
                                                            maxLines: 1,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: Get.textTheme
                                                                .bodyMedium),
                                                        Align(
                                                          alignment: Alignment
                                                              .centerRight,
                                                          child: Text(
                                                              'x${e.quantity}',
                                                              maxLines: 1,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style: Get
                                                                  .textTheme
                                                                  .bodySmall),
                                                        ),
                                                        Align(
                                                          alignment: Alignment
                                                              .centerRight,
                                                          child: Text(
                                                            Formatter
                                                                .formatMoney(
                                                              e.price
                                                                  .toString(),
                                                            ),
                                                            maxLines: 1,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: Get.textTheme
                                                                .bodySmall!
                                                                .copyWith(
                                                              color: const Color
                                                                  .fromRGBO(240,
                                                                  103, 24, 1),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const Divider(
                                                thickness: 1,
                                                color: Colors.grey),
                                          ],
                                        ),
                                      )
                                      .toList(),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '${controller.order.value!.orderDetails!.length.toString()} sản phẩm',
                                      style: Get.textTheme.bodySmall,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          'Thành tiền ',
                                          style: Get.textTheme.bodySmall,
                                        ),
                                        Text(
                                          Formatter.formatMoney(controller
                                              .order.value!.totalPrice
                                              .toString()),
                                          style: Get.textTheme.bodySmall!
                                              .copyWith(
                                                  color: const Color.fromRGBO(
                                                      240, 103, 24, 1)),
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Mã đơn hàng',
                                        style: Get.textTheme.bodyMedium),
                                    GestureDetector(
                                      onTap: () {
                                        Get.snackbar('Hệ thống',
                                            'Đã sao chép mã đơn hàng',
                                            snackPosition: SnackPosition.TOP);
                                        Clipboard.setData(ClipboardData(
                                            text: controller.order.value!.code
                                                .toString()));
                                      },
                                      child: Text(
                                          '#${controller.order.value!.code.toString()}',
                                          style: Get.textTheme.bodySmall),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 5),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Thời gian đặt hàng',
                                        style: Get.textTheme.bodyMedium),
                                    Text(
                                        DateFormat('hh:mm dd/MM/yy').format(
                                            controller
                                                .order.value!.paymentDate!),
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
        ),
      ),
    );
  }
}
