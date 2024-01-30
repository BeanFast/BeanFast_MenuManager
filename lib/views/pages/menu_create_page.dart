import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class MenuCreateView extends StatelessWidget {
  const MenuCreateView({super.key});

   @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
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
              const Row(
                children: [
                  SizedBox(
                    width: 150,
                    height: 30,
                    child: Padding(
                      padding: EdgeInsets.only(right: 20),
                      child: SizedBox(
                        width: 150,
                        height: 30,
                        child: FloatingActionButton.extended(
                          onPressed: showAddFoodToMenuDialog,
                          label: Text('Thêm sản phẩm'),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 150,
                    height: 30,
                    child: SizedBox(
                      width: 150,
                      height: 30,
                      child: FloatingActionButton.extended(
                        onPressed: showAddComboToMenuDialog,
                        label: Text('Thêm Combo'),
                      ),
                    ),
                  ),
                  Spacer(),
                  // SizedBox(
                  //   width: 150,
                  //   height: 30,
                  //   child: 
                  //   CreateButtonDataTable(
                  //       showDialog: showMenuSelectionDialog),
                  // ),
                ],
              ),
              DataTable(
                columns: const <DataColumn>[
                  DataColumn(
                    label: Expanded(
                      child: Text(
                        'Mã số sản phẩm',
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Expanded(
                      child: Text(
                        'Hình ảnh',
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Expanded(
                      child: Text(
                        'Tên sản phẩm',
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Expanded(
                      child: Text(
                        'Mô tả',
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Expanded(
                      child: Text(
                        'Loại',
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Expanded(
                      child: Text(
                        'Combo',
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Expanded(
                      child: Text(
                        'Giá bản mặc định',
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Expanded(
                      child: Text(
                        'Giá bán',
                      ),
                    ),
                  ),
                ],
                rows: <DataRow>[
                  DataRow(
                    cells: <DataCell>[
                      DataCell(Text('#011111')),
                      DataCell(Image.network(
                        'https://picsum.photos/250?image=9',
                        fit: BoxFit.fitHeight,
                      )),
                      DataCell(Text('Tên sản phẩm 1')),
                      DataCell(Text('Mô tả sản phẩm 1')),
                      DataCell(Text('Loại 1')),
                      DataCell(Text('No')),
                      DataCell(Text('15.000 vnd')),
                      DataCell(
                        Container(
                          width: 200,
                          child: TextFormField(
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
                      DataCell(Text('#011111')),
                      DataCell(Image.network(
                        'https://picsum.photos/250?image=9',
                        fit: BoxFit.fitHeight,
                      )),
                      DataCell(
                          Text('Tên sản phẩm 11111111111111111111111')),
                      DataCell(Text('Mô tả sản phẩm 1')),
                      DataCell(Text('Loại 1')),
                      DataCell(Text('No')),
                      DataCell(Text('15.000 vnd')),
                      DataCell(
                        Container(
                          width: 200,
                          child: TextFormField(
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
  Get.dialog(
    ConstrainedBox(
      constraints: BoxConstraints(maxWidth: 1200),
      child: AlertDialog(
        title: const Text('Thông tin món ăn'),
        content: SingleChildScrollView(
          child: SizedBox(
            width: 1190,
            child: ListBody(
              mainAxis: Axis.vertical,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Expanded(
                    child: TextField(
                      // onChanged: (value) {
                      //   _foodController.searchString.value = value;
                      //   _foodController.searchName();
                      // },
                      decoration: const InputDecoration(
                        labelText: 'Tìm theo tên sản phẩm / mã sản phẩm',
                      ),
                      style: Get.theme.textTheme.bodyMedium,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Align(
                    child: Expanded(
                      child: SingleChildScrollView(
                        child: DataTable(
                          columns: const <DataColumn>[
                            DataColumn(
                              label: Expanded(
                                child: Text(
                                  'Mã số sản phẩm',
                                ),
                              ),
                            ),
                            DataColumn(
                              label: Expanded(
                                child: Text(
                                  'Hình ảnh',
                                ),
                              ),
                            ),
                            DataColumn(
                              label: Expanded(
                                child: Text(
                                  'Tên sản phẩm',
                                ),
                              ),
                            ),
                            DataColumn(
                              label: Expanded(
                                child: Text(
                                  'Mô tả',
                                ),
                              ),
                            ),
                            DataColumn(
                              label: Expanded(
                                child: Text(
                                  'Loại',
                                ),
                              ),
                            ),
                            DataColumn(
                              label: Expanded(
                                child: Text(
                                  'Giá bán',
                                ),
                              ),
                            ),
                            DataColumn(
                              label: Expanded(
                                child: Text(
                                  ' ',
                                ),
                              ),
                            ),
                          ],
                          rows: <DataRow>[
                            DataRow(
                              cells: <DataCell>[
                                DataCell(Text('#011111')),
                                DataCell(Image.network(
                                  'https://picsum.photos/250?image=9',
                                  fit: BoxFit.fitHeight,
                                )),
                                DataCell(Text('Tên sản phẩm ')),
                                DataCell(Text('Mô tả sản phẩm 1')),
                                DataCell(Text('Loại 1')),
                                DataCell(Text('15.000 vnd')),
                                DataCell(
                                  SizedBox(
                                    width: 100,
                                    height: 30,
                                    child: FloatingActionButton.extended(
                                      onPressed: () {},
                                      label: Text('Thêm'),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            DataRow(
                              cells: <DataCell>[
                                DataCell(Text('#011111')),
                                DataCell(Image.network(
                                  'https://picsum.photos/250?image=9',
                                  fit: BoxFit.fitHeight,
                                )),
                                DataCell(Text('Tên sản phẩm ')),
                                DataCell(Text('Mô tả sản phẩm 1')),
                                DataCell(Text('Loại 1')),
                                DataCell(Text('15.000 vnd')),
                                DataCell(
                                  SizedBox(
                                    width: 100,
                                    height: 30,
                                    child: FloatingActionButton.extended(
                                      onPressed: () {},
                                      label: Text('Thêm'),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
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

void showAddComboToMenuDialog() {
  Get.dialog(
    ConstrainedBox(
      constraints: BoxConstraints(maxWidth: 1200),
      child: AlertDialog(
        title: const Text('Thông tin combo'),
        content: SingleChildScrollView(
          child: SizedBox(
            width: 1190,
            child: ListBody(
              mainAxis: Axis.vertical,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Expanded(
                    child: TextField(
                      // onChanged: (value) {
                      //   _foodController.searchString.value = value;
                      //   _foodController.searchName();
                      // },
                      decoration: const InputDecoration(
                        labelText: 'Tìm theo tên sản phẩm / mã sản phẩm',
                      ),
                      style: Get.theme.textTheme.bodyMedium,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Align(
                    child: Expanded(
                      child: SingleChildScrollView(
                        child: DataTable(
                          columns: const <DataColumn>[
                            DataColumn(
                              label: Expanded(
                                child: Text(
                                  'Mã số sản phẩm',
                                ),
                              ),
                            ),
                            DataColumn(
                              label: Expanded(
                                child: Text(
                                  'Hình ảnh',
                                ),
                              ),
                            ),
                            DataColumn(
                              label: Expanded(
                                child: Text(
                                  'Tên sản phẩm',
                                ),
                              ),
                            ),
                            DataColumn(
                              label: Expanded(
                                child: Text(
                                  'Mô tả',
                                ),
                              ),
                            ),
                            DataColumn(
                              label: Expanded(
                                child: Text(
                                  'Loại',
                                ),
                              ),
                            ),
                            DataColumn(
                              label: Expanded(
                                child: Text(
                                  'Giá bán',
                                ),
                              ),
                            ),
                            DataColumn(
                              label: Expanded(
                                child: Text(
                                  ' ',
                                ),
                              ),
                            ),
                          ],
                          rows: <DataRow>[
                            DataRow(
                              cells: <DataCell>[
                                DataCell(Text('#011111')),
                                DataCell(Image.network(
                                  'https://picsum.photos/250?image=9',
                                  fit: BoxFit.fitHeight,
                                )),
                                DataCell(Text('Tên sản phẩm ')),
                                DataCell(Text('Mô tả sản phẩm 1')),
                                DataCell(Text('Loại 1')),
                                DataCell(Text('15.000 vnd')),
                                DataCell(
                                  SizedBox(
                                    width: 100,
                                    height: 30,
                                    child: FloatingActionButton.extended(
                                      onPressed: () {},
                                      label: Text('Thêm'),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            DataRow(
                              cells: <DataCell>[
                                DataCell(Text('#011111')),
                                DataCell(Image.network(
                                  'https://picsum.photos/250?image=9',
                                  fit: BoxFit.fitHeight,
                                )),
                                DataCell(Text('Tên sản phẩm ')),
                                DataCell(Text('Mô tả sản phẩm 1')),
                                DataCell(Text('Loại 1')),
                                DataCell(Text('15.000 vnd')),
                                DataCell(
                                  SizedBox(
                                    width: 100,
                                    height: 30,
                                    child: FloatingActionButton.extended(
                                      onPressed: () {},
                                      label: Text('Thêm'),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
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