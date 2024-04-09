import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/controllers/order_controller.dart';

class OrderActivityDialog {
  static showCancelDialog(String orderId) {
    Get.defaultDialog(
      title: 'Hủy đơn hàng',
      content: const Column(
        children: [
          Text('Đơn hàng sẽ được hoàn tiền sau khi hủy.'),
          Text('Xác nhận hủy?'),
        ],
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Get.find<OrderController>().cancelOrder(orderId);
            Get.back();
          },
          child: const Text('Xác nhận'),
        ),
        TextButton(
          child: const Text('Đóng'),
          onPressed: () {
            Get.back();
          },
        ),
      ],
    );
  }
}
