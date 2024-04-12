import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '/utils/line_chart.dart';
import '/controllers/dashboard_controller.dart';
import '/views/pages/widget/widget_dashboard.dart';

class DashboardView extends StatelessWidget {
  DashboardView({super.key});
  final DashboardController _dashboardController =
      Get.put(DashboardController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: SizedBox(
                height: 40,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // Container(
                    //   padding: const EdgeInsets.only(left: 5, right: 5),
                    //   width: 170,
                    //   height: 70,
                    //   alignment: Alignment.center,
                    //   child: TextFormField(
                    //     readOnly: true,
                    //     decoration: InputDecoration(
                    //       label: Obx(
                    //         () => Text(
                    //           ' ${_dashboardController.selectedDateStrStart}',
                    //           style: const TextStyle(color: Colors.black),
                    //           maxLines: 1,
                    //         ),
                    //       ),
                    //       prefixIcon: const Icon(Icons.calendar_today),
                    //     ),
                    //     onTap: () async {
                    //       final DateTime? picked = await showDatePicker(
                    //         context: context,
                    //         initialDate:
                    //             _dashboardController.selectedDateStart.value,
                    //         firstDate:  DateTime.now().subtract(const Duration(days: 365)),
                    //         lastDate:  DateTime.now(),
                    //       );
                    //       if (picked != null) {
                    //         _dashboardController.selectedDateStart.value =
                    //             picked;
                    //         _dashboardController.selectedDateStrStart.value =
                    //             DateFormat('dd-MM-yyyy').format(picked);
                    //       }
                    //     },
                    //   ),
                    // ),
                    // Container(
                    //   alignment: Alignment.center,
                    //   padding: const EdgeInsets.only(left: 5, right: 5),
                    //   width: 170,
                    //   height: 70,
                    //   child: TextFormField(
                    //     decoration: InputDecoration(
                    //       label: Obx(
                    //         () => Text(
                    //           ' ${_dashboardController.selectedDateStrEnd}',
                    //           style: const TextStyle(color: Colors.black),
                    //           maxLines: 1,
                    //         ),
                    //       ),
                    //       prefixIcon: const Icon(Icons.calendar_today),
                    //     ),
                    //     onTap: () async {
                    //       final DateTime? picked = await showDatePicker(
                    //         context: context,
                    //         initialDate:
                    //             _dashboardController.selectedDateEnd.value,
                    //         firstDate: DateTime.now().subtract(const Duration(days: 365)),
                    //         lastDate:  DateTime.now(),
                    //       );
                    //       if (picked != null) {
                    //         _dashboardController.selectedDateEnd.value = picked;
                    //         _dashboardController.selectedDateStrEnd.value =
                    //             DateFormat('dd-MM-yyyy').format(picked);
                    //       }
                    //     },
                    //   ),
                    // ),
                    GestureDetector(
                      onTap: () async {
                        final DateTimeRange? picked = await showDateRangePicker(
                          context: context,
                          initialDateRange: DateTimeRange(
                            start: _dashboardController.selectedDateStart.value,
                            end: _dashboardController.selectedDateEnd.value,
                          ),
                          firstDate: DateTime.now()
                              .subtract(const Duration(days: 365)),
                          lastDate: DateTime.now(),
                        );

                        if (picked != null) {
                          _dashboardController.selectedDateStart.value =
                              picked.start;
                          _dashboardController.selectedDateEnd.value =
                              picked.end;
                          _dashboardController.selectedDateStrStart.value =
                              DateFormat('dd-MM-yyyy').format(picked.start);
                          _dashboardController.selectedDateStrEnd.value =
                              DateFormat('dd-MM-yyyy').format(picked.end);
                        }
                      },
                      child: Container(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, top: 5, bottom: 5),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.green),
                              borderRadius: BorderRadius.circular(12)),
                          child: Obx(() => Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.calendar_today,
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    '${_dashboardController.selectedDateStrStart}  -  ${_dashboardController.selectedDateStrEnd}',
                                    style: Get.textTheme.titleSmall,
                                  ),
                                ],
                              ))),
                    )
                  ],
                ),
              ),
            ),
          ),
          const Row(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: InfoCard(
                      icon: Icons.money,
                      label: 'Transafer via \nCard number',
                      amount: '1200'),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: InfoCard(
                      icon: Icons.money,
                      label: 'Transafer via \nOnline Banks',
                      amount: '1200'),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: InfoCard(
                      icon: Icons.chair,
                      label: 'Transafer \nSame Bank',
                      amount: '1200'),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: InfoCard(
                      icon: Icons.home,
                      label: 'Transafer to \nOther Bank',
                      amount: '1200'),
                ),
              ),
            ],
          ),
          Row(children: [
            Expanded(
              child: Card(
                margin: const EdgeInsets.only(
                    left: 10, top: 10, right: 10, bottom: 10),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  child: Column(children: [
                    const Padding(
                      padding: EdgeInsets.only(bottom: 10),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Your Chart Title',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 450,
                      child: LineChart(
                        // isShowingMainData ? sampleData1 : sampleData2,
                        sampleData2,
                        duration: const Duration(milliseconds: 250),
                      ),
                    ),
                  ]),
                ),
              ),
            ),
            Expanded(
              child: Card(
                margin: const EdgeInsets.only(
                    left: 10, top: 10, right: 10, bottom: 10),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  child: Column(children: [
                    const Padding(
                      padding: EdgeInsets.only(bottom: 10),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Your Chart Title',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 450,
                      child: LineChart(
                        // isShowingMainData ? sampleData1 : sampleData2,
                        sampleData2,
                        duration: const Duration(milliseconds: 250),
                      ),
                    ),
                  ]),
                ),
              ),
            ),
          ]),
          Row(children: [
            Expanded(
              child: Card(
                margin: const EdgeInsets.only(
                    left: 10, top: 10, right: 10, bottom: 10),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  child: Column(children: [
                    const Padding(
                      padding: EdgeInsets.only(bottom: 10),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Your Chart Title',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 450,
                      child: LineChart(
                        // isShowingMainData ? sampleData1 : sampleData2,
                        sampleData2,
                        duration: const Duration(milliseconds: 250),
                      ),
                    ),
                  ]),
                ),
              ),
            ),
            Expanded(
              child: Card(
                margin: const EdgeInsets.only(
                    left: 10, top: 10, right: 10, bottom: 10),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  child: Column(children: [
                    const Padding(
                      padding: EdgeInsets.only(bottom: 10),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Your Chart Title',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 450,
                      child: LineChart(
                        // isShowingMainData ? sampleData1 : sampleData2,
                        sampleData2,
                        duration: const Duration(milliseconds: 250),
                      ),
                    ),
                  ]),
                ),
              ),
            ),
          ]),
        ]),
      ),
    );
  }
}
