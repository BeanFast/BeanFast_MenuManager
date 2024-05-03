import 'package:beanfast_menumanager/views/pages/loading_page.dart';
import 'package:beanfast_menumanager/views/pages/widget/order_by_date_line_chart.dart';
import 'package:beanfast_menumanager/views/pages/widget/pie_chart_dashboard_1.dart';
import 'package:beanfast_menumanager/views/pages/widget/pie_chart_dashboard_2.dart';
import 'package:beanfast_menumanager/views/pages/widget/pie_chart_dashboard_3.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '/controllers/dashboard_controller.dart';
import '/views/pages/widget/widget_dashboard.dart';
import 'widget/dashboard_1.dart';
import 'widget/dashboard_2.dart';
import 'widget/dashboard_3.dart';
import 'widget/dashboard_4.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({super.key});
  // final DashboardController controller =
  //     Get.put(DashboardController());
  @override
  Widget build(BuildContext context) {
    Get.put(DashboardController());
    return LoadingView(
      future: () async {
        await Future.wait([
          controller.getBestSellerFoods(),
          controller.getOrderStatistics(),
          controller.getBestSellerCategories(),
          controller.getTotalFoodCount(),
          controller.getTotalSchoolCount(),
          controller.getOrderStatisticsByDays(),
          controller.getTopSellerKitchens(),
          controller.getTopSellerSchools(),
        ]);
      },
      child: Scaffold(
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
                          final DateTimeRange? picked =
                              await showDateRangePicker(
                            context: context,
                            initialDateRange: DateTimeRange(
                              start: controller.selectedDateStart.value,
                              end: controller.selectedDateEnd.value,
                            ),
                            firstDate: DateTime.now()
                                .subtract(const Duration(days: 365)),
                            lastDate: DateTime.now(),
                          );

                          if (picked != null) {
                            controller.selectedDateStart.value = picked.start;
                            controller.selectedDateEnd.value = picked.end;
                            controller.selectedDateStrStart.value =
                                DateFormat('dd-MM-yyyy').format(picked.start);
                            controller.selectedDateStrEnd.value =
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
                          child: Obx(
                            () => Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.calendar_today,
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  '${controller.selectedDateStrStart}  -  ${controller.selectedDateStrEnd}',
                                  style: Get.textTheme.titleSmall,
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

            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    child: Obx(() => InfoCard(
                        icon: Icons.money,
                        label: 'Tổng doanh thu',
                        amount: controller.totalRevenue.value)),
                  ),
                ),
                Expanded(
                  child: Padding(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: Obx(
                        () => InfoCard(
                            icon: Icons.shopping_cart,
                            label: 'Tổng số đơn hàng được hoàn thành',
                            amount: controller.totalOrder.value),
                      )),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    child: Obx(
                      () => InfoCard(
                          icon: Icons.food_bank,
                          label: 'Tổng số lượng thức ăn được bán',
                          amount: controller.totalFood.value),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    child: Obx(
                      () => InfoCard(
                          icon: Icons.school,
                          label: 'Tổng số trường học đang hoạt động',
                          amount: controller.totalSchool.value),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 25),

            SizedBox(
              width: Get.width * 0.9,
              child: PointDashboard1(
                bestSellerFoods: controller.bestSellerFoods,
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            SizedBox(
              width: Get.width * 0.9,
              child: PointDashboard2(
                orderStatistics: controller.completeOrderStatistics,
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            SizedBox(
              width: Get.width * 0.9,
              child: LineChartSample2(
                list: controller.orderStatisticByDays,
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: PieChart1(controller.bestSellerCategory),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    child: PieChart2(controller.topSellerKitchens),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    child: Column(
                      children: [
                        PieChart3(controller.topSellerSchools),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 25),
            // const Row(
            //   children: [
            //     Expanded(
            //       child: Padding(
            //         padding: EdgeInsets.only(left: 10, right: 10),
            //         child: PieChart3(),
            //       ),
            //     ),
            //     Expanded(
            //       child: Padding(
            //         padding: EdgeInsets.only(left: 10, right: 10),
            //         child: PieChart3(),
            //       ),
            //     ),
            //   ],
            // ),
            // PointDashboard3(),
            // PointDashboard4(),
          ]),
        ),
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
