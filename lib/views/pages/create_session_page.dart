import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '/services/session_service.dart';
import '/models/menu.dart';
import '/models/school.dart';
import '/models/session.dart';
import '/models/session_detail.dart';
import '/services/menu_serivce.dart';
import '/services/school_service.dart';
import '/utils/logger.dart';
import '/views/pages/loading_page.dart';

class CreateSessionPage extends GetView<CreateSessionController> {
  final String schoolId;
  const CreateSessionPage({super.key, required this.schoolId});

  @override
  Widget build(BuildContext context) {
    Get.put(CreateSessionController());
    // var menuCode = Get.parameters['code'];
    return LoadingView(
      future: () async {
        await controller.refreshData(schoolId);
      },
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
                          child: Text('Danh sách menu',
                              style: Get.textTheme.titleLarge!.copyWith(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500)),
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
                          child: Text('Thông tin session',
                              style: Get.textTheme.titleLarge!.copyWith(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500)),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          'Thời gian đặt hàng',
                          style: TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 10),
                        GestureDetector(
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2100),
                            );

                            if (pickedDate != null) {
                              TimeOfDay? pickedTime = await showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.now(),
                              );
                              if (pickedTime != null) {
                                DateTime finalDateTime = DateTime(
                                  pickedDate.year,
                                  pickedDate.month,
                                  pickedDate.day,
                                  pickedTime.hour,
                                  pickedTime.minute,
                                );
                                print(finalDateTime);
                                controller.orderStartTime = finalDateTime;
                                controller.lbOrderStartTime.value =
                                    finalDateTime.toString();
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
                                controller.lbOrderStartTime.value != 'Bắt đầu'
                                    ? DateFormat('hh:mm - dd/MM/yyyy')
                                        .format(controller.orderStartTime)
                                    : controller.lbOrderStartTime.toString(),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        GestureDetector(
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2100),
                            );

                            if (pickedDate != null) {
                              TimeOfDay? pickedTime = await showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.now(),
                              );

