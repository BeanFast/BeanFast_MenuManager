import 'package:beanfast_menumanager/services/dashboard_service.dart';
import 'package:beanfast_menumanager/views/pages/widget/app_color_dashboard.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'dart:math';

class LineChartSample2 extends StatelessWidget {
  LineChartSample2({super.key, required this.list});
  RxList<OrderStatisticByDays> list = <OrderStatisticByDays>[].obs;

  final List<Color> gradientColors = [
    AppColors.contentColorCyan,
    AppColors.contentColorBlue,
  ];
  @override
  Widget build(BuildContext context) {
    return Obx(() => list.isNotEmpty
        ? Stack(
            children: <Widget>[
              SizedBox(
                width: MediaQuery.of(context).size.width * 1,
                height: MediaQuery.of(context).size.height * 0.5,
                child: LineChart(
                  mainData(),
                ),
              ),
              // SizedBox(
              //   width: 60,
              //   height: 20,
              //   child: TextButton(
              //     onPressed: () {
              //       setState(() {
              //         showAvg = !showAvg;
              //       });
              //     },
              //     child: Text(
              //       'avg',
              //       style: TextStyle(
              //         fontSize: 12,
              //         color: showAvg ? Colors.white.withOpacity(0.5) : Colors.white,
              //       ),
              //     ),
              //   ),
              // ),
            ],
          )
        : const Column(
            children: [
              Text("Chưa có dữ liệu"),
            ],
          ),);
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 16,
    );
    Widget text;
    text = Text(list.elementAt(value.toInt()).day, style: style);
    // switch (value.toInt()) {
    //   case 2:
    //     text = const Text('MAR', style: style);
    //     break;
    //   case 5:
    //     text = const Text('JUN', style: style);
    //     break;
    //   case 8:
    //     text = const Text('SEP', style: style);
    //     break;
    //   default:
    //     text = const Text('', style: style);
    //     break;
    // }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: text,
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 15,
    );
    String text = value.toInt().toString();
    return Text(text, style: style, textAlign: TextAlign.left);
  }

  LineChartData mainData() {
    double maxCount = list.isNotEmpty
        ? list
            .map((e) => e.count)
            .reduce((max, value) => max > value ? max : value)
            .toDouble()
        : 0;

    double minCount = list.isNotEmpty
        ? list
            .map((e) => e.count)
            .reduce((min, value) => min < value ? min : value)
            .toDouble()
        : 0;
    double step = (maxCount - minCount) / 5;
    int intStep = step.floor();
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        horizontalInterval: 1,
        verticalInterval: 1,
        getDrawingHorizontalLine: (value) {
          return const FlLine(
            color: AppColors.mainGridLineColor,
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return const FlLine(
            color: AppColors.mainGridLineColor,
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            interval: 1,
            getTitlesWidget: bottomTitleWidgets,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: intStep.toDouble(),
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 42,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(color: const Color(0xff37434d)),
      ),
      minX: 0,
      maxX: 7,
      minY: 0,
      maxY: (list.isNotEmpty
              ? list
                  .map((e) => e.count)
                  .reduce((max, value) => max > value ? max : value)
                  .toDouble()
              : 0) +
          2,
      lineBarsData: [
        LineChartBarData(
          spots: list
              .map(
                  (e) => FlSpot(list.indexOf(e).toDouble(), e.count.toDouble()))
              .toList(),
          isCurved: false,
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: const FlDotData(
            show: true,
          ),
          belowBarData:
              BarAreaData(show: true, color: gradientColors[1].withOpacity(0.3)
                  // gradient: LinearGradient(
                  //   colors: gradientColors
                  //       .map((color) => color.withOpacity(0.3))
                  //       .toList(),
                  // ),
                  ),
        ),
      ],
    );
  }

  // int a = 0;
  // @override
  // State<LineChartSample2> createState() => _LineChartSample2State(a);
}

// class _LineChartSample2State extends State<LineChartSample2> {
//   // bool showAvg = false;
// }
