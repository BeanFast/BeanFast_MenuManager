import 'package:beanfast_menumanager/contrains/theme_color.dart';
import 'package:beanfast_menumanager/services/dashboard_service.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';

class PointDashboard2 extends StatelessWidget {
  PointDashboard2({super.key, required this.orderStatistics});
  RxList<OrderStatistic> orderStatistics = <OrderStatistic>[].obs;
  RxInt touchedGroupIndex = (-1).obs;

  BarChartGroupData generateBarGroup(
    int x,
    double count,
    double revenue,
  ) {
    print("x: $x");
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
  @override
  Widget build(BuildContext context) {
    // Iterate through the remaining elements, updating minCount if necessary
    if (orderStatistics.isEmpty) {
      return const Column(
        children: [
          Text('Chưa có dữ liệu'),
        ],
      );
    } else {
      for (var item in orderStatistics) {
        if (item.count < minCount) {
          minCount = item.count;
        }
      }
      return Card(
        child: Container(
          // color: Colors.red,
          padding: const EdgeInsets.all(20),
          child: Column(children: [
            const Text(
              'Tổng kết giao dịch điểm (6 tháng)',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 50),
            SizedBox(
              width: MediaQuery.of(context).size.width * 1,
              height: MediaQuery.of(context).size.height * 0.4,
              child: Obx(
                () => BarChart(
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
                          getTitlesWidget: (value, meta) {
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
                              color: Colors.black12,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            );
                            Widget text = Text(
                              orderStatistics[value.toInt()].month,
                              style: style,
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
                    maxY: 50,
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
                          print(response.spot!.touchedBarGroupIndex);
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
            )
          ]),
        ),
      );
    }
  }
}
