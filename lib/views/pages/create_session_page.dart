import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';

import '/models/menu.dart';
import '/models/school.dart';
import '/models/session.dart';
import '/models/session_detail.dart';
import '/services/menu_serivce.dart';
import '/services/school_service.dart';
import '/services/session_service.dart';
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
                            DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialEntryMode: DatePickerEntryMode.input,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2100),
                            );

                            if (pickedDate != null) {
                              TimeOfDay? pickedTime = await showTimePicker(
                                context: context,
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
                                print(finalDateTime);
                                controller.orderStartTime = finalDateTime;
                                controller.lbOrderStartTime.value =
                                    DateFormat('HH:mm - dd/MM/yyyy')
                                        .format(finalDateTime);
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
                                    ? DateFormat('HH:mm - dd/MM/yyyy')
                                        .format(controller.orderStartTime)
                                    : controller.lbOrderStartTime.toString(),
                                style: Get.textTheme.bodyMedium,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        GestureDetector(
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialEntryMode: DatePickerEntryMode.input,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2100),
                            );

                            if (pickedDate != null) {
                              TimeOfDay? pickedTime = await showTimePicker(
                                context: context,
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
                                      ? DateFormat('HH:mm - dd/MM/yyyy')
                                          .format(controller.orderEndTime)
                                      : controller.lbOrderEndTime.toString(),
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
                            DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialEntryMode: DatePickerEntryMode.input,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2100),
                            );

                            if (pickedDate != null) {
                              TimeOfDay? pickedTime = await showTimePicker(
                                context: context,
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
                                if (isValidDeliveryStartTime(finalDateTime)) {
                                  controller.deliveryStartTime = finalDateTime;
                                  controller.deliveryStartTime = finalDateTime;
                                  controller.lbDeliveryStartTime.value =
                                      finalDateTime.toString();
                                } else {
                                  Get.snackbar('Hệ thống',
                                      'Thời gian giao hàng phải từ 4h sáng đến 11h sáng');
                                }
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
                                  controller.lbDeliveryStartTime.value !=
                                          'Bắt đầu'
                                      ? DateFormat('HH:mm - dd/MM/yyyy')
                                          .format(controller.deliveryStartTime)
                                      : controller.lbDeliveryStartTime
                                          .toString(),
                                  style: Get.textTheme.bodyMedium,
                                )),
                          ),
                        ),
                        const SizedBox(height: 10),
                        GestureDetector(
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialEntryMode: DatePickerEntryMode.input,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2100),
                            );

                            if (pickedDate != null) {
                              TimeOfDay? pickedTime = await showTimePicker(
                                context: context,
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
                                if (isValidDeliveryStartTime(finalDateTime)) {
                                  controller.deliveryEndTime = finalDateTime;
                                  controller.lbDeliveryEndTime.value =
                                      finalDateTime.toString();
                                } else {
                                  Get.snackbar('Hệ thống',
                                      'Thời gian giao hàng phải từ 4h sáng đến 11h sáng');
                                }
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
                                  controller.lbDeliveryEndTime.value !=
                                          'Kết thúc'
                                      ? DateFormat('HH:mm - dd/MM/yyyy')
                                          .format(controller.deliveryEndTime)
                                      : controller.lbDeliveryEndTime.toString(),
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
                                                      'Người giao hàng: ${controller.selectedDeliverers[location.id]?.name ?? 'Chưa có'}',
                                                      style: Get
                                                          .textTheme.bodySmall),
                                                  value: controller
                                                      .selectedDeliverers
                                                      .containsKey(location.id),
                                                  onChanged: (bool? value) {
                                                    if (value == true) {
                                                      showDialog(
                                                        context: context,
                                                        builder: (BuildContext
                                                            context) {
                                                          return AlertDialog(
                                                            title: Text(
                                                              'Chọn người giao hàng',
                                                              style: Get
                                                                  .textTheme
                                                                  .titleMedium,
                                                            ),
                                                            content:
                                                                SingleChildScrollView(
                                                              child: SizedBox(
                                                                width:
                                                                    Get.width *
                                                                        0.8,
                                                                child: Column(
                                                                  children: controller
                                                                      .deliverers
                                                                      .map(
                                                                          (deliverer) {
                                                                    return Card(
                                                                      child:
                                                                          ListTile(
                                                                        title: Text(
                                                                            'ID: ${deliverer.id}',
                                                                            style:
                                                                                Get.textTheme.bodyMedium),
                                                                        subtitle: Text(
                                                                            deliverer
                                                                                .name,
                                                                            style:
                                                                                Get.textTheme.bodySmall!.copyWith(color: Colors.black54)),
                                                                        onTap:
                                                                            () {
                                                                          controller.selectedDeliverers[location.id!] =
                                                                              deliverer;
                                                                          print(
                                                                              'Selected deliverer for ${location.name}: ${deliverer.name}');

                                                                          Get.back();
                                                                        },
                                                                      ),
                                                                    );
                                                                  }).toList(),
                                                                ),
                                                              ),
                                                            ),
                                                          );
                                                        },
                                                      );
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
}

class CreateSessionController extends GetxController {
  var selectedMenuId = ''.obs;
  String _schoolId = '';

  void updateSelectedValue(String value) {
    selectedMenuId.value = value;
  }

  // void toggleCheckbox(String id) {
  //   if (listString.contains(id)) {
  //     listString.remove(id);
  //   } else {
  //     listString.add(id);
  //   }
  // }

  var deliverers = <Deliverer>[
    Deliverer(name: 'Người giao hàng 1', id: '1'),
    Deliverer(name: 'Người giao hàng 2', id: '2'),
    Deliverer(name: 'Người giao hàng 3', id: '3'),
    Deliverer(name: 'Người giao hàng 4', id: '4'),
    Deliverer(name: 'Người giao hàng 5', id: '5'),
  ].obs;

  var selectedDeliverers = <String, Deliverer>{}.obs;

  RxSet<String> listString = <String>{}.obs;

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

bool isValidDeliveryStartTime(DateTime deliveryStartTime) {
  int hour = deliveryStartTime.hour;
  return hour >= 4 && hour < 11;
}

class Deliverer {
  String name;
  String id;
  Deliverer({required this.name, required this.id});
}
