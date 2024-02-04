import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
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
                  children: [
                    const Spacer(flex: 5),
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: TextFormField(
                          readOnly: true,
                          decoration: InputDecoration(
                            label: Obx(
                              () => Text(
                                ' ${_dashboardController.selectedDateStrStart}',
                                style: TextStyle(color: Colors.black),
                                maxLines: 1,
                              ),
                            ),
                            prefixIcon: Icon(Icons.calendar_today),
                          ),
                          onTap: () async {
                            final DateTime? picked = await showDatePicker(
                              context: context,
                              initialDate:
                                  _dashboardController.selectedDateStart.value,
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2025),
                            );
                            if (picked != null) {
                              _dashboardController.selectedDateStart.value =
                                  picked;
                              _dashboardController.selectedDateStrStart.value =
                                  DateFormat('dd-MM-yyyy').format(picked);
                            }
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: TextFormField(
                          decoration: InputDecoration(
                            label: Obx(
                              () => Text(
                                ' ${_dashboardController.selectedDateStrEnd}',
                                style: TextStyle(color: Colors.black),
                                maxLines: 1,
                              ),
                            ),
                            prefixIcon: Icon(Icons.calendar_today),
                          ),
                          onTap: () async {
                            final DateTime? picked = await showDatePicker(
                              context: context,
                              initialDate:
                                  _dashboardController.selectedDateEnd.value,
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2025),
                            );
                            if (picked != null) {
                              _dashboardController.selectedDateEnd.value =
                                  picked;
                              _dashboardController.selectedDateStrEnd.value =
                                  DateFormat('dd-MM-yyyy').format(picked);
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: InfoCard(
                      icon: Icons.money,
                      label: 'Transafer via \nCard number',
                      amount: '1200'),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: InfoCard(
                      icon: Icons.money,
                      label: 'Transafer via \nOnline Banks',
                      amount: '1200'),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: InfoCard(
                      icon: Icons.chair,
                      label: 'Transafer \nSame Bank',
                      amount: '1200'),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
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
                    left: 10, top: 15, right: 10, bottom: 0),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.only(
                      left: 10.0, top: 25, right: 10.0, bottom: 25.0),
                  child: Column(children: [
                    const Padding(
                      padding: EdgeInsets.only(bottom: 25.0),
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
                    left: 10, top: 15, right: 10, bottom: 0),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.only(
                      left: 10.0, top: 25, right: 10.0, bottom: 25.0),
                  child: Column(children: [
                    const Padding(
                      padding: EdgeInsets.only(bottom: 25.0),
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
                    left: 10, top: 15, right: 10, bottom: 0),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.only(
                      left: 10.0, top: 25, right: 10.0, bottom: 25.0),
                  child: Column(children: [
                    const Padding(
                      padding: EdgeInsets.only(bottom: 25.0),
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
                    left: 10, top: 15, right: 10, bottom: 0),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.only(
                      left: 10.0, top: 25, right: 10.0, bottom: 25.0),
                  child: Column(children: [
                    const Padding(
                      padding: EdgeInsets.only(bottom: 25.0),
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
