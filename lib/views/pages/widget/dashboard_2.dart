import 'package:beanfast_menumanager/services/dashboard_service.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PointDashboard2 extends StatelessWidget {
  PointDashboard2({super.key, required this.orderStatistics});
  RxList<OrderStatistic> orderStatistics = <OrderStatistic>[].obs;

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
      print("min: $minCount");
      return Card(
        child: Container(
          // color: Colors.red,
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const Text(
                'Tổng kết giao dịch điểm (6 tháng)',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 50),
              SizedBox(
                width: MediaQuery.of(context).size.width * 1,
                height: MediaQuery.of(context).size.height * 0.4,
                child: LineChart(lineChartData
                    // lineChartData: lineChartData,
                    ),
              ),
            ],
          ),
        ),
      );
    }
  }

  FlGridData get gridData => const FlGridData(show: true);
  LineChartData get lineChartData => LineChartData(
        lineTouchData: lineTouchData,
        gridData: gridData,
        titlesData: titlesData,
        borderData: borderData,
        lineBarsData: lineBarsData1,
        minX: minCount.toDouble(),
        maxX: orderStatistics.length.toDouble() - 1,
        maxY: 50,
        minY: 0,
      );
  List<LineChartBarData> get lineBarsData1 {
    // print(lineChartBarData1_1);
    return [
      lineChartBarData1_1,
      lineChartBarData1_2,
    ];
  }

  LineChartBarData get lineChartBarData1_1 {
    List<FlSpot> spots = [];
    for (var i = 0; i < orderStatistics.length; i++) {
      print(i.toDouble() + 1);
      print(orderStatistics[i].revenue / 1000000);
      spots.add(FlSpot(i.toDouble(), orderStatistics[i].revenue / 1000));
    }
    return LineChartBarData(
      isCurved: false,
      color: Colors.blue,
      barWidth: 8,
      isStrokeCapRound: true,
      dotData: const FlDotData(show: false),
      belowBarData: BarAreaData(
        show: false,
        color: Colors.pink,
      ),
      spots: spots,
    );
  }

  LineChartBarData get lineChartBarData1_2 {
    List<FlSpot> spots = [];
    for (var i = 0; i < orderStatistics.length; i++) {
      print(i.toDouble() + 1);
      print(orderStatistics[i].revenue / 1000000);
      spots.add(FlSpot(i.toDouble(), orderStatistics[i].count.toDouble()));
    }
    return LineChartBarData(
      isCurved: false,
      color: Colors.green,
      barWidth: 8,
      isStrokeCapRound: true,
      dotData: const FlDotData(show: false),
      belowBarData: BarAreaData(
        show: false,
        color: Colors.pink,
      ),
      spots: spots,
    );
  }

  FlBorderData get borderData => FlBorderData(
        show: true,
        border: Border(
          bottom: BorderSide(color: Colors.green.withOpacity(0.2), width: 4),
          left: const BorderSide(color: Colors.transparent),
          right: const BorderSide(color: Colors.transparent),
          top: const BorderSide(color: Colors.transparent),
        ),
      );
  LineTouchData get lineTouchData => LineTouchData(
        handleBuiltInTouches: true,
        touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: Colors.blueGrey.withOpacity(0.8),
        ),
      );
  FlTitlesData get titlesData => FlTitlesData(
        bottomTitles: AxisTitles(
          sideTitles: bottomTitles,
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        leftTitles: AxisTitles(
          sideTitles: leftTitles(),
        ),
      );

  SideTitles get bottomTitles => SideTitles(
        showTitles: true,
        reservedSize: 32,
        interval: 1,
        getTitlesWidget: bottomTitleWidgets,
      );
  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 16,
    );
    Widget text;
    // print(value.toInt());
    text = Text(orderStatistics[value.toInt()].count.toString(), style: style);
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 10,
      child: text,
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    String text = value.toInt().toString();
    return Text(text, style: style, textAlign: TextAlign.center);
  }

  SideTitles leftTitles() => SideTitles(
        getTitlesWidget: leftTitleWidgets,
        showTitles: true,
        interval: 10,
        reservedSize: 40,
      );
}
