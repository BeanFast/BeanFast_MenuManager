import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/contains/theme_color.dart';

class OrderDialogs {
  static void showCancelOrderDialog(String orderId, Future<dynamic> Function(String orderId, String reason) cancelOrder) {
    
    final TextEditingController reasonCancelOrderText = TextEditingController();
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    Get.dialog(
      AlertDialog(
        surfaceTintColor: Colors.white,
        backgroundColor: ThemeColor.bgColor,
        title: const Text('Lý do bạn muốn huỷ đơn hàng?'),
        content: Form(
          key: formKey,
          child: SizedBox(
              width: Get.width * 0.8,
              child: TextFormField(
                controller: reasonCancelOrderText,
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
              if (formKey.currentState!.validate()) {
                Get.back();
                await cancelOrder(orderId, reasonCancelOrderText.text);
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
