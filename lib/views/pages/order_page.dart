import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '/controllers/order_controller.dart';
import '/enums/status_enum.dart';
import '/views/pages/loading_page.dart';
import 'widget/order_tabview.dart';

class OrderView extends GetView<OrderController> {
  const OrderView({super.key});
  @override
  Widget build(BuildContext context) {
    Get.put(OrderController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
          child: Column(
            children: [
              Text(
                'Quản lý đơn hàng',
                textAlign: TextAlign.start,
                style: Get.textTheme.titleMedium,
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: GestureDetector(
                      onTap: () {
                        showSelectionSchoolDialog();
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Trường', style: Get.textTheme.bodyLarge),
                          const SizedBox(height: 10),
                          Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.only(
                                top: 6, bottom: 6, left: 10, right: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: Colors.black,
                                width: 0.5,
                              ),
                            ),
                            // ignore: prefer_const_constructors
                            child: Obx(
                              () => Row(
                                children: [
                                  Expanded(
                                    child: SizedBox(
                                      height: 40,
                                      child: Center(
                                        child: Text(
                                          controller.selectedSchool.value ==
                                                  null
                                              ? '--Trống--'
                                              : controller
                                                  .selectedSchool.value!.name
                                                  .toString(),
                                          style: Get.textTheme.bodyMedium!
                                              .copyWith(),
                                          maxLines: 2,
                                        ),
                                      ),
                                    ),
                                  ),
                                  if (controller.selectedSchool.value?.name !=
                                          '--Trống--' &&
                                      controller.selectedSchool.value != null)
                                    GestureDetector(
                                      onTap: () {
                                        controller.selectSchool(null);
                                        controller.selectSessionDetail(null);
                                      },
                                      child: const Icon(
                                        Icons.close,
                                        size: 12,
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    flex: 1,
                    child: GestureDetector(
                      onTap: () {
                        if (controller.selectedSchool.value == null) {
                          Get.snackbar('Thông báo', 'Chưa chọn trường học');
                          return;
                        }
                        showSelectionSessionDialog();
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Khung giờ', style: Get.textTheme.bodyLarge),
                          const SizedBox(height: 10),
                          Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.only(
                                top: 6, bottom: 6, left: 10, right: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: Colors.black,
                                width: 0.5,
                              ),
                            ),
                            // ignore: prefer_const_constructors
                            child: Obx(
                              () => Row(
                                children: [
                                  Expanded(
                                    child: SizedBox(
                                      height: 40,
                                      child: Center(
                                        child: Text(controller
                                                    .selectedSession.value ==
                                                null
                                            ? '--Trống--'
                                            : '${DateFormat('HH:mm dd/MM/yy').format(controller.selectedSession.value!.deliveryStartTime!)} - ${DateFormat('HH:mm dd/MM/yy').format(controller.selectedSession.value!.deliveryEndTime!)}'),
                                      ),
                                    ),
                                  ),
                                  if (controller.selectedSession.value
                                          ?.deliveryStartTime !=
                                      null)
                                    GestureDetector(
                                      onTap: () {
                                        controller.selectSession(null);
                                      },
                                      child: const Icon(
                                        Icons.close,
                                        size: 12,
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    flex: 1,
                    child: GestureDetector(
                      onTap: () {
                        if (controller.selectedSession.value == null) {
                          Get.snackbar('Thông báo', 'Chưa chọn khung giờ');
                          return;
                        }
                        showSelectionSessionDetailDialog();
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Cổng', style: Get.textTheme.bodyLarge),
                          const SizedBox(height: 10),
                          Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.only(
                                top: 6, bottom: 6, left: 10, right: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: Colors.black,
                                width: 0.5,
                              ),
                            ),
                            // ignore: prefer_const_constructors
                            child: Obx(
                              () => Row(
                                children: [
                                  Expanded(
                                    child: SizedBox(
                                      height: 40,
                                      child: Center(
                                        child: Text(controller
                                                    .selectedSessionDetail
                                                    .value ==
                                                null
                                            ? '--Trống--'
                                            : controller.selectedSessionDetail
                                                .value!.location!.name
                                                .toString()),
                                      ),
                                    ),
                                  ),
                                  if (controller.selectedSessionDetail.value !=
                                          null &&
                                      controller.selectedSessionDetail.value !=
                                          null)
                                    GestureDetector(
                                      onTap: () {
                                        controller.selectSessionDetail(null);
                                      },
                                      child: const Icon(
                                        Icons.close,
                                        size: 12,
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Spacer(
                    flex: 7,
                  ),
                ],
              ),
              const SizedBox(height: 10),
              DefaultTabController(
                length: 5,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const TabBar(
                      tabs: [
                        Tab(text: 'Đang chuẩn bị'),
                        Tab(text: 'Đang chế biến'),
                        Tab(text: 'Đang giao'),
                        Tab(text: 'Hoàn thành'),
                        Tab(text: 'Đã hủy'),
                      ],
                    ),
                    SizedBox(
                      height: Get.height * 0.79,
                      child: const TabBarView(
                        children: [
                          OrderTabView(
                            status: OrderStatus.preparing,
                          ), // Đang chuẩn bị
                          OrderTabView(
                            status: OrderStatus.cooking,
                          ), // Đang chế biến
                          OrderTabView(
                            status: OrderStatus.delivering,
                          ), // Đang giao
                          OrderTabView(
                            status: OrderStatus.completed,
                          ), // Hoàn thành
                          OrderTabView(
                            status: OrderStatus.cancelled,
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

  Future<dynamic> showSelectionSessionDetailDialog() {
    return Get.dialog(
      AlertDialog(
        title: Text('Địa điểm', style: Get.textTheme.titleMedium),
        content: SizedBox(
          width: Get.width * 0.3,
          height: Get.height * 0.3,
          child: Column(
            children: [
              TextField(
                onChanged: (value) => {},
                decoration: const InputDecoration(
                  labelText: 'Tìm kiếm',
                ),
                style: Get.theme.textTheme.bodyMedium,
              ),
              const SizedBox(height: 10),
              Expanded(
                child: LoadingView(
                  future: controller.fetchSessionDetailData,
                  child: SingleChildScrollView(
                    child: Obx(() => Column(
                          children: controller.sessionDetailList
                              .map(
                                (sessionDetail) => GestureDetector(
                                  onTap: () {
                                    controller
                                        .selectSessionDetail(sessionDetail);
                                    Get.back();
                                  },
                                  child: Card(
                                    child: ListTile(
                                      title: Text(sessionDetail.location!.name
                                          .toString()),
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                        )),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<dynamic> showSelectionSessionDialog() {
    return Get.dialog(
      AlertDialog(
        title: Text('Khung giờ đặt hàng', style: Get.textTheme.titleMedium),
        content: SizedBox(
          width: Get.width * 0.5,
          height: Get.height * 0.8,
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: SizedBox(
                      height: 40,
                      width: 100,
                      child: TextField(
                        onChanged: (value) => {},
                        decoration: const InputDecoration(
                          labelText: 'Tìm kiếm',
                        ),
                        style: Get.theme.textTheme.bodyMedium,
                      ),
                    ),
                  ),
                  const Spacer(
                    flex: 2,
                  ),
                  GestureDetector(
                    onTap: () {
                      showDatePicker(
                        context: Get.context!,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime.now().add(
                          const Duration(days: 365),
                        ),
                      ).then((pickedDate) {
                        if (pickedDate == null) {
                          return;
                        }
                        controller.setDate(
                            '${pickedDate.day}/${pickedDate.month}/${pickedDate.year}');
                      });
                    },
                    child: Container(
                      width: 200,
                      height: 40,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.only(
                          top: 6, bottom: 6, left: 10, right: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Colors.black,
                          width: 0.5,
                        ),
                      ),
                      // ignore: prefer_const_constructors
                      child: Obx(
                        () => Row(
                          children: [
                            const Icon(
                              Icons.calendar_month,
                              size: 20,
                            ),
                            Expanded(
                              child: Center(
                                child: Text(controller.datePicker.value),
                              ),
                            ),
                            if (controller.datePicker.value != 'Ngày/Tháng/Năm')
                              GestureDetector(
                                onTap: () {
                                  controller.setDate('Ngày/Tháng/Năm');
                                },
                                child: const Icon(
                                  Icons.close,
                                  size: 12,
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              DefaultTabController(
                length: 2,
                child: Expanded(
                  child: Column(
                    children: <Widget>[
                      const TabBar(
                        tabs: [
                          Tab(text: 'Đang hoạt động'),
                          Tab(text: 'Lịch sử'),
                        ],
                      ),
                      Expanded(
                        child: LoadingView(
                          future: controller.fetchSessionData,
                          child: Obx(
                            () => TabBarView(
                              children: [
                                SizedBox(
                                  child: SingleChildScrollView(
                                    child: Column(
                                      children: controller.sessionList
                                          .where((session) =>
                                              session.orderStartTime!
                                                  .isBefore(DateTime.now()) &&
                                              session.orderEndTime!
                                                  .isAfter(DateTime.now()))
                                          .map(
                                            (session) => GestureDetector(
                                              onTap: () {
                                                controller
                                                    .selectSession(session);
                                                Get.back();
                                              },
                                              child: Card(
                                                child: ListTile(
                                                  title: Text(
                                                      '${DateFormat('HH:mm dd/MM/yy').format(session.deliveryStartTime!)} - ${DateFormat('HH:mm dd/MM/yy').format(session.deliveryEndTime!)}'),
                                                ),
                                              ),
                                            ),
                                          )
                                          .toList(),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  child: SingleChildScrollView(
                                    child: Column(
                                      children: controller.sessionList
                                          .where((session) => session
                                              .orderEndTime!
                                              .isBefore(DateTime.now()))
                                          .map(
                                            (session) => GestureDetector(
                                              onTap: () {
                                                controller
                                                    .selectSession(session);
                                                Get.back();
                                              },
                                              child: Card(
                                                child: ListTile(
                                                  title: Text(
                                                      '${DateFormat('HH:mm dd/MM/yy').format(session.deliveryStartTime!)} - ${DateFormat('HH:mm dd/MM/yy').format(session.deliveryEndTime!)}'),
                                                ),
                                              ),
                                            ),
                                          )
                                          .toList(),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<dynamic> showSelectionSchoolDialog() {
    return Get.dialog(
      AlertDialog(
        title: Text('Trường', style: Get.textTheme.titleMedium),
        content: SizedBox(
          width: Get.width * 0.5,
          height: Get.height * 0.8,
          child: Column(
            children: [
              TextField(
                onChanged: (value) => controller.searchSchool(value),
                decoration: const InputDecoration(
                  labelText: 'Tìm kiếm',
                ),
                style: Get.theme.textTheme.bodyMedium,
              ),
              LoadingView(
                future: controller.fetchSchoolData,
                child: Expanded(
                  child: SingleChildScrollView(
                    child: Obx(
                      () => Column(
                        children: controller.schoolList
                            .map(
                              (school) => GestureDetector(
                                onTap: () {
                                  Get.back();
                                  controller.selectSchool(school);
                                },
                                child: Card(
                                  child: ListTile(
                                    title: Text(school.name.toString()),
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
