import 'package:beanfast_menumanager/views/pages/widget/order_cancelled_tabview.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/models/order.dart';
import '/controllers/order_controller.dart';
import '/views/pages/widget/pickedDate_widget.dart';
import 'widget/order_completed_tabview.dart';
import 'widget/order_delivering_tabview.dart';
import 'widget/order_preparing_tabview.dart';

class OrderView extends GetView<OrderController> {
  const OrderView({super.key});
  @override
  Widget build(BuildContext context) {
    Get.put(OrderPreparingController());
    Get.put(OrderDeliveringController());
    Get.put(OrderCompletedController());
    Get.put(OrderCancelledController());
    
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
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: PickedDateView(
                      label: 'Từ ngày',
                      onTap: () {},
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: PickedDateView(
                      label: 'Đến ngày',
                      onTap: () {},
                    ),
                  ),
                  const Spacer(flex: 3),
                ],
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
                          OrderPreparingTabView(), // Đang chuẩn bị
                          OrderDeliveringTabView(), // Đang giao
                          OrderCompletedTabView(), // Hoàn thành
                          OrderCancelledTabView(), // Đã hủy
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
