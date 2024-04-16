import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '/controllers/dashboard_controller.dart';
import '/views/pages/widget/widget_dashboard.dart';
import 'widget/dashboard_1.dart';
import 'widget/dashboard_2.dart';
import 'widget/dashboard_3.dart';
import 'widget/dashboard_4.dart';

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
          const Row(children: [
            Expanded(child: PointDashboard1()),
            Expanded(child: PointDashboard2()),
          ]),
          const Row(children: [
            Expanded(child: PointDashboard3()),
            Expanded(child: PointDashboard4()),
          ]),
        ]),
      ),
    );
  }
}

// child: Card(
//                 margin: const EdgeInsets.only(
//                     left: 10, top: 10, right: 10, bottom: 10),
//                 child: Container(
//                   padding: const EdgeInsets.all(10),
//                   child: Column(children: [
//                     const Padding(
//                       padding: EdgeInsets.only(bottom: 10),
//                       child: Align(
//                         alignment: Alignment.centerLeft,
//                         child: Text(
//                           'Your Chart Title',
//                           style: TextStyle(
//                             fontSize: 24,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                     ),
//                     SizedBox(
//                       height: 450,
//                       child: LineChart(
//                         // isShowingMainData ? sampleData1 : sampleData2,
//                         sampleData2,
//                         duration: const Duration(milliseconds: 250),
//                       ),
//                     ),
//                   ]),
//                 ),
//               ),
