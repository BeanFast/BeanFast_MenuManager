import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TmpPage extends StatelessWidget {
  const TmpPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Controller c = Get.put(Controller());

    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Column(
                children: List.generate(
                  3,
                  (index) => ListTile(
                    leading: Obx(
                      () => Radio<int>(
                        value: index,
                        groupValue: c.selectedValue.value,
                        onChanged: (int? value) {
                          if (value != null) {
                            c.updateSelectedValue(value);
                          }
                        },
                      ),
                    ),
                    title: Text('Mã menu $index'),
                    subtitle: Text('Số sản phẩm $index'),
                  ),
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
                            c.thoiGianBatDauDatHang = finalDateTime;
                            c.lbthoiGianBatDauDatHang.value =
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
                          () => Text(c.lbthoiGianBatDauDatHang.value),
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
                            c.thoiGianKetThucDatHang = finalDateTime;
                            c.lbthoiGianKetThucDatHang.value =
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
                            Obx(() => Text(c.lbthoiGianKetThucDatHang.value)),
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
                            c.thoiGianBatDauGiaoHang = finalDateTime;
                            c.lbthoiGianBatDauGiaoHang.value =
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
                            Obx(() => Text(c.lbthoiGianBatDauGiaoHang.value)),
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
                            c.thoiGianKetThucGiaoHang = finalDateTime;
                            c.lbthoiGianKetThucGiaoHang.value =
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
                            Obx(() => Text(c.lbthoiGianKetThucGiaoHang.value)),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text('Cổng', style: TextStyle(fontSize: 16)),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 200,
                      child: SingleChildScrollView(
                          child: Column(
                        children: List.generate(
                          10,
                          (index) => Container(
                            margin:
                                const EdgeInsets.only(bottom: 2.5, top: 2.5),
                            child: Row(
                              children: <Widget>[
                                Obx(
                                  () => Checkbox(
                                    value: c.isChecked[index],
                                    onChanged: (bool? value) {
                                      c.toggle(index);
                                    },
                                  ),
                                ),
                                Text('Cổng ${index + 1}'),
                              ],
                            ),
                          ),
                        ),
                      )),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      alignment: Alignment.centerRight,
                      child: FloatingActionButton.extended(
                        icon: const Icon(Icons.add),
                        onPressed: () {
                          if (c.thoiGianBatDauDatHang
                              .isBefore(c.thoiGianKetThucDatHang)) {
                          } else {}
                          if (c.thoiGianBatDauGiaoHang
                              .isBefore(c.thoiGianKetThucGiaoHang)) {
                          } else {}
                          if (c.thoiGianBatDauGiaoHang
                              .isBefore(c.thoiGianKetThucDatHang)) {
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
    );
  }
}

class Controller extends GetxController {
  var selectedValue = 0.obs;

  void updateSelectedValue(int value) {
    selectedValue.value = value;
  }

  // final int numberOfGate = 10;
  var isChecked = List<bool>.filled(10, false).obs;

  void toggle(int index) => isChecked[index] = !isChecked[index];
  DateTime thoiGianBatDauDatHang = DateTime.now();
  DateTime thoiGianKetThucDatHang = DateTime.now();
  DateTime thoiGianBatDauGiaoHang = DateTime.now();
  DateTime thoiGianKetThucGiaoHang = DateTime.now();

  var lbthoiGianBatDauDatHang = 'Bắt đầu'.obs;
  var lbthoiGianKetThucDatHang = 'Kết thúc'.obs;
  var lbthoiGianBatDauGiaoHang = 'Bắt đầu'.obs;
  var lbthoiGianKetThucGiaoHang = 'Kết thúc'.obs;
}
