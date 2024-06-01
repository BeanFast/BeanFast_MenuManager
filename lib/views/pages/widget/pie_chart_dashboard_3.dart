import 'package:beanfast_menumanager/services/dashboard_service.dart';
import 'package:beanfast_menumanager/views/pages/widget/indicator_pie_chart.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PieChart3 extends StatelessWidget {
  PieChart3(this.topSellerSchool, {super.key});
  RxList<TopSellerSchool> topSellerSchool;
  RxInt touchedIndex = (-1).obs;
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => topSellerSchool.isNotEmpty
          ? Card(
              child: Container(
                padding: const EdgeInsets.all(20),
                width: MediaQuery.of(context).size.width * 1,
                height: MediaQuery.of(context).size.height * 0.3 + 200,
                child: Column(
                  children: [
                    const Text(
                      'Tỉ lệ trường bán chạy nhất',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 1,
                      height: MediaQuery.of(context).size.height * 0.3,
                      child: Row(
                        children: <Widget>[
                          const SizedBox(
                            height: 18,
                          ),
                          Expanded(
                            child: AspectRatio(
                              aspectRatio: 1,
                              child: Obx(
                                () => PieChart(
                                  PieChartData(
                                    pieTouchData: PieTouchData(
                                      touchCallback: (FlTouchEvent event,
                                          pieTouchResponse) {
                                        // if (!event.isInterestedForInteractions ||
                                        //     pieTouchResponse == null ||
                                        //     pieTouchResponse.touchedSection == null) {
                                        //   touchedIndex = RxInt(-1);
                                        //   return;
                                        // }
                                        // touchedIndex = RxInt(pieTouchResponse
                                        //     .touchedSection!.touchedSectionIndex);
                                      },
                                    ),
                                    borderData: FlBorderData(
                                      show: false,
                                    ),
                                    sectionsSpace: 0,
                                    centerSpaceRadius: 40,
                                    sections: showingSections(),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 28,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: showingIndicators(),
                      ),
                    ),
                  ],
                ),
              ),
            )
          : Card(
              child: Container(
                padding: const EdgeInsets.all(20),
                width: MediaQuery.of(context).size.width * 1,
                height: MediaQuery.of(context).size.height * 0.3 + 200,
                child: Column(
                  children: [
                    const Text(
                      'Tỉ lệ trường bán chạy nhất',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 1,
                      height: MediaQuery.of(context).size.height * 0.3,
                      child: const Center(
                        child: Text('Chưa có dữ liệu'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  List<PieChartSectionData> showingSections() {
    return topSellerSchool.asMap().entries.map((e) {
      final index = e.key;
      final data = e.value;
      final isTouched = index == touchedIndex.value;
      final fontSize = isTouched ? 20.0 : 14.0;
      final radius = isTouched ? 80.0 : 75.0;
      return PieChartSectionData(
        color: data.color,
        value: data.percentage,
        title: "${data.percentage}%",
        radius: radius,
        titleStyle: TextStyle(
          fontSize: fontSize,
          color: Colors.black,
        ),
      );
    }).toList();
  }

  List<Widget> showingIndicators() {
    return topSellerSchool.asMap().entries.map((e) {
      final index = e.key;
      final data = e.value;
      final isTouched = index == touchedIndex.value;
      final fontSize = isTouched ? 20.0 : 14.0;
      final radius = isTouched ? 80.0 : 75.0;
      return Indicator(
        color: data.color,
        text: data.schoolName,
        isSquare: false,
      );
    }).toList();
  }
}
