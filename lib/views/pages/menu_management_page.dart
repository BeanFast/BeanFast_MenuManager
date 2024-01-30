import 'package:beanfast_menumanager/views/pages/widget/button_data_table.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/utils/logger.dart';

class MenuManagementView extends StatelessWidget {
  const MenuManagementView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Danh sách thực đơn'),
      ),
      body: SizedBox(
        height: Get.height,
        child: Padding(
          padding:
              const EdgeInsets.only(top: 40, left: 10, right: 10, bottom: 10),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 10, right: 10, bottom: 30, top: 10),
                    child: SizedBox(
                      height: 50,
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Padding(
                              padding: EdgeInsets.only(right: 10),
                              child: TextFormField(
                                readOnly: true,
                                initialValue: '30/1/2021',
                                decoration: const InputDecoration(
                                  label: Text('Từ ngày'),
                                  prefixIcon: Icon(Icons.calendar_today),
                                ),
                                onTap: () async {
                                  FocusScope.of(Get.context!)
                                      .requestFocus(new FocusNode());

                                  DateTime? pickedDate = await showDatePicker(
                                    context: Get.context!,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2000),
                                    lastDate: DateTime(2025),
                                  );

                                  if (pickedDate != null) {
                                    TimeOfDay? pickedTime =
                                        await showTimePicker(
                                      context: Get.context!,
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
                                      logger.i(finalDateTime);
                                    }
                                  }
                                },
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Padding(
                              padding: EdgeInsets.only(right: 10),
                              child: TextFormField(
                                initialValue: '30/1/2021',
                                decoration: const InputDecoration(
                                  label: Text('Từ ngày'),
                                  prefixIcon: Icon(Icons.calendar_today),
                                ),
                                onTap: () async {
                                  FocusScope.of(Get.context!)
                                      .requestFocus(new FocusNode());

                                  DateTime? pickedDate = await showDatePicker(
                                    context: Get.context!,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2000),
                                    lastDate: DateTime(2025),
                                  );

                                  if (pickedDate != null) {
                                    TimeOfDay? pickedTime =
                                        await showTimePicker(
                                      context: Get.context!,
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
                                      logger.i(finalDateTime);
                                    }
                                  }
                                },
                              ),
                            ),
                          ),
                          const Spacer(
                            flex: 5,
                          ),
                          SizedBox(
                            height: 40,
                            width: 100,
                            child: FloatingActionButton.extended(
                              onPressed: () {},
                              label: Text('Thêm'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                DefaultTabController(
                  length: 2,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const TabBar(
                        tabs: [
                          Tab(text: 'Tab 1'),
                          Tab(text: 'Tab 2'),
                        ],
                      ),
                      Container(
                        height: Get
                            .height, // adjust this size as per your requirement
                        child: TabBarView(
                          children: <Widget>[
                            SingleChildScrollView(
                              child: DataTable(
                                columns: const <DataColumn>[
                                  DataColumn(
                                    label: Text(
                                      'Code',
                                    ),
                                  ),
                                  DataColumn(
                                    label: Text(
                                      'Thời gian hiệu lực',
                                    ),
                                  ),
                                  DataColumn(
                                    label: Text(
                                      'Thời gian giao hàng',
                                    ),
                                  ),
                                  DataColumn(
                                    label: Text(
                                      'Cổng',
                                    ),
                                  ),
                                  DataColumn(
                                    label: Text(
                                      'Trạng thái',
                                    ),
                                  ),
                                  DataColumn(
                                    label: Text(
                                      'Hành động',
                                    ),
                                  ),
                                ],
                                rows: <DataRow>[
                                  DataRow(
                                    cells: <DataCell>[
                                      DataCell(Text('#01111111')),
                                      DataCell(Text('7h30 - 8h00')),
                                      DataCell(Text('19h00')),
                                      DataCell(Text('Cổng 1')),
                                      DataCell(Text('Hoạt động')),
                                      DataCell(DeleteButtonDataTable(
                                        agree: () {},
                                      )),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Center(child: Text('Tab 2 Content')),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
