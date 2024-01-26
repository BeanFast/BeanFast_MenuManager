import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showCreateGateDialog() {
  Get.dialog(
    ConstrainedBox(
      constraints: BoxConstraints(maxWidth: 700),
      child: AlertDialog(
        title: const Text('Thông tin cổng trường học'),
        content: SingleChildScrollView(
          child: SizedBox(
            width: 690,
            child: ListBody(
              mainAxis: Axis.vertical,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                      left: 5.0, right: 5.0, bottom: 10.0, top: 10.0),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Tên cổng trường học',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Vui lòng nhập tên cổng trường';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 5.0, right: 5.0, bottom: 10.0, top: 10.0),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Mô tả',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Vui lòng nhập mô tả';
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        actions: <Widget>[
          FloatingActionButton.extended(
            label: const Text('Lưu'),
            onPressed: () {},
          ),
        ],
      ),
    ),
  );
}
