import 'package:beanfast_menumanager/services/dashboard_service.dart';
import 'package:beanfast_menumanager/views/pages/widget/indicator_pie_chart.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PieChart1 extends StatelessWidget {
  RxList<BestSellerCategory> bestSellerCategory;
  PieChart1(this.bestSellerCategory, {super.key});
  RxInt touchedIndex = (-1).obs;
  @override
  Widget build(BuildContext context) {
    return Obx(() => bestSellerCategory.isNotEmpty
        ? Card(
            child: Container(
              padding: const EdgeInsets.all(20),
              width: MediaQuery.of(context).size.width * 1,
              height: MediaQuery.of(context).size.height * 0.3 + 140,
              child: Column(
                children: [
                  const Text(
                    'Top 10 tỉ lệ danh mục sản phẩm bán chạy nhất',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
                                    touchCallback:
                                        (FlTouchEvent event, pieTouchResponse) {
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
                  // ignore: prefer_const_constructors
                  SizedBox(
                    height: 10,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: showingIndicators(),
                  ),
                ],
              ),
            ),
          )
        : const Column(
            children: [Text("Chưa có dữ liệu")],
          ));
  }

  List<PieChartSectionData> showingSections() {
    return bestSellerCategory.asMap().entries.map((e) {
      final index = e.key;
      final data = e.value;
      final isTouched = index == touchedIndex.value;
      final fontSize = isTouched ? 20.0 : 14.0;
      final radius = isTouched ? 80.0 : 75.0;
      return PieChartSectionData(
        color: data.color,
        value: data.totalSold,
        title: "${data.totalSold}%",
        radius: radius,
        titleStyle: TextStyle(
          fontSize: fontSize,
          color: Colors.black,
        ),
      );
    }).toList();
  }

  List<Widget> showingIndicators() {
    return bestSellerCategory.asMap().entries.map((e) {
      final index = e.key;
      final data = e.value;
      final isTouched = index == touchedIndex.value;
      final fontSize = isTouched ? 20.0 : 14.0;
      final radius = isTouched ? 80.0 : 75.0;
      return Indicator(
        color: data.color,
        text: data.category,
        isSquare: false,
      );
    }).toList();
  }
  // @override
  // State<StatefulWidget> createState() => PieChart2State();
}
