import 'package:beanfast_menumanager/views/dialog/create_gate_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showCreateSchoolDialog() {
  Get.dialog(
    ConstrainedBox(
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
                        onPressed: () => showCreateGateDialog(),
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
                        const DataCell(Text('1')),
                        const DataCell(Text('Cổng A')),
                        const DataCell(Text('Some description')),
                        DataCell(IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              Get.defaultDialog(
                                title: 'Xác nhận',
                                content:
                                    const Text('Bạn có chắc chắn muốn xoá cổng này?'),
                                actions: [
                                  ElevatedButton(
                                    onPressed: () {
                                      // Đóng AlertDialog khi người dùng nhấn nút
                                      Get.back();
                                    },
                                    child: const Text('Close'),
                                  ),
                                ],
                              );
                            }))
                        //   showDialog(
                        //     context: context,
                        //     builder: (BuildContext context) {
                        //       return AlertDialog(
                        //         title: const Text(''),
                        //         content: const Text(
                        //             ''),
                        //         actions: <Widget>[
                        //           TextButton(
                        //             child: const Text('Đồng ý'),
                        //             onPressed: () {
                        //               Navigator.of(context).pop();
                        //             },
                        //           ),
                        //           TextButton(
                        //             child: const Text('Đóng'),
                        //             onPressed: () {
                        //               Navigator.of(context).pop();
                        //             },
                        //           ),
                        //         ],
                        //       );
                        //     },
                        //   );
                        // })),
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
