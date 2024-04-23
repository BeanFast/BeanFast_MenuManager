import 'package:beanfast_menumanager/models/gift.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '/controllers/gift_controller.dart';
import '/views/pages/loading_page.dart';
import '/utils/format_data.dart';
import '/views/pages/widget/button_data_table.dart';
import '/views/pages/widget/text_data_table_widget.dart';
import '/views/pages/widget/data_table_page.dart';

class GiftView extends GetView<GiftController> {
  const GiftView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(GiftController());
    return LoadingView(
      future: controller.refreshData,
      child: Obx(
        () => DataTableView(
          title: 'Quản lý quà',
          isShowCreateDialog: true,
          showCreateDialog: () async {
            await showDialog();
          },
          refreshData: controller.refreshData,
          loadPage: (page) => controller.loadPage(page),
          search: (value) => controller.search(value),
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
                label: const Text('Tên sản phẩm'),
                onSort: (index, ascending) => controller.sortByName(index)),
            const DataColumn(label: Text(' ')),
          ],
          // ignore: invalid_use_of_protected_member
          rows: controller.rows.value,
        ),
      ),
    );
  }

  DataRow setRow(int index, Gift category) {
    return DataRow(
      cells: [
        DataCell(Text((index + 1).toString())),
        DataCell(
          TextDataTable(
            data: category.code.toString(),
            maxLines: 2,
            width: 100,
          ),
        ),
        DataCell(
          SizedBox(
            width: 100,
            child: Image.network(
              category.imagePath.toString(),
              fit: BoxFit.fitWidth,
            ),
          ),
        ),
        DataCell(
          TextDataTable(
            data: category.name.toString(),
            maxLines: 2,
            width: 200,
          ),
        ),
        DataCell(Row(
          children: [
            const Spacer(),
            EditButtonDataTable(onPressed: () {}),
          ],
        )),
      ],
    );
  }

  Future<void> showDialog() async {
    await controller.initDialog();
    Get.dialog(
      ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1000),
        child: AlertDialog(
          title: const Text('Thông tin món ăn'),
          content: Form(
            key: controller.formCreateKey,
            child: SingleChildScrollView(
              child: SizedBox(
                width: 990,
                child: ListBody(
                  mainAxis: Axis.vertical,
                  children: [
                    Obx(() => Padding(
                          padding: const EdgeInsets.only(
                              left: 5.0, right: 5.0, bottom: 10.0, top: 10.0),
                          child: controller.imagePath.isEmpty
                              ? const Text('No image selected')
                              : Image.network(
                                  controller.imagePath.value,
                                  fit: BoxFit.cover,
                                ),
                        )),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 5.0, right: 5.0, bottom: 10.0, top: 10.0),
                      child: FloatingActionButton.extended(
                        icon: const Icon(Icons.add),
                        label: const Text('Chọn Ảnh'),
                        onPressed: () {
                          controller.pickImage();
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 5.0, right: 5.0, bottom: 10.0, top: 10.0),
                      child: TextFormField(
                        controller: controller.foodName,
                        maxLength: 200,
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
                        controller: controller.foodPrice,
                        maxLength: 15,
                        decoration: const InputDecoration(
                          labelText: 'Giá',
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        onChanged: (value) {
                          if (value.isNotEmpty) {
                            final formattedValue =
                                Formatter.formatPriceToString(value);
                            controller.foodPrice.value =
                                controller.foodPrice.value.copyWith(
                              text: formattedValue,
                              selection: TextSelection.collapsed(
                                  offset: formattedValue.length),
                            );
                          }
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Vui lòng nhập giá';
                          }
                          if (Formatter.formatPriceToDouble(value) == null) {
                            return 'Giá không hợp lệ';
                          }
                          return null;
                        },
                      ),
                    ),
                    Obx(() {
                      return Column(
                        children: controller.messageErrors.map((message) {
                          return Text(
                            message,
                            style: const TextStyle(color: Colors.red),
                          );
                        }).toList(),
                      );
                    }),
                  ],
                ),
              ),
            ),
          ),
          actions: <Widget>[
            FloatingActionButton.extended(
              icon: const Icon(Icons.add),
              label: const Text('Lưu'),
              onPressed: controller.submitForm,
            ),
          ],
        ),
      ),
    );
  }
}
