import 'dart:math';

import 'package:beanfast_menumanager/services/dashboard_service.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PointDashboard1 extends StatelessWidget {
  PointDashboard1({super.key, required this.bestSellerFoods});
  RxList<BestSellerFood> bestSellerFoods = <BestSellerFood>[].obs;
  late double maxSoldCount;
  late double step;
  @override
  Widget build(BuildContext context) {
    if (bestSellerFoods.isNotEmpty) {
      maxSoldCount =
          bestSellerFoods.map((e) => e.soldCount.toDouble()).reduce(max);
      step = (maxSoldCount / 5).ceil().toDouble();
      return Card(
        child: Container(
          // color: Colors.red,
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const Text(
                'Top 10 thức ăn bán chạy nhất',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 50),
              Obx(
                () => SizedBox(
                  width: MediaQuery.of(context).size.width * 1,
                  height: MediaQuery.of(context).size.height * 0.4,
                  child: BarChart(
                    BarChartData(
                      barTouchData: barTouchData,
                      titlesData: titlesData,
                      borderData: borderData,
                      barGroups: barGroups,
                      gridData: const FlGridData(show: false),
                      alignment: BarChartAlignment.spaceAround,
                      maxY: step * 5,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      );
    } else {
      return const Column(
        children: [
          Text('Chưa có dữ liệu'),
        ],
      );
    }
  }

  BarTouchData get barTouchData => BarTouchData(
        enabled: true,
        touchTooltipData: BarTouchTooltipData(
          tooltipBgColor: Colors.transparent,
          tooltipPadding: EdgeInsets.zero,
          tooltipMargin: 8,
          getTooltipItem: (
            BarChartGroupData group,
            int groupIndex,
            BarChartRodData rod,
            int rodIndex,
          ) {
            return BarTooltipItem(
              rod.toY.round().toString(),
              const TextStyle(
                color: Colors.cyan,
                fontWeight: FontWeight.bold,
              ),
            );
          },
        ),
      );

  Widget getTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Colors.black,
      // fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    String text = bestSellerFoods[value.toInt()].name;

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 4,
      child: Text(text, style: style),
    );
  }

  FlTitlesData get titlesData => FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            getTitlesWidget: getTitles,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: step.toDouble(),
            reservedSize: 35,
          ),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      );

  FlBorderData get borderData => FlBorderData(
        show: false,
      );

  LinearGradient get _barsGradient => const LinearGradient(
        colors: [
          Colors.blueAccent,
          Colors.cyan,
        ],
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
      );

  List<BarChartGroupData> get barGroups {
    final List<BarChartGroupData> barGroups = [];
    for (int i = 0; i < bestSellerFoods.length; i++) {
      var element = bestSellerFoods[i];
      barGroups.add(
        BarChartGroupData(
          x: i,
          barRods: [
            BarChartRodData(
              toY: element.soldCount as double,
              gradient: _barsGradient,
            )
          ],
          showingTooltipIndicators: [0],
        ),
      );
    }
    return barGroups;
  }
}
