import 'package:beanfast_menumanager/services/dashboard_service.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '/contains/theme_color.dart';

class PointDashboard2 extends StatelessWidget {
  PointDashboard2({super.key, required this.orderStatistics});
  RxList<OrderStatistic> orderStatistics = <OrderStatistic>[].obs;
  RxInt touchedGroupIndex = (-1).obs;

  BarChartGroupData generateBarGroup(
    int x,
    double count,
    double revenue,
  ) {
    return BarChartGroupData(
        x: x,
        barRods: [
          BarChartRodData(
              toY: count,
              color: Colors.blueAccent,
              width: 20,
              borderRadius: BorderRadius.zero),
          BarChartRodData(
              toY: revenue / 1000000,
              color: Colors.redAccent,
              width: 20,
              borderRadius: BorderRadius.zero),
        ],
        showingTooltipIndicators: touchedGroupIndex.value == x ? [0, 1] : []);
  }

  late int minCount = 0;
  late int maxCount = 0;
  late double step = 1;
  @override
  Widget build(BuildContext context) {
    // Iterate through the remaining elements, updating min count if necessary
    return Obx(() => orderStatistics.isEmpty
        ? Card(
            child: Container(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  const Text(
                    'Tổng kết số đơn và doanh thu theo tháng',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 50),
                  SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.4,
                      child: const Center(child: Text('Chưa có dữ liệu'))),
                ],
              ),
            ),
          )
        : renderCard(context));
  }

  Widget renderCard(BuildContext context) {
    for (var item in orderStatistics) {
      if (item.count < minCount) {
        minCount = item.count;
      } else if (item.count > maxCount) {
        maxCount = item.count;
      }
      step = (maxCount / 5).ceil().toDouble();
      // print(step);
      if (step == 0) step = 1;
    }
    return Card(
      child: Container(
        // color: Colors.red,
        padding: const EdgeInsets.all(20),
        child: Column(
            
            children: [
              const Text(
                'Tổng kết số đơn và doanh thu theo tháng',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 50),
              SizedBox(
                width: MediaQuery.of(context).size.width ,
                height: MediaQuery.of(context).size.height * 0.4,
                child: BarChart(
                  BarChartData(
                    alignment: BarChartAlignment.spaceAround,
                    borderData: FlBorderData(
                      show: true,
                      border: Border.symmetric(
                        horizontal: BorderSide(
                          color: ThemeColor.borderColor.withOpacity(0.2),
                        ),
                      ),
                    ),
                    titlesData: FlTitlesData(
                      show: true,
                      leftTitles: AxisTitles(
                        drawBelowEverything: true,
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 30,
                          interval: step,
                          getTitlesWidget: (value, meta) {
                            // print(value);
                            return Text(
                              value.toInt().toString(),
                              textAlign: TextAlign.left,
                            );
                          },
                        ),
                      ),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 36,
                          getTitlesWidget: (value, meta) {
                            final index = value.toInt();
                            const style = TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              overflow: TextOverflow.ellipsis,
                            );
                            Widget text = Text(
                              orderStatistics[value.toInt()].month,
                              // style: style,
                            );
                            return SideTitleWidget(
                              axisSide: meta.axisSide,
                              child: text,
                            );
                          },
                        ),
                      ),
                      rightTitles: const AxisTitles(),
                      topTitles: const AxisTitles(),
                    ),
                    gridData: FlGridData(
                      show: true,
                      drawVerticalLine: false,
                      getDrawingHorizontalLine: (value) => FlLine(
                        color: ThemeColor.borderColor.withOpacity(0.2),
                        strokeWidth: 1,
                      ),
                    ),
                    barGroups: orderStatistics.asMap().entries.map((e) {
                      final index = e.key;
                      final data = e.value;
                      return generateBarGroup(
                        index,
                        // data.color,
                        data.count.toDouble(),
                        data.revenue.toDouble(),
                      );
                    }).toList(),
                    maxY: maxCount + step,
                    barTouchData: BarTouchData(
                      enabled: true,
                      handleBuiltInTouches: false,
                      touchTooltipData: BarTouchTooltipData(
                        tooltipBgColor: Colors.transparent,
                        tooltipMargin: 0,
                        getTooltipItem: (
                          BarChartGroupData group,
                          int groupIndex,
                          BarChartRodData rod,
                          int rodIndex,
                        ) {
                          return BarTooltipItem(
                            rod.toY.toString(),
                            TextStyle(
                              fontWeight: FontWeight.bold,
                              color: rod.color,
                              fontSize: 18,
                              shadows: const [
                                Shadow(
                                  color: Colors.black26,
                                  blurRadius: 12,
                                )
                              ],
                            ),
                          );
                        },
                      ),
                      touchCallback: (event, response) {
                        // print(event);
                        if (event.isInterestedForInteractions &&
                            response != null &&
                            response.spot != null) {
                          // print(response.spot!.touchedBarGroupIndex);
                          touchedGroupIndex.value =
                              response.spot!.touchedBarGroupIndex;
                        } else {
                          touchedGroupIndex.value = -2;
                        }
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width ,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 20,
                          height: 20,
                          color: Colors.blueAccent,
                        ),
                        const SizedBox(width: 10),
                        const Text(
                          'Số đơn',
                          style: TextStyle(
                              color: Colors.blueAccent,
                              fontSize: 16,
                              ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 50),
                    Row(
                      children: [
                        Container(
                          width: 20,
                          height: 20,
                          color: Colors.redAccent,
                        ),
                         const SizedBox(width: 10),
                        const Text(
                          'Doanh thu (Triệu đồng)',
                          style: TextStyle(
                              color: Colors.redAccent,
                              fontSize: 16,
                             ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ]),
      ),
    );
  }
}
