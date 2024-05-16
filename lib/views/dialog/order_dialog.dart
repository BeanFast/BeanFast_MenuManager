import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/controllers/order_controller.dart';
import '/contains/theme_color.dart';

class OrderDialogs {
  static void showCancelOrderDialog(String orderId) {
    OrderController controller = Get.find();
    controller.reasonCancelOrderText.clear();
    Get.dialog(
      AlertDialog(
        surfaceTintColor: Colors.white,
        backgroundColor: ThemeColor.bgColor,
        title: const Text('Lý do bạn muốn huỷ đơn hàng?'),
        content: Form(
          key: controller.formKey,
          child: SizedBox(
              // height: Get.height / 2,
              width: Get.width * 0.8,
              child: TextFormField(
                controller: controller.reasonCancelOrderText,
                decoration: const InputDecoration(),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Vui lòng nhập lý do';
                  }
                  return null;
                },
              )),
        ),
        actions: [
          TextButton(
            onPressed: () async {
              if (controller.formKey.currentState!.validate()) {
                Get.back();
                await controller.cancelOrder(orderId);
              }
            },
            child: Text('Huỷ đơn hàng',
                style: Get.textTheme.bodyMedium!.copyWith(color: Colors.red)),
          ),
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: Text('Đóng', style: Get.textTheme.bodyMedium),
          ),
        ],
      ),
    );
  }
}
