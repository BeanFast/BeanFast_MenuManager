import 'package:beanfast_menumanager/utils/format_data.dart';
import 'package:beanfast_menumanager/views/pages/loading_page.dart';
import 'package:beanfast_menumanager/views/pages/widget/dashboard_1.dart';
import 'package:beanfast_menumanager/views/pages/widget/dashboard_2.dart';
import 'package:beanfast_menumanager/views/pages/widget/order_by_date_line_chart.dart';
import 'package:beanfast_menumanager/views/pages/widget/pie_chart_dashboard_1.dart';
import 'package:beanfast_menumanager/views/pages/widget/pie_chart_dashboard_3.dart';
import 'package:beanfast_menumanager/views/pages/widget/pie_chart_dashboard_4.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/controllers/dashboard_controller.dart';
import '/views/pages/widget/widget_dashboard.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({super.key});
  // final DashboardController controller =
  //     Get.put(DashboardController());
  @override
  Widget build(BuildContext context) {
    Get.put(DashboardController());
    return LoadingView(
      future: () async {
        try {
          await Future.wait([
            controller.getBestSellerFoods(),
            controller.getOrderStatistics(),
            controller.getBestSellerCategories(),
            controller.getTotalFoodCount(),
            controller.getTotalSchoolCount(),
            controller.getOrderStatisticsByDays(),
            controller.getTopSellerKitchens(),
            controller.getTopSellerSchools(),
            controller.getTopSellerOrderByStatus(),
          ]);
        } on DioException catch (e) {
        Get.snackbar('Lỗi', e.response?.data['message']);
        }
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(children: [
            const Padding(
              padding: EdgeInsets.only(bottom: 10),
            ),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Obx(() => InfoCard(
                        color: Colors.blue,
                        icon: Icons.money,
                        label: 'Tổng doanh thu',
                        amount: Formatter.formatMoney(
                            controller.totalRevenue.value))),
                  ),
                ),
                Expanded(
                  child: Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Obx(
                        () => InfoCard(
                            color: Colors.red,
                            icon: Icons.shopping_cart,
                            label: 'Số đơn hàng được hoàn thành',
                            amount: controller.totalOrder.value),
                      )),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Obx(
                      () => InfoCard(
                          color: Colors.orange,
                          icon: Icons.food_bank,
                          label: 'Số lượng thức ăn được bán',
                          amount: controller.totalFood.value),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Obx(
                      () => InfoCard(
                          color: Colors.green,
                          icon: Icons.school,
                          label: 'Số trường học đang hoạt động',
                          amount: controller.totalSchool.value),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 25),
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
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Column(
                      children: [
                        PieChart3(controller.topSellerSchools),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Column(
                      children: [
                        PieChart4(controller.topSellerOrderByStatus),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 25),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: PointDashboard1(
                bestSellerFoods: controller.bestSellerFoods,
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Padding(
             padding: const EdgeInsets.only(left: 10, right: 10),
              child: PointDashboard2(
                orderStatistics: controller.completeOrderStatistics,
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: LineChartSample2(
                list: controller.orderStatisticByDays,
              ),
            ),
            const SizedBox(height: 25),
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
