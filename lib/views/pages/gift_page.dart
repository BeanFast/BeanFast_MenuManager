import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '/models/gift.dart';
import '/controllers/gift_controller.dart';
import 'gift_detail.dart';
import 'loading_page.dart';
import 'widget/button_data_table.dart';
import 'widget/paginated_datatable_widget.dart';
import '/utils/format_data.dart';
import 'widget/search_widget.dart';

class GiftView extends GetView<GiftController> {
  const GiftView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(GiftController());
    return LoadingView(
      future: controller.fetchData,
      child: Padding(
        padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                'Quản lý quà',
                textAlign: TextAlign.start,
                style: Get.textTheme.titleMedium,
              ),
              Row(
                children: [ 
                  SearchBox(search: controller.search),
                  const Spacer(),
                   CreateButtonDataTable(
                      onPressed: () async {
                        await showDialog();
                      },
                    ),
                ],
              ),
              SizedBox(
                height: Get.height * 0.7,
                child: const PaginatedDataTableView<GiftController>(
                  title: 'Danh sách phần quà',
                  columns: <DataColumn>[
                            DataColumn(label: Text('Code')),
                  DataColumn(label: Text('Hình ảnh')),
                  DataColumn(label: Text('Tên sản phẩm')),
                  DataColumn(label: Text('Số lượng')),
                  DataColumn(label: Text('Điểm')),
                  DataColumn(label: Text('')),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  DataRow setRow(Gift gift) {
    return DataRow(
      cells: [
        DataCell(Text(gift.code.toString())),
        DataCell(
          SizedBox(
            width: 100,
            child: Image.network(
              gift.imagePath.toString(),
              fit: BoxFit.fitWidth,
            ),
          ),
        ),
        DataCell(Text(gift.name.toString())),
        DataCell(Text(gift.inStock.toString())),
        DataCell(Text(gift.point.toString())),
        DataCell(Row(
          children: [
            const Spacer(),
            DetailButtonDataTable(onPressed: () {
              Get.to(GiftDetailView(gift));
            }),
          ],
        )),
      ],
    );
  }

  Future<void> showDialog() async {
    await controller.initDialog();
    Get.dialog(
      ConstrainedBox(
        constraints: BoxConstraints(maxWidth: Get.width * 0.8),
        child: AlertDialog(
          title: Text('Thông quà tặng', style: Get.textTheme.titleMedium),
          content: Form(
            key: controller.formCreateKey,
            child: SingleChildScrollView(
              child: SizedBox(
                width: Get.width * 0.8,
                child: ListBody(
                  mainAxis: Axis.vertical,
                  children: [
                    Obx(
                      () => Padding(
                        padding: const EdgeInsets.only(
                            left: 5.0, right: 5.0, bottom: 10.0, top: 10.0),
                        child: controller.imagePath.isEmpty
                            ? Text('Chưa có ảnh',
                                style: Get.textTheme.bodyMedium)
                            : Image.network(
                                controller.imagePath.value,
                                fit: BoxFit.contain,
                                width: 200,
                                height: 200,
                              ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 5.0, right: 5.0, bottom: 10.0, top: 10.0),
                      child: TextButton(
                        onPressed: () {
                          controller.pickImage();
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Iconsax.add,
                              size: 20,
                            ),
                            Text('Chọn Ảnh', style: Get.textTheme.bodyMedium),
                          ],
                        ),
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
                            style: Get.textTheme.bodyMedium!
                                .copyWith(color: Colors.red),
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
            TextButton(
              onPressed: controller.submitForm,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Iconsax.add,
                    size: 20,
                  ),
                  Text('Lưu', style: Get.textTheme.bodyMedium),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
