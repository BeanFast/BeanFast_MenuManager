import 'package:beanfast_menumanager/views/pages/kitchen_detail.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

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
          header: CreateButtonDataTable(
            onPressed: showCreateKitchenDialog,
          ),
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
            DetailButtonDataTable(onPressed: () {
              Get.to(KitchenDetailView(kitchen));
            }),
          ],
        )),
      ],
    );
  }

  void showCreateKitchenDialog() {
    Get.dialog(
      ConstrainedBox(
        constraints:  BoxConstraints(maxWidth: Get.width * 0.8),
        child: AlertDialog(
          title: const Text('Thông tin bếp'),
          content: Form(
            key: controller.formCreateKey,
            child: SingleChildScrollView(
              child: SizedBox(
                 width:   Get.width * 0.8,
                child: ListBody(
                  children: [
                    Obx(
                      () => Padding(
                        padding: const EdgeInsets.only(
                            left: 5.0, right: 5.0, bottom: 10.0, top: 10.0),
                        child: controller.selectedImageFile.value == null
                            ?  Text('Chưa có ảnh',
                  style: Get.textTheme.bodyMedium)
                            : Image.memory(
                                controller.selectedImageFile.value!.files.single
                                    .bytes!,
                                width: 200,
                                height: 200,
                              ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 5.0, right: 5.0, bottom: 10.0, top: 10.0),
                        child: TextButton(
                          onPressed: () async {
                            await controller.pickImage();
                          },
                          child:  Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Iconsax.add, size: 20,),
                              Text('Thay đổi ảnh', style: Get.textTheme.bodyMedium),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 5.0, right: 5.0, bottom: 10.0, top: 10.0),
                      child: SizedBox(
                        child: TextFormField(
                          controller: controller.nameText,
                          decoration: const InputDecoration(
                            labelText: 'Tên bếp',
                            border: OutlineInputBorder(),
                          ),
                          maxLength: 200,
                          validator: (value) {
                            int minLenght = 10;
                            if (value == null ||
                                value.trim().isEmpty ||
                                value.length < minLenght) {
                              return 'Vui lòng nhập tên bếp có độ dài tối thiểu là $minLenght ký tự';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                    Card(
                      child: ListTile(
                        leading: const Icon(Iconsax.location),
                        title:  Text('Khu vực',
                                        style: Get.textTheme.bodyMedium),
                        subtitle: Obx(
                          () => Text(controller.selectedArea.value == null
                              ? 'Chưa chọn khu vực'
                              : '${controller.selectedArea.value!.ward}, ${controller.selectedArea.value!.district}, ${controller.selectedArea.value!.city}',
                                        style: Get.textTheme.bodySmall),
                        ),
                        trailing: IconButton(
                          iconSize: 24,
                          onPressed: () {
                            showAreaDialog();
                          },
                          icon: const Icon(Iconsax.arrow_circle_right),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 5.0, right: 5.0, bottom: 10.0, top: 10.0),
                      child: SizedBox(
                        child: TextFormField(
                          controller: controller.addressText,
                          decoration: const InputDecoration(
                            labelText: 'Địa chỉ',
                            border: OutlineInputBorder(),
                          ),
                          maxLength: 500,
                          validator: (value) {
                            int minLenght = 10;
                            if (value == null ||
                                value.isEmpty ||
                                value.length < minLenght) {
                              return 'Vui lòng nhập địa chỉ có độ dài tối thiểu là $minLenght ký tự';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () async {
                await controller.submitForm();
              },
              child:  Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Iconsax.add, size: 20,),
                  Text('Lưu', style: Get.textTheme.bodyMedium),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showAreaDialog() {
    Get.dialog(AlertDialog(
      title:  Text('Chọn khu vực',
                  style: Get.textTheme.titleMedium),
      content: LoadingView(
        future: () async {
          await controller.getAllArea();
        },
        child: SizedBox(
            width:   Get.width * 0.8,
          height: Get.height * 0.5,
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: TextField(
                  onChanged: (value) => controller.searchArea(value),
                  decoration: const InputDecoration(
                    labelText: 'Tìm kiếm',
                  ),
                  style: Get.theme.textTheme.bodyMedium,
                ),
              ),
              SizedBox(
                height: Get.height * 0.44,
                child: SingleChildScrollView(
                  child: Obx(
                    () => Column(
                      children: controller.listArea.map(
                        (area) {
                          return Card(
                            child: ListTile(
                              title: Text(
                                  '${area.ward}, ${area.district}, ${area.city}'),
                              onTap: () {
                                Get.back();
                                controller.selectArea(area);
                              },
                            ),
                          );
                        },
                      ).toList(),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
