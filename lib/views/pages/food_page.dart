import 'package:beanfast_menumanager/controllers/food_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:flutter_quill/flutter_quill.dart' as quill;
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
              Row(
                children: [
                  FloatingActionButton.extended(
                    icon: const Icon(Icons.update),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return UpdateFoodDialog(_formKey, context);
                        },
                      );
                    },
                    label: const Text('Cập nhật món ăn'),
                  ),
                  FloatingActionButton.extended(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return DeleteFoodDialog(_formKey, context);
                        },
                      );
                    },
                    label: const Text('Xoá món ăn'),
                  ),
                  FloatingActionButton.extended(
                    icon: const Icon(Icons.add),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return CreateFoodDialog(_formKey, context);
                        },
                      );
                    },
                    label: const Text('Thêm món ăn'),
                  ),
                  FloatingActionButton.extended(
                    icon: const Icon(Icons.school),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return CreateSchool(_formKey, context);
                        },
                      );
                    },
                    label: const Text('Thêm trường học'),
                  ),
                ],
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

  Dialog CreateFoodDialog(GlobalKey<FormState> _formKey, BuildContext context) {
    return Dialog(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 1000),
        child: AlertDialog(
          title: const Text('Thông tin món ăn'),
          content: SingleChildScrollView(
            child: SizedBox(
              width: 990,
              child: ListBody(
                mainAxis: Axis.vertical,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 5.0, right: 5.0, bottom: 10.0, top: 10.0),
                    child: FloatingActionButton.extended(
                      icon: const Icon(Icons.add),
                      label: const Text('Chọn Ảnh'),
                      onPressed: () {},
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 5.0, right: 5.0, bottom: 10.0, top: 10.0),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Tên Sản Phẩm',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Vui lòng nhập tên sản phẩm';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 5.0, right: 5.0, bottom: 10.0, top: 10.0),
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
                    padding: const EdgeInsets.only(
                        left: 5.0, right: 5.0, bottom: 10.0, top: 10.0),
                    child: DropdownButtonFormField<String>(
                      decoration: const InputDecoration(labelText: 'Loại'),
                      items: <String>[
                        'Loại 1',
                        'Loại 2',
                        'Loại 3',
                        'Loại 4',
                        'Loại 5',
                      ].map<DropdownMenuItem<String>>((String value) {
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
          ),
          actions: <Widget>[
            FloatingActionButton.extended(
              icon: const Icon(Icons.add),
              label: const Text('Lưu'),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }

  Dialog UpdateFoodDialog(GlobalKey<FormState> _formKey, BuildContext context) {
    return Dialog(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1000),
        child: AlertDialog(
          title: const Text('Thông tin món ăn'),
          content: SingleChildScrollView(
            child: SizedBox(
              width: 990,
              child: ListBody(
                mainAxis: Axis.vertical,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 5.0, right: 5.0, bottom: 10.0, top: 10.0),
                    child: Image.network(
                      'https://picsum.photos/250?image=9',
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 5.0, right: 5.0, bottom: 10.0, top: 10.0),
                    child: FloatingActionButton.extended(
                      icon: const Icon(Icons.add),
                      label: const Text('Chọn Ảnh'),
                      onPressed: () {},
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 5.0, right: 5.0, bottom: 10.0, top: 10.0),
                    child: TextFormField(
                      initialValue: 'Tên sản phẩm',
                      decoration: const InputDecoration(
                        labelText: 'Tên Sản Phẩm',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Vui lòng nhập tên sản phẩm';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 5.0, right: 5.0, bottom: 10.0, top: 10.0),
                    child: TextFormField(
                      initialValue: 'Giá',
                      decoration: const InputDecoration(
                        labelText: 'Giá',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Vui lòng nhập giá';
                        }
                        if (double.tryParse(value) == null) {
                          return 'Giá không hợp lệ';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 5.0, right: 5.0, bottom: 10.0, top: 10.0),
                    child: DropdownButtonFormField<String>(
                      value: 'Loại 1',
                      decoration: const InputDecoration(labelText: 'Loại'),
                      items: <String>[
                        'Loại 1',
                        'Loại 2',
                        'Loại 3',
                        'Loại 4',
                        'Loại 5',
                      ].map<DropdownMenuItem<String>>((String value) {
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
          ),
          actions: <Widget>[
            FloatingActionButton.extended(
              icon: const Icon(Icons.add),
              label: const Text('Cập nhật'),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }

  AlertDialog DeleteFoodDialog(
      GlobalKey<FormState> _formKey, BuildContext context) {
    return AlertDialog(
      title: Text('Xác nhận'),
      content: Text('Bạn có chắc chắn muốn xoá món ăn này?'),
      actions: <Widget>[
        TextButton(
          child: Text('Đồng ý'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: Text('Đóng'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }

  Dialog CreateSchool(GlobalKey<FormState> _formKey, BuildContext context) {
    return Dialog(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1000),
        child: AlertDialog(
          title: const Text('Thông trường học'),
          content: SingleChildScrollView(
            child: SizedBox(
              width: 990,
              child: ListBody(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 5.0, right: 5.0, bottom: 10.0, top: 10.0),
                    child: Image.network(
                      'https://picsum.photos/250?image=9',
                      fit: BoxFit.cover,
                    ),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 5.0, right: 5.0, bottom: 10.0, top: 10.0),
                      child: SizedBox(
                        width: 140,
                        height: 40,
                        child: FloatingActionButton.extended(
                          icon: const Icon(Icons.add),
                          label: const Text('Thay đổi ảnh'),
                          onPressed: () {},
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 5.0, right: 5.0, bottom: 10.0, top: 10.0),
                    child: SizedBox(
                      child: TextFormField(
                        // initialValue: 'Tên sản phẩm',
                        decoration: const InputDecoration(
                          labelText: 'Tên trường',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Vui lòng nhập tên trường';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 5.0, right: 5.0, bottom: 10.0, top: 10.0),
                    child: DropdownButtonFormField<String>(
                      // value: 'Khu vực',
                      decoration: const InputDecoration(labelText: 'Khu vực'),
                      items: <String>[
                        'Khu vực 1',
                        'Khu vực 2',
                        'Khu vực 3',
                        'Khu vực 4',
                      ].map<DropdownMenuItem<String>>((String value) {
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
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 5.0, right: 5.0, bottom: 10.0, top: 10.0),
                    child: SizedBox(
                      child: TextFormField(
                        // initialValue: 'Tên sản phẩm',
                        decoration: const InputDecoration(
                          labelText: 'Địa chỉ',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Vui lòng nhập địa chỉ';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 5.0, right: 5.0, bottom: 10.0, top: 10.0),
                      child: SizedBox(
                        height: 40,
                        child: FloatingActionButton.extended(
                          icon: const Icon(Icons.add),
                          label: const Text('Thêm cổng trường học'),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return CreateGate(_formKey, context);
                              },
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  DataTable(
                    columns: const <DataColumn>[
                      DataColumn(
                        label: Text(
                          'STT',
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'Tên cổng',
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'Mô tả',
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          ' ',
                        ),
                      ),
                    ],
                    rows: <DataRow>[
                      DataRow(
                        cells: <DataCell>[
                          DataCell(Text('1')),
                          DataCell(Text('Cổng A')),
                          DataCell(Text('Some description')),
                          DataCell(IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text('Xác nhận'),
                                      content: const Text(
                                          'Bạn có chắc chắn muốn xoá cổng này?'),
                                      actions: <Widget>[
                                        TextButton(
                                          child: const Text('Đồng ý'),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                        TextButton(
                                          child: const Text('Đóng'),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                              })),
                        ],
                      ),
                      // DataRow(
                      //   cells: <DataCell>[
                      //     DataCell(Text('2')),
                      //     DataCell(Text('Cổng B')),
                      //     DataCell(Text('Some description')),
                      //     DataCell(IconButton(
                      //         icon: Icon(Icons.delete), onPressed: () {})),
                      //     // New DataCell for the new DataColumn
                      //   ],
                      // ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          actions: <Widget>[
            FloatingActionButton.extended(
              icon: const Icon(Icons.add),
              label: const Text('Lưu'),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }

  Dialog CreateGate(GlobalKey<FormState> _formKey, BuildContext context) {
    return Dialog(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 700),
        child: AlertDialog(
          title: const Text('Thông tin cổng trường học'),
          content: SingleChildScrollView(
            child: SizedBox(
              width: 690,
              child: ListBody(
                mainAxis: Axis.vertical,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 5.0, right: 5.0, bottom: 10.0, top: 10.0),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Tên cổng trường học',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Vui lòng nhập tên cổng trường';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 5.0, right: 5.0, bottom: 10.0, top: 10.0),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Mô tả',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Vui lòng nhập mô tả';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          actions: <Widget>[
            FloatingActionButton.extended(
              label: const Text('Lưu'),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
