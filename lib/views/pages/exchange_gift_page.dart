import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/enums/status_enum.dart';
import 'widget/exchange_gift_tabview.dart';

class ExchangeGiftView extends StatelessWidget {
  const ExchangeGiftView({super.key});
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
                  'Quản lý đơn quà',
                  textAlign: TextAlign.start,
                  style: Get.textTheme.titleMedium,
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
                          ExchangeGiftTabView(
                            status: ExchangeGiftStatus.preparing,
                          ), // Đang chuẩn bị
                          ExchangeGiftTabView(
                            status: ExchangeGiftStatus.delivering,
                          ), // Đang giao
                          ExchangeGiftTabView(
                            status: ExchangeGiftStatus.completed,
                          ), // Hoàn thành
                          ExchangeGiftTabView(
                            status: ExchangeGiftStatus.cancelled,
                          ), // Đã hủy
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