                              if (pickedTime != null) {
                                DateTime finalDateTime = DateTime(
                                  pickedDate.year,
                                  pickedDate.month,
                                  pickedDate.day,
                                  pickedTime.hour,
                                  pickedTime.minute,
                                );
                                print(finalDateTime);
                                controller.orderEndTime = finalDateTime;
                                controller.lbOrderEndTime.value =
                                    finalDateTime.toString();
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
                                controller.lbOrderEndTime.value != 'Kết thúc'
                                    ? DateFormat('hh:mm - dd/MM/yyyy')
                                        .format(controller.orderEndTime)
                                    : controller.lbOrderEndTime.toString())),
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Text('Thời gian giao hàng',
                            style: TextStyle(fontSize: 16)),
                        const SizedBox(height: 10),
                        GestureDetector(
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2100),
                            );

                            if (pickedDate != null) {
                              TimeOfDay? pickedTime = await showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.now(),
                              );

                              if (pickedTime != null) {
                                DateTime finalDateTime = DateTime(
                                  pickedDate.year,
                                  pickedDate.month,
                                  pickedDate.day,
                                  pickedTime.hour,
                                  pickedTime.minute,
                                );
                                controller.deliveryStartTime = finalDateTime;
                                controller.lbDeliveryStartTime.value =
                                    finalDateTime.toString();
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
                            child: Obx(() => Text(controller
                                        .lbDeliveryStartTime.value !=
                                    'Bắt đầu'
                                ? DateFormat('hh:mm - dd/MM/yyyy')
                                    .format(controller.deliveryStartTime)
                                : controller.lbDeliveryStartTime.toString())),
                          ),
                        ),
                        const SizedBox(height: 10),
                        GestureDetector(
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2100),
                            );

                            if (pickedDate != null) {
                              TimeOfDay? pickedTime = await showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.now(),
                              );

                              if (pickedTime != null) {
                                DateTime finalDateTime = DateTime(
                                  pickedDate.year,
                                  pickedDate.month,
                                  pickedDate.day,
                                  pickedTime.hour,
                                  pickedTime.minute,
                                );
                                controller.deliveryEndTime = finalDateTime;
                                controller.lbDeliveryEndTime.value =
                                    finalDateTime.toString();
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
                                controller.lbDeliveryEndTime.value != 'Kết thúc'
                                    ? DateFormat('hh:mm - dd/MM/yyyy')
                                        .format(controller.deliveryEndTime)
                                    : controller.lbDeliveryEndTime.toString())),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'Cổng',
                          style: Get.textTheme.titleMedium,
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
                            child: Obx(() => Column(
                                  children: controller.school.value.locations!
                                      .map(
                                        (location) => Container(
                                          margin: const EdgeInsets.only(
                                              bottom: 2.5, top: 2.5),
                                          child: Row(
                                            children: <Widget>[
                                              Obx(
                                                () => Checkbox(
                                                  value: controller.listString
                                                      .contains(location.id!),
                                                  onChanged: (bool? value) {
                                                    controller.toggleCheckbox(
                                                        location.id!);
                                                  },
                                                ),
                                              ),
                                              Expanded(
                                                  child: Text(
                                                '${location.name}',
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              )),
                                            ],
                                          ),
                                        ),
                                      )
                                      .toList(),
                                )),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Align(
                          alignment: Alignment.topRight,
                          child: GestureDetector(
                            onTap: () {
                              if (controller.orderStartTime
                                  .isBefore(controller.orderEndTime)) {
                              } else {
                                Get.snackbar('Thất bại',
                                    'Thời gian đặt hàng không hợp lệ');
                                return;
                              }
                              if (controller.deliveryStartTime
                                  .isBefore(controller.deliveryEndTime)) {
                              } else {
                                Get.snackbar('Thất bại',
                                    'Thời gian giao hàng không hợp lệ');
                                return;
                              }
                              if (controller.orderEndTime
                                  .add(const Duration(hours: 6))
                                  .isBefore(controller.deliveryStartTime)) {
                              } else {
                                Get.snackbar('Thất bại',
                                    'Thời gian đặt hàng phải sao giao hàng 6 giờ');
                                return;
                              }
                              controller.createSession();
                            },
                            child: Container(
                              width: 120,
                              padding: const EdgeInsets.all(15),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                border:
                                    Border.all(color: Colors.black, width: 0.5),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.add,
                                    color: Colors.black,
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    'Tạo',
                                    style: TextStyle(fontSize: 16),
                                  ),
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
}

class CreateSessionController extends GetxController {
  var selectedMenuId = ''.obs;
  String _schoolId = '';

  void updateSelectedValue(String value) {
    selectedMenuId.value = value;
  }

  void toggleCheckbox(String id) {
    if (listString.contains(id)) {
      listString.remove(id);
    } else {
      listString.add(id);
    }
  }

  // final int numberOfGate = 10;
  RxSet<String> listString = <String>{}.obs;
  // var isChecked = List<bool>.filled(10, false).obs;
  RxList<Menu> listMenu = <Menu>[].obs;
  Rx<School> school = School().obs;
  Future refreshData(String schoolId) async {
    _schoolId = schoolId;
    try {
      listMenu.value = await MenuService().getBySchoolId(schoolId);
      school.value = await SchoolService().getById(schoolId);
      school.value.locations?.forEach((e) {
        listString.add(e.id!);
      });
    } on DioException catch (e) {
      Get.snackbar('Lỗi', e.message.toString());
    }
  }

  Future<void> createSession() async {
    if (selectedMenuId.value == '') {
      Get.snackbar('Thất bại', 'Chưa có menu');
      return;
    }
    List<SessionDetail> sessionDetails = [];
    for (var e in listString) {
      sessionDetails.add(SessionDetail(locationId: e));
    }
    Session session = Session(
      menuId: selectedMenuId.value,
      orderStartTime: orderStartTime,
      orderEndTime: orderEndTime,
      deliveryStartTime: deliveryStartTime,
      deliveryEndTime: deliveryEndTime,
      sessionDetails: sessionDetails,
    );
    try {
      await SessionService().createSession(session);
      Get.back();
      Get.snackbar('Thông báo', 'Tạo thành công');
      if (_schoolId.isNotEmpty) {
        await refreshData(_schoolId);
      }
    } on DioException catch (e) {
      Get.snackbar('Lỗi', e.message.toString());
    }
  }

  // void toggle(int index) => isChecked[index] = !isChecked[index];
  DateTime orderStartTime = DateTime.now();
  DateTime orderEndTime = DateTime.now();
  DateTime deliveryStartTime = DateTime.now();
  DateTime deliveryEndTime = DateTime.now();

  var lbOrderStartTime = 'Bắt đầu'.obs;
  var lbOrderEndTime = 'Kết thúc'.obs;
  var lbDeliveryStartTime = 'Bắt đầu'.obs;
  var lbDeliveryEndTime = 'Kết thúc'.obs;
}
