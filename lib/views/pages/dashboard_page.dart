import 'package:beanfast_menumanager/controllers/dashboard_controller.dart';
import 'package:beanfast_menumanager/utils/line_chart.dart';
import 'package:beanfast_menumanager/views/pages/widget/widget_dashboard.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DashboardSample extends StatelessWidget {
  DashboardSample({required this.isShowingMainData});
  DashboardController _dashboardController = Get.put(DashboardController());
  final bool isShowingMainData;
  DateTime selectedDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Row(
            children: [
              Spacer(), 
              Padding(
                padding: const EdgeInsets.all(10),
                child: ElevatedButton.icon(
                  icon: Icon(Icons.calendar_today), // Add your icon here
                  label: Obx(
                    () => Text(
                      'Từ Ngày: ${_dashboardController.selectedDateStrStart}',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  onPressed: () async {
                    final DateTime? picked = await showDatePicker(
                      context: context,
                      initialDate: selectedDate,
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2025),
                    );
                    if (picked != null) {
                      _dashboardController.selectedDateStart.value = picked;
                      _dashboardController.selectedDateStrStart.value =
                          DateFormat('dd-MM-yyyy').format(picked);
                    }
                  },
                ),
              ),
              Padding(
                  padding: const EdgeInsets.all(10),
                child: ElevatedButton.icon(
                  icon: Icon(Icons.calendar_today), // Add your icon here
                  label: Obx(
                    () => Text(
                      'Đến Ngày: ${_dashboardController.selectedDateStrEnd}',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  onPressed: () async {
                    final DateTime? picked = await showDatePicker(
                      context: context,
                      initialDate: selectedDate,
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2025),
                    );
                    if (picked != null) {
                      _dashboardController.selectedDateEnd.value = picked;
                      _dashboardController.selectedDateStrEnd.value =
                          DateFormat('dd-MM-yyyy').format(picked);
                    }
                  },
                ),
              ),
            ],
          ),
        ),
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: InfoCard(
                    color: Colors.grey,
                    icon: Icons.money,
                    label: 'Transafer via \nCard number',
                    amount: '1200'),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: InfoCard(
                    color: Colors.grey,
                    icon: Icons.money,
                    label: 'Transafer via \nOnline Banks',
                    amount: '1200'),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: InfoCard(
                    color: Colors.grey,
                    icon: Icons.chair,
                    label: 'Transafer \nSame Bank',
                    amount: '1200'),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: InfoCard(
                    color: Colors.grey,
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
              color: Colors.red,
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
                      isShowingMainData ? sampleData2 : sampleData2,
                      duration: const Duration(milliseconds: 250),
                    ),
                  ),
                ]),
              ),
            ),
          ),
          Expanded(
            child: Card(
              color: Colors.red,
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
                      isShowingMainData ? sampleData2 : sampleData2,
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
              color: Colors.red,
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
                      isShowingMainData ? sampleData2 : sampleData2,
                      duration: const Duration(milliseconds: 250),
                    ),
                  ),
                ]),
              ),
            ),
          ),
          Expanded(
            child: Card(
              color: Colors.red,
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
                      isShowingMainData ? sampleData2 : sampleData2,
                      duration: const Duration(milliseconds: 250),
                    ),
                  ),
                ]),
              ),
            ),
          ),
        ]),
      ]),
    );
  }
}
