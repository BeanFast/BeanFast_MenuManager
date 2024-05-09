import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';

import '/contains/theme_color.dart';
import '/models/order.dart';
import '/controllers/menu_detail_controller.dart';
import 'widget/image_default.dart';
import '/utils/format_data.dart';

class OrderDetailView extends StatelessWidget {
  const OrderDetailView(this.order, {super.key});
  final Order order;

  @override
  Widget build(BuildContext context) {
    Get.put(MenuDetailController());

    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Chi tiết đơn hàng')),
      ),
      body: Padding(
        padding:
            const EdgeInsets.only(top: 40, left: 10, right: 10, bottom: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                color: ThemeColor.bgColor,
                padding: const EdgeInsets.all(10),
                child: Container(
                  color: ThemeColor.bgColor,
                  child: Column(
                    children: [
                      // ListTile(
                      //   leading: const Icon(Iconsax.location),
                      //   title: const Text('Địa chỉ nhận hàng'),
                      //   subtitle: Column(
                      //     crossAxisAlignment: CrossAxisAlignment.start,
                      //     children: [
                      //       Text(order.sessionDetail!.location!.school!.name
                      //           .toString()),
                      //       Text(order.sessionDetail!.location!.name
                      //           .toString()),
                      //     ],
                      //   ),
                      // ),
                      const SizedBox(height: 5),
                      if (order.sessionDetail!.session!.deliveryStartTime !=
                              null &&
                          order.sessionDetail!.session!.deliveryEndTime !=
                              null)
                        ListTile(
                          leading: const Icon(Iconsax.truck_time),
                          title: Text('Thời gian dự kiến nhận hàng',
                              style: Get.textTheme.bodyMedium),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  "Từ ${DateFormat('HH:mm').format(order.sessionDetail!.session!.deliveryStartTime!)} đến ${DateFormat('HH:mm, dd/MM/yy').format(order.sessionDetail!.session!.deliveryEndTime!)}",
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
                color: ThemeColor.bgColor,
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    const SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(order.profile!.fullName.toString(),
                            style: Get.textTheme.titleSmall),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Column(
                      children: order.orderDetails!
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
                                            const EdgeInsets.only(left: 10),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(e.food!.name.toString(),
                                                maxLines: 1,
                                                overflow:
                                                    TextOverflow.ellipsis,
                                                style:
                                                    Get.textTheme.bodyMedium),
                                            Align(
                                              alignment:
                                                  Alignment.centerRight,
                                              child: Text('x${e.quantity}',
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: Get
                                                      .textTheme.bodySmall),
                                            ),
                                            Align(
                                              alignment:
                                                  Alignment.centerRight,
                                              child: Text(
                                                Formatter.formatMoney(
                                                  e.price.toString(),
                                                ),
                                                maxLines: 1,
                                                overflow:
                                                    TextOverflow.ellipsis,
                                                style: Get
                                                    .textTheme.bodySmall!
                                                    .copyWith(
                                                  color: const Color.fromRGBO(
                                                      240, 103, 24, 1),
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
                                    thickness: 1, color: Colors.grey),
                              ],
                            ),
                          )
                          .toList(),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${order.orderDetails!.length.toString()} sản phẩm',
                          style: Get.textTheme.bodySmall,
                        ),
                        Row(
                          children: [
                            Text(
                              'Thành tiền ',
                              style: Get.textTheme.bodySmall,
                            ),
                            Text(
                              Formatter.formatMoney(
                                  order.totalPrice.toString()),
                              style: Get.textTheme.bodySmall!.copyWith(
                                  color:
                                      const Color.fromRGBO(240, 103, 24, 1)),
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
                color: ThemeColor.bgColor,
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Mã đơn hàng', style: Get.textTheme.bodyMedium),
                        GestureDetector(
                          onTap: () {
                            Get.snackbar(
                                'Hệ thống', 'Đã sao chép mã đơn hàng',
                                snackPosition: SnackPosition.TOP);
                            Clipboard.setData(
                                ClipboardData(text: order.code.toString()));
                          },
                          child: Text('#${order.code.toString()}',
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
                            DateFormat('hh:mm dd/MM/yy')
                                .format(order.paymentDate!),
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
    );
  }
}
