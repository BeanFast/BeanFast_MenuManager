import 'package:beanfast_menumanager/services/menu_serivce.dart';
import 'package:beanfast_menumanager/utils/logger.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DeleteDialog {
  void Function() onPressed = () {};

  DeleteDialog({required this.onPressed});

  showDialog() {
    Get.defaultDialog(
      title: 'Xác nhận',
      content: const Text('Bạn có chắc chắn muốn xoá?'),
      actions: <Widget>[
        TextButton(
          onPressed: onPressed,
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

  showDialogMenu(String id) {
    logger.i(id);
    Get.defaultDialog(
      title: 'Thông báo',
      content: const Text('Bạn không thể xóa khi thực đơn đang hoạt động.'),
      actions: <Widget>[
        TextButton(
          child: const Text('Đóng'),
          onPressed: () async {
            print(await MenuService().delete(id));
          },
        ),
      ],
    );
  }

  showDialogSession() {
    Get.defaultDialog(
      title: 'Xác nhận',
      content: const Column(
        children: [
          Text('Xóa thực đơn sẽ hoàn trả tất cả đơn hàng đã được bán.'),
          Text('Bạn có chắc chắn muốn xoá?'),
        ],
      ),
      actions: <Widget>[
        TextButton(
          onPressed: onPressed,
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
