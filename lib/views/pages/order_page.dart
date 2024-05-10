import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/enums/status_enum.dart';
// import '/controllers/order_controller.dart';
import 'widget/order_tabview.dart';

class OrderView extends StatelessWidget {
  const OrderView({super.key});
  @override
  Widget build(BuildContext context) {
    TmpController controller = Get.put(TmpController());
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
                  style: Get.textTheme.titleMedium,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: GestureDetector(
                      onTap: () {
                        dialog1(controller);
                      },
                      child: Container(
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
                                child: Center(
                                  child: Text(controller.box1.value),
                                ),
                              ),
                              if (controller.box1.value != '--Trống--')
                                GestureDetector(
                                  onTap: () {
                                    controller.setTextBox1('--Trống--');
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
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    flex: 1,
                    child: GestureDetector(
                      onTap: () {
                        dialog2(context, controller);
                      },
                      child: Container(
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
                                child: Center(
                                  child: Text(controller.box2.value),
                                ),
                              ),
                              if (controller.box2.value != '--Trống--')
                                GestureDetector(
                                  onTap: () {
                                    controller.setTextBox2('--Trống--');
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
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    flex: 1,
                    child: GestureDetector(
                      onTap: () {
                        dialog3(controller);
                      },
                      child: Container(
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
                                child: Center(
                                  child: Text(controller.box3.value),
                                ),
                              ),
                              if (controller.box3.value != '--Trống--')
                                GestureDetector(
                                  onTap: () {
                                    controller.setTextBox3('--Trống--');
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
                  ),
                  const Spacer(
                    flex: 7,
                  ),
                ],
              ),
              const SizedBox(height: 10),
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

  Future<dynamic> dialog3(TmpController controller) {
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
              SizedBox(
                height: Get.height * 0.22,
                child: SingleChildScrollView(
                  child: Column(
                    children: List.generate(
                      10,
                      (index) => GestureDetector(
                        onTap: () {
                          controller.setTextBox3('Trường THPT Nguyễn Trãi');
                          Get.back();
                        },
                        child: const Card(
                          child: ListTile(
                            title: Text('Trường THPT Nguyễn Trãi'),
                          ),
                        ),
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

  Future<dynamic> dialog2(BuildContext context, TmpController controller) {
    return Get.dialog(
      AlertDialog(
        title: Text('Số sản phẩm', style: Get.textTheme.titleMedium),
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
                        context: context,
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
                          Tab(text: 'Tab 1'),
                          Tab(text: 'Tab 2'),
                        ],
                      ),
                      Expanded(
                        child: TabBarView(
                          children: [
                            SizedBox(
                              child: SingleChildScrollView(
                                child: Column(
                                  children: List.generate(
                                    20,
                                    (index) => GestureDetector(
                                      onTap: () {
                                        controller.setTextBox2('Code $index');
                                        Get.back();
                                      },
                                      child: Card(
                                        child: ListTile(
                                          title: Text('Code $index'),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            // Add the content for Tab 2 here
                            SizedBox(
                              child: SingleChildScrollView(
                                child: Column(
                                  children: List.generate(
                                    10,
                                    (index) => GestureDetector(
                                      onTap: () {
                                        controller.setTextBox2('Code $index');
                                        Get.back();
                                      },
                                      child: Card(
                                        child: ListTile(
                                          title: Text('Code $index'),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
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

  Future<dynamic> dialog1(TmpController controller) {
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
              SizedBox(
                height: Get.height * 0.22,
                child: SingleChildScrollView(
                  child: Column(
                    children: List.generate(
                      10,
                      (index) => GestureDetector(
                        onTap: () {
                          controller.setTextBox1('Trường THPT Nguyễn Trãi');
                          Get.back();
                        },
                        child: const Card(
                          child: ListTile(
                            title: Text('Trường THPT Nguyễn Trãi'),
                          ),
                        ),
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

class TmpController extends GetxController {
  RxString box1 = '--Trống--'.obs;
  void setTextBox1(String value) {
    box1.value = value;
  }

  RxString box2 = '--Trống--'.obs;
  void setTextBox2(String value) {
    box2.value = value;
  }

  RxString box3 = '--Trống--'.obs;
  void setTextBox3(String value) {
    box3.value = value;
  }

  RxString datePicker = 'Ngày/Tháng/Năm'.obs;
  void setDate(String value) {
    datePicker.value = value;
  }
}
