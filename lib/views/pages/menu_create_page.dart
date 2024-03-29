import 'package:beanfast_menumanager/controllers/food_controller.dart';
import 'package:beanfast_menumanager/views/pages/widget/data_table_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class MenuCreateView extends StatelessWidget {
  const MenuCreateView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: ListBody(
            mainAxis: Axis.vertical,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 30),
                child: Center(
                  child: Text(
                    'Tạo thực đơn',
                    style: Get.textTheme.headlineMedium,
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: EdgeInsets.only(right: 20),
                        child: FloatingActionButton.extended(
                          onPressed: showAddFoodToMenuDialog,
                          label: Text('Thêm sản phẩm'),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: EdgeInsets.only(right: 20),
                        child: FloatingActionButton.extended(
                          onPressed: showAddComboToMenuDialog,
                          label: Text('Thêm Combo'),
                        ),
                      ),
                    ),
                    Spacer(flex: 8),
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: EdgeInsets.only(right: 20),
                        child: FloatingActionButton.extended(
                          onPressed: showAddComboToMenuDialog,
                          label: Text('Tạo'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              DataTable(
                columns: const <DataColumn>[
                  DataColumn(
                    label: Text(
                      'Code',
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Hình ảnh',
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Tên sản phẩm',
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Mô tả',
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Loại',
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Combo',
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Giá',
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Giá bán',
                    ),
                  ),
                ],
                rows: <DataRow>[
                  DataRow(
                    cells: <DataCell>[
                      const DataCell(Text('#011111')),
                      DataCell(SizedBox(
                        width: 80,
                        child: Image.network(
                          'https://picsum.photos/250?image=9',
                          fit: BoxFit.fitHeight,
                        ),
                      )),
                      const DataCell(Text('Tên sản phẩm 11111111111111111111111')),
                      const DataCell(Text('Mô tả sản phẩm 1')),
                      const DataCell(Text('Loại 1')),
                      const DataCell(Text('No')),
                      const DataCell(Text('300.000')),
                      DataCell(
                        SizedBox(
                          width: 150,
                          height: 45,
                          child: TextFormField(
                            initialValue: '150.000',
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              CurrencyInputFormatter(),
                            ],
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(),
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a number';
                              }
                              return null;
                            },
                            onSaved: (String? value) {
                              // Save the value
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  DataRow(
                    cells: <DataCell>[
                      const DataCell(Text('#011111')),
                      DataCell(SizedBox(
                        width: 80,
                        child: Image.network(
                          'https://picsum.photos/250?image=9',
                          fit: BoxFit.fitHeight,
                        ),
                      )),
                      const DataCell(Text('Tên sản phẩm 11111111111111111111111')),
                      const DataCell(Text('Mô tả sản phẩm 1')),
                      const DataCell(Text('Loại 1')),
                      const DataCell(Text('No')),
                      const DataCell(Text('300.000')),
                      DataCell(
                        SizedBox(
                          width: 150,
                          height: 45,
                          child: TextFormField(
                            initialValue: '150.000',
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              CurrencyInputFormatter(),
                            ],
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(),
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a number';
                              }
                              return null;
                            },
                            onSaved: (String? value) {
                              // Save the value
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CurrencyInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.isEmpty) {
      return newValue.copyWith(text: '');
    } else if (newValue.text.compareTo(oldValue.text) != 0) {
      int selectionIndexFromTheRight =
          newValue.text.length - newValue.selection.end;
      final f = NumberFormat("#,###", "vi_VN");
      int num = int.parse(newValue.text.replaceAll(f.symbols.GROUP_SEP, ''));
      final newString = f.format(num);
      return TextEditingValue(
        text: newString,
        selection: TextSelection.collapsed(
            offset: newString.length - selectionIndexFromTheRight),
      );
    } else {
      return newValue;
    }
  }
}

void showAddFoodToMenuDialog() {
  final FoodController foodController = Get.put(FoodController());
  Get.dialog(
    AlertDialog(
      content: SizedBox(
        height: Get.height * 0.8,
        width: Get.width,
        child: DataTableView(
          title: 'Danh sách sản phẩm',
          isShowCreateDialog: false,
          showCreateDialog: () {},
          sortColumnIndex: foodController.columnIndex.value,
          sortAscending: foodController.columnAscending.value,
          search: (value) => foodController.search(value),
          refreshData: foodController.refreshData,
          loadPage: (page) => foodController.loadPage(page),
          columns: [
            const DataColumn(
              label: Text('Stt'),
            ),
            const DataColumn(
              label: Text('Code'),
            ),
            const DataColumn(label: Text('Hình ảnh')),
            DataColumn(
                label: const Text('Tên sản phẩm'),
                onSort: (index, ascending) =>
                    foodController.sortByName(index)),
            DataColumn(
                label: const Text('Giá'),
                onSort: (index, ascending) =>
                    foodController.sortByPrice(index)),
            const DataColumn(
              label: Text('Loại'),
            ),
            const DataColumn(label: Text('Trạng thái')),
            const DataColumn(label: Text(' ')),
          ],
          rows: const [],
        ),
      ),
    ),
  );
}

void showAddComboToMenuDialog() {
  Get.dialog(
    ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 1200),
      child: AlertDialog(
        title: const Text('Thông tin combo'),
        content: SingleChildScrollView(
          child: SizedBox(
            width: 1190,
            child: ListBody(
              mainAxis: Axis.vertical,
              children: <Widget>[
                TextField(
                  decoration: const InputDecoration(
                    labelText: 'Tìm Kiếm',
                  ),
                  style: Get.theme.textTheme.bodyMedium,
                ),
                SingleChildScrollView(
                  child: DataTable(
                    columns: const <DataColumn>[
                      DataColumn(
                        label: Text(
                          'Mã số sản phẩm',
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'Hình ảnh',
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'Tên sản phẩm',
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'Mô tả',
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'Loại',
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'Giá bán',
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
                          const DataCell(Text('#011111')),
                          DataCell(SizedBox(
                            width: 80,
                            child: Image.network(
                              'https://picsum.photos/250?image=9',
                              fit: BoxFit.fitHeight,
                            ),
                          )),
                          const DataCell(Text('Tên sản phẩm ')),
                          const DataCell(Text('Mô tả sản phẩm 1')),
                          const DataCell(Text('Loại 1')),
                          const DataCell(Text('15.000 vnd')),
                          DataCell(
                            SizedBox(
                              width: 100,
                              height: 30,
                              child: FloatingActionButton.extended(
                                onPressed: () {},
                                label: const Text('Thêm'),
                              ),
                            ),
                          ),
                        ],
                      ),
                      DataRow(
                        cells: <DataCell>[
                          const DataCell(Text('#011111')),
                          DataCell(SizedBox(
                            width: 80,
                            child: Image.network(
                              'https://picsum.photos/250?image=9',
                              fit: BoxFit.fitHeight,
                            ),
                          )),
                          const DataCell(Text('Tên sản phẩm ')),
                          const DataCell(Text('Mô tả sản phẩm 1')),
                          const DataCell(Text('Loại 1')),
                          const DataCell(Text('15.000 vnd')),
                          DataCell(
                            SizedBox(
                              width: 100,
                              height: 30,
                              child: FloatingActionButton.extended(
                                onPressed: () {},
                                label: const Text('Thêm'),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
