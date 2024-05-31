import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';

import '/controllers/session_created_controller.dart';
import '/views/pages/loading_page.dart';

class CreateSessionPage extends GetView<SessionCreatedController> {
  final String schoolId;
  const CreateSessionPage({super.key, required this.schoolId});

  @override
  Widget build(BuildContext context) {
    Get.put(SessionCreatedController());
    controller.schoolId = schoolId;
    return LoadingView(
      future: controller.freshData,
      child: Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.only(top: 50, left: 10, right: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 3,
                child: Obx(
                  () => Container(
                    margin: const EdgeInsets.only(left: 20, right: 100),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 40,
                          child: Text(
                            'Danh sách menu',
                            style: Get.textTheme.titleMedium,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              children: controller.listMenu.map((menu) {
                                return Container(
                                  margin: const EdgeInsets.only(bottom: 10),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.black, width: 0.5),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: GestureDetector(
                                    onTap: () {
                                      controller.updateSelectedValue(menu.id!);
                                    },
                                    child: ListTile(
                                      title: Text('Mã: ${menu.code}'),
                                      subtitle: Text(
                                          'Số lượng sản phẩm: ${menu.menuDetails!.length}'),
                                      leading: Obx(
                                        () => Radio<String>(
                                          value: menu.id!,
                                          groupValue:
                                              controller.selectedMenuId.value,
                                          onChanged: (String? value) {
                                            if (value != null) {
                                              controller
                                                  .updateSelectedValue(value);
                                            }
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: SingleChildScrollView(
                  child: Container(
                    margin: const EdgeInsets.only(left: 20, right: 50),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 40,
                          child: Text(
                            'Thông tin session',
                            style: Get.textTheme.titleMedium,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Thời gian đặt hàng',
                          style: Get.textTheme.bodyMedium,
                        ),
                        const SizedBox(height: 10),
                        GestureDetector(
                          onTap: () async {
                            var orderStartTime = await pickDate();
                            if (orderStartTime != null) {
                              if (isValidTime(orderStartTime)) {
                                if (controller.orderEndTime.value != null) {
                                  if (orderStartTime.isAfter(
                                      controller.orderEndTime.value!)) {
                                    Get.snackbar('Thất bại',
                                        'Thời gian đặt hàng không hợp lệ');
                                    return;
                                  }
                                }
                                controller.orderStartTime.value =
                                    orderStartTime;
                              }
                            }
                          },
                          child: Container(
                            alignment: Alignment.centerLeft,
                            width: double.infinity,
                            height: 50,
                            decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.black, width: 0.5),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            padding: const EdgeInsets.all(10),
                            child: Obx(
                              () => Text(
                                controller.orderStartTime.value == null
                                    ? 'Trống'
                                    : DateFormat('HH:mm - dd/MM/yyyy').format(
                                        controller.orderStartTime.value!),
                                style: Get.textTheme.bodyMedium,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        GestureDetector(
                          onTap: () async {
                            var orderEndTime = await pickDate();
                            if (orderEndTime != null) {
                              if (isValidTime(orderEndTime)) {
                                if (controller.orderStartTime.value != null) {
                                  if (controller.orderStartTime.value!
                                      .isAfter(orderEndTime)) {
                                    Get.snackbar('Thất bại',
                                        'Thời gian đặt hàng không hợp lệ');
                                    return;
                                  }
                                }
                                controller.orderEndTime.value = orderEndTime;
                              }
                            }
                          },
                          child: Container(
                            alignment: Alignment.centerLeft,
                            width: double.infinity,
                            height: 50,
                            decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.black, width: 0.5),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            padding: const EdgeInsets.all(10),
                            child: Obx(() => Text(
                                  controller.orderEndTime.value == null
                                      ? 'Trống'
                                      : DateFormat('HH:mm - dd/MM/yyyy').format(
                                          controller.orderEndTime.value!),
                                  style: Get.textTheme.bodyMedium,
                                )),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'Thời gian giao hàng',
                          style: Get.textTheme.bodyMedium,
                        ),
                        const SizedBox(height: 10),
                        GestureDetector(
                          onTap: () async {
                            var deliveryStartTime = await pickDate();
                            if (deliveryStartTime != null) {
                              if (isValidTime(deliveryStartTime) &&
                                  isValidDeliveryStartTime(deliveryStartTime)) {
                                if (controller.deliveryEndTime.value != null) {
                                  if (deliveryStartTime.isAfter(
                                      controller.deliveryEndTime.value!)) {
                                    Get.snackbar('Thất bại',
                                        'Thời gian giao hàng không hợp lệ');
                                    return;
                                  }
                                }
                                controller.deliveryStartTime.value =
                                    deliveryStartTime;
                              }
                            }
                          },
                          child: Container(
                            alignment: Alignment.centerLeft,
                            width: double.infinity,
                            height: 50,
                            decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.black, width: 0.5),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            padding: const EdgeInsets.all(10),
                            child: Obx(() => Text(
                                  controller.deliveryStartTime.value == null
                                      ? 'Trống'
                                      : DateFormat('HH:mm - dd/MM/yyyy').format(
                                          controller.deliveryStartTime.value!),
                                  style: Get.textTheme.bodyMedium,
                                )),
                          ),
                        ),
                        const SizedBox(height: 10),
                        GestureDetector(
                          onTap: () async {
                            var deliveryEndTime = await pickDate();
                            if (deliveryEndTime != null) {
                              if (isValidTime(deliveryEndTime) &&
                                  isValidDeliveryStartTime(deliveryEndTime)) {
                                if (controller.deliveryStartTime.value !=
                                    null) {
                                  if (controller.deliveryStartTime.value!
                                      .isAfter(deliveryEndTime)) {
                                    Get.snackbar('Thất bại',
                                        'Thời gian giao hàng không hợp lệ');
                                    return;
                                  }
                                }
                                controller.deliveryEndTime.value =
                                    deliveryEndTime;
                              }
                            }
                          },
                          child: Container(
                            alignment: Alignment.centerLeft,
                            width: double.infinity,
                            height: 50,
                            decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.black, width: 0.5),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            padding: const EdgeInsets.all(10),
                            child: Obx(() => Text(
                                  controller.deliveryEndTime.value == null
                                      ? 'Trống'
                                      : DateFormat('HH:mm - dd/MM/yyyy').format(
                                          controller.deliveryEndTime.value!),
                                  style: Get.textTheme.bodyMedium,
                                )),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'Địa điểm giao',
                          style: Get.textTheme.bodyMedium,
                        ),
                        const SizedBox(height: 10),
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 0.5),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          height: 200,
                          child: SingleChildScrollView(
                            child: Obx(
                              () => Column(
                                children: controller.school.value.locations!
                                    .map(
                                      (location) => Container(
                                        margin: const EdgeInsets.only(
                                            bottom: 2.5, top: 2.5),
                                        child: Row(
                                          children: <Widget>[
                                            Obx(
                                              () => Expanded(
                                                child: CheckboxListTile(
                                                  title: Text(
                                                      '${location.name}',
                                                      style: Get.textTheme
                                                          .bodyMedium),
                                                  subtitle: Text(
                                                      'Người giao hàng: ${controller.selectedDeliverers[location.id]?.fullName ?? 'Chưa có'}',
                                                      style: Get
                                                          .textTheme.bodySmall),
                                                  value: controller
                                                      .selectedDeliverers
                                                      .containsKey(location.id),
                                                  onChanged: (bool? value) {
                                                    if (value == true) {
                                                      if (controller
                                                                  .deliveryStartTime
                                                                  .value ==
                                                              null ||
                                                          controller
                                                                  .deliveryEndTime
                                                                  .value ==
                                                              null) {
                                                        Get.snackbar('Thất bại',
                                                            'Thời gian giao hàng còn trống');
                                                        return;
                                                      }
                                                      showDeliverersDialog(
                                                          location.id!);
                                                    } else {
                                                      controller
                                                          .selectedDeliverers
                                                          .remove(location.id);
                                                    }
                                                  },
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                    .toList(),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Align(
                          alignment: Alignment.topRight,
                          child: GestureDetector(
                            onTap: () async {
                              await controller.createSession();
                            },
                            child: Container(
                              width: 100,
                              height: 40,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                border:
                                    Border.all(color: Colors.black, width: 0.5),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Iconsax.add,
                                    color: Colors.black,
                                  ),
                                  const SizedBox(width: 5),
                                  Text('Tạo', style: Get.textTheme.bodyMedium),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
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

  void showDeliverersDialog(String locationId) {
    Get.dialog(
      AlertDialog(
        title: Text(
          'Chọn người giao hàng',
          style: Get.textTheme.titleMedium,
        ),
        content: LoadingView(
          future: controller.getDeliverers,
          child: SingleChildScrollView(
            child: SizedBox(
              width: Get.width * 0.8,
              child: Obx(
                () => Column(
                  children: controller.deliverers.map((deliverer) {
                    return Card(
                      child: ListTile(
                        title: Text('Tên: ${deliverer.fullName}',
                            style: Get.textTheme.bodyMedium),
                        subtitle: Text(deliverer.email.toString(),
                            style: Get.textTheme.bodySmall!
                                .copyWith(color: Colors.black54)),
                        onTap: () {
                          Get.back();
                          controller.selectedDeliverers[locationId] = deliverer;
                          var a = controller.selectedDeliverers[locationId];
                        },
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<DateTime?> pickDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: Get.context!,
      initialEntryMode: DatePickerEntryMode.input,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      TimeOfDay? pickedTime = await showTimePicker(
        context: Get.context!,
        initialTime: TimeOfDay.now(),
        initialEntryMode: TimePickerEntryMode.input,
      );
      if (pickedTime != null) {
        DateTime finalDateTime = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );
        return finalDateTime;
      }
    }
    return null;
  }

  bool isValidTime(DateTime date) {
  if (date.isBefore(DateTime.now())) {
    Get.snackbar('Hệ thống', 'Thời gian đã quá hạn');
    return false;
  }
  return true;
}

bool isValidDeliveryStartTime(DateTime deliveryTime) {
  int hour = deliveryTime.hour;
  if (hour >= 4 && hour <= 11) {
    return true;
  }
  Get.snackbar('Hệ thống', 'Thời gian giao hàng phải từ 4h sáng đến 11h sáng');
  return false;
}

}
