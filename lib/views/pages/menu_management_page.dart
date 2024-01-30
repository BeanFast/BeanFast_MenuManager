import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/utils/logger.dart';

class MenuManagementView extends StatelessWidget {
  const MenuManagementView({super.key});

  @override
  Widget build(BuildContext context) {
    return 
    Scaffold(
      appBar: AppBar(
        title: const Text('Danh sách thực đơn'),
      ),
      body: SizedBox(
        height: Get.height,
        child: Padding(
          padding: const EdgeInsets.only(top: 40, left: 10, right: 10, bottom: 10),
          child: SingleChildScrollView(
            child: Column(
              children:[
                Align(
                  alignment: Alignment.centerRight,
                  child: SizedBox(
                    height: 35,
                    // width: 600,
                    child: Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(right: 10),
                            child: TextFormField(
                              readOnly: true,
                              initialValue: '30/1/2021',
                              decoration: const InputDecoration(
                                labelText: 'Từ ngày',
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
                                  TimeOfDay? pickedTime = await showTimePicker(
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
                          child: Padding(
                            padding: EdgeInsets.only(right: 10),
                            child: SizedBox(
                              width: 250,
                              height: 50,
                              child: TextFormField(
                                initialValue: '30/1/2021',
                                decoration: const InputDecoration(
                                  labelText: 'Đến ngày',
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
                                    TimeOfDay? pickedTime = await showTimePicker(
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
                        ),
                        const Spacer(),
                        SizedBox(
                          height: 50,
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
                DefaultTabController(
                  length: 2,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      TabBar(
                        tabs: [
                          Tab(text: 'Tab 1'),
                          Tab(text: 'Tab 2'),
                        ],
                      ),
                      Container(
                        height: 200, // adjust this size as per your requirement
                        child: TabBarView(
                          children: <Widget>[
                            Center(child: Text('Tab 1 Content')),
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
