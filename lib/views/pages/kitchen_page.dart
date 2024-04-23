import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/models/kitchen.dart';
import '/controllers/kitchen_controller.dart';
import '/views/pages/loading_page.dart';
import '/views/pages/widget/data_table_page.dart';
import '/views/pages/widget/button_data_table.dart';
import '/views/pages/widget/text_data_table_widget.dart';

class KitchenView extends GetView<KitchenController> {
  const KitchenView({super.key});

  @override
  Widget build(BuildContext context) {
    return LoadingView(
      future: controller.refreshData,
      child: Obx(
        () => DataTableView(
          title: 'Quản lý bếp',
          isShowCreateDialog: true,
          showCreateDialog: showCreateKitchenDialog,
          refreshData: controller.refreshData,
          loadPage: (page) => controller.loadPage(page),
          search: (value) {
            controller.searchString.value = value;
            controller.searchName();
          },
          sortColumnIndex: controller.columnIndex.value,
          sortAscending: controller.columnAscending.value,
          columns: <DataColumn>[
            const DataColumn(
              label: Text('Stt'),
            ),
            const DataColumn(
              label: Text('Code'),
            ),
            const DataColumn(label: Text('Hình ảnh')),
            DataColumn(
                label: const Text('Tên trường'),
                onSort: (index, ascending) => controller.sortByName(index)),
            const DataColumn(
              label: Text('Địa chỉ'),
            ),
            const DataColumn(
              label: Text('Trường phụ trách'),
            ),
            const DataColumn(
              label: Text('Số trường'),
            ),
            const DataColumn(label: Text(' ')),
          ],
          // ignore: invalid_use_of_protected_member
          rows: controller.rows.value,
        ),
      ),
    );
  }

  DataRow setRow(int index, Kitchen kitchen) {
    return DataRow(
      cells: [
        DataCell(Text((index + 1).toString())),
        DataCell(
          TextDataTable(
            data: kitchen.code.toString(),
            maxLines: 2,
            width: 100,
          ),
        ),
        DataCell(
          SizedBox(
            // height: ,
            width: 100,
            child: Image.network(
              kitchen.imagePath.toString(),
              fit: BoxFit.fitWidth,
            ),
          ),
        ),
        DataCell(
          TextDataTable(
            data: kitchen.name.toString(),
            maxLines: 2,
            width: 200,
          ),
        ),
        DataCell(Text(kitchen.address.toString())),
        DataCell(Text(kitchen.address.toString())),
        DataCell(Text(kitchen.schoolCount!.toString())),
        DataCell(Row(
          children: [
            const Spacer(),
            // DetailButtonDataTable(goToPage: Get.to(MenuManagementView())!),
            EditButtonDataTable(onPressed: () {}),
            DeleteButtonDataTable(onPressed: () {}),
          ],
        )),
      ],
    );
  }

  
void showCreateKitchenDialog() {
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
                Obx(() => Padding(
                      padding: const EdgeInsets.only(
                          left: 5.0, right: 5.0, bottom: 10.0, top: 10.0),
                      child: Get.find<KitchenController>().imagePath.isEmpty
                          ? const Text('No image selected')
                          : Image.network(
                              Get.find<KitchenController>().imagePath.value,
                              fit: BoxFit.cover,
                            ),
                    )),
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
                        onPressed: () {},
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
                                content: const Text(
                                    'Bạn có chắc chắn muốn xoá cổng này?'),
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

}
