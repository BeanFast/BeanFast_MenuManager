import 'package:beanfast_menumanager/utils/logger.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// import 'package:beanfast_menumanager/controllers/home_controller.dart';

class MyController extends GetxController {
  final data = <String, dynamic>{};

  @override
  void onInit() {
    super.onInit();
    data['name'] = 'John Doe';
    data['age'] = 30;
    data['address'] = '123 Main Street, New York, NY 10001';
  }
}

class FoodView extends StatelessWidget {
  const FoodView({super.key});
  @override
  Widget build(BuildContext context) {
    logger.i('build FoodView');
    MyController _foodController = Get.put(MyController());
    return GetBuilder<MyController>(
      builder: (_) {
        return DataTable(
          columns: const [
            DataColumn(label: Text('Name')),
            DataColumn(label: Text('Age')),
            DataColumn(label: Text('Address')),
          ],
          rows: _foodController.data.entries.map((e) {
            return DataRow(
              cells: [
                DataCell(Text(e.key)),
                DataCell(Text('e.value.toString()')),
                DataCell(Text(e.value['address'])),
              ],
            );
          }).toList(),
        );
      },
    );
  }
}
