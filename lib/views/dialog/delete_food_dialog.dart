import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DeleteDialog {
  final void Function() agree;

  const DeleteDialog({required this.agree});

  showDialog() {
    Get.defaultDialog(
      title: 'Xác nhận',
      content: const Text('Bạn có chắc chắn muốn xoá?'),
      actions: <Widget>[
        TextButton(
          onPressed: agree,
          child: const Text('Đồng ý'),
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
