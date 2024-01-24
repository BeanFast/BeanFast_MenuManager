import 'package:beanfast_menumanager/controllers/food_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/logger.dart';
import '../../utils/data_table.dart';
// import 'package:beanfast_menumanager/controllers/home_controller.dart';

class FoodView extends StatelessWidget {
  FoodView({super.key});
  final FoodController _foodController = Get.find();
  @override
  Widget build(BuildContext context) {
    final List<DataRow> rows = _foodController.rows;
    logger.i('build FoodView');
    final _formKey = GlobalKey<FormState>();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: FloatingActionButton.extended(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Thông tin món ăn'),
                          content: SingleChildScrollView(
                            child: ListBody(
                              mainAxis: Axis.vertical,
                              children: <Widget>[
                                SizedBox(
                                  width: 500,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: FloatingActionButton.extended(
                                      icon: const Icon(Icons.add),
                                      label: const Text('Chọn Ảnh'),
                                      onPressed: () {},
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextFormField(
                                    decoration: const InputDecoration(
                                      labelText: 'Tên Sản Phẩm',
                                      border: OutlineInputBorder(),
                                    ),
                                    validator: (value) {
                                      if (value == null ||
                                          value.isEmpty
                                         ) {
                                        return 'Vui lòng nhập tên sản phẩm';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextFormField(
                                    decoration: const InputDecoration(
                                      labelText: 'Giá',
                                      border: OutlineInputBorder(),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Vui lòng nhập giá';
                                      }
                                      // Check if the value is a number
                                      if (double.tryParse(value) == null) {
                                        return 'Giá không hợp lệ';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: DropdownButtonFormField<String>(
                                    decoration: const InputDecoration(
                                        labelText: 'Loại'),
                                    items: <String>[
                                      'Loại 1',
                                      'Loại 2',
                                      'Loại 3',
                                      'Loại 4',
                                      'Loại 5',
                                    ].map<DropdownMenuItem<String>>(
                                        (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                    validator: (String? value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Vui Lòng chọn loại';
                                      }
                                      return null;
                                    },
                                    onChanged: (String? newValue) {},
                                  ),
                                ),
                              ],
                            ),
                          ),
                          actions: <Widget>[
                            TextButton(
                              child: const Text('Lưu'),
                              onPressed: () {
                             if (_formKey.currentState!.validate()) {
                          // If all form fields are valid, save the data
                          // Add your save logic here
                          Navigator.of(context).pop();
                        }
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                  label: const Text('Thêm món ăn'),
                ),
              ),
              PaginatedDataTable(
                header: const Text('Data Table Header'),
                rowsPerPage: 10, // Number of rows per page
                columns: const [
                  DataColumn(label: Text('STT')),
                  DataColumn(label: Text('Code')),
                  DataColumn(label: Text('Hình ảnh')),
                  DataColumn(label: Text('Sản phẩm')),
                  DataColumn(label: Text('Giá')),
                  DataColumn(label: Text('Loại')),
                  DataColumn(label: Text('Trạng thái')),
                  DataColumn(label: Text(' ')),
                  // Add more DataColumn widgets as needed
                ],
                source: MyDataTable(rows: rows),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
