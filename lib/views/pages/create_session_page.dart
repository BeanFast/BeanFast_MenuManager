import 'package:beanfast_menumanager/models/menu.dart';
import 'package:beanfast_menumanager/models/school.dart';
import 'package:beanfast_menumanager/services/menu_serivce.dart';
import 'package:beanfast_menumanager/services/school_service.dart';
import 'package:beanfast_menumanager/utils/logger.dart';
import 'package:beanfast_menumanager/views/pages/loading_page.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../services/session_service.dart';

class CreateSessionPage extends GetView<CreateSessionController> {
  final String schoolId;
  const CreateSessionPage({super.key, required this.schoolId});

  @override
  Widget build(BuildContext context) {
    Get.put(CreateSessionController());
    // var menuCode = Get.parameters['code'];
    return LoadingView(
      future: () async {
        controller.refreshData(schoolId);
      },
      child: Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: Obx(
                  () => Column(
                    children: controller.listMenu
                        .map(
                          (menu) => ListTile(
                            title: Text(menu.code.toString()),
                            subtitle: Text(menu.menuDetails!.length.toString()),
                          ),
                        )
                        .toList(),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  padding: const EdgeInsets.only(left: 40, right: 40),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                            border: Border.all(color: Colors.blue),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          padding: const EdgeInsets.all(10),
                          child: Obx(
                            () => Text(controller.lbOrderStartTime.value),
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
                            border: Border.all(color: Colors.blue),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          padding: const EdgeInsets.all(10),
                          child:
                              Obx(() => Text(controller.lbOrderEndTime.value)),
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
                            border: Border.all(color: Colors.blue),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          padding: const EdgeInsets.all(10),
                          child: Obx(
                              () => Text(controller.lbDeliveryStartTime.value)),
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
                            border: Border.all(color: Colors.blue),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          padding: const EdgeInsets.all(10),
                          child: Obx(
                              () => Text(controller.lbDeliveryEndTime.value)),
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text('Cổng', style: TextStyle(fontSize: 16)),
                      const SizedBox(height: 10),
                      // SizedBox(
                      //   height: 200,
                      //   child: SingleChildScrollView(
                      //     child: Column(
                      //       children: controller.school.value.locations!
                      //           .map(
                      //             (location) => Container(
                      //               margin: const EdgeInsets.only(
                      //                   bottom: 2.5, top: 2.5),
                      //               child: Row(
                      //                 children: <Widget>[
                      //                   // Obx(
                      //                   //   () => Checkbox(
                      //                   //     value: controller.isChecked[index],
                      //                   //     onChanged: (bool? value) {
                      //                   //       controller.toggle(index);
                      //                   //     },
                      //                   //   ),
                      //                   // ),
                      //                   Text('${location.name}'),
                      //                 ],
                      //               ),
                      //             ),
                      //           )
                      //           .toList(),
                      //     ),
                      //   ),
                      // ),
                      const SizedBox(height: 20),
                      Container(
                        alignment: Alignment.centerRight,
                        child: FloatingActionButton.extended(
                          icon: const Icon(Icons.add),
                          onPressed: () {
                            if (controller.orderStartTime
                                .isBefore(controller.orderEndTime)) {
                            } else {}
                            if (controller.deliveryStartTime
                                .isBefore(controller.deliveryEndTime)) {
                            } else {}
                            if (controller.deliveryStartTime
                                .isBefore(controller.orderEndTime)) {
                            } else {}
                          },
                          label: const Text('Tạo'),
                        ),
                      )
                    ],
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
  // final int numberOfGate = 10;
  var isChecked = List<bool>.filled(10, false).obs;
  RxList<Menu> listMenu = <Menu>[].obs;
  Rx<School> school = School().obs;
  Future refreshData(String schoolId) async {
    try {
      listMenu.value = await MenuService().getBySchoolId(schoolId);
      school.value = await SchoolService().getById(schoolId);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> createSession() async {
    try {
      // await SessionService().createSession();
    } on DioException catch (e) {
      logger.e(e.response!.data);
    }
  }

  void toggle(int index) => isChecked[index] = !isChecked[index];
  DateTime orderStartTime = DateTime.now();
  DateTime orderEndTime = DateTime.now();
  DateTime deliveryStartTime = DateTime.now();
  DateTime deliveryEndTime = DateTime.now();

  var lbOrderStartTime = 'Bắt đầu'.obs;
  var lbOrderEndTime = 'Kết thúc'.obs;
  var lbDeliveryStartTime = 'Bắt đầu'.obs;
  var lbDeliveryEndTime = 'Kết thúc'.obs;
}
