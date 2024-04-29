import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/enums/status_enum.dart';
// import '/controllers/order_controller.dart';
import 'widget/order_tabview.dart';

class OrderView extends StatelessWidget {
  const OrderView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding:
              const EdgeInsets.only(top: 40, left: 10, right: 10, bottom: 10),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Text(
                  'Quản lý đơn hàng',
                  textAlign: TextAlign.start,
                  style: Get.textTheme.headlineMedium,
                ),
              ),
              DefaultTabController(
                length: 4,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const TabBar(
                      tabs: [
                        Tab(text: 'Đang chuẩn bị'),
                        Tab(text: 'Đang giao'),
                        Tab(text: 'Hoàn thành'),
                        Tab(text: 'Đã hủy'),
                      ],
                    ),
                    SizedBox(
                      height: Get.height * 0.8,
                      child: const TabBarView(
                        children: [
                          OrderTabView(
                            status: OrderStatus.preparing,
                          ), // Đang chuẩn bị
                          OrderTabView(
                            status: OrderStatus.delivering,
                          ), // Đang giao
                          OrderTabView(
                            status: OrderStatus.completed,
                          ), // Hoàn thành
                          OrderTabView(
                            status: OrderStatus.cancelled,
                          ), // Đã hủy
                          // OrderDeliveringTabView(), // Đang giao
                          // OrderCompletedTabView(), // Hoàn thành
                          // OrderCancelledTabView(), // Đã hủy
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
