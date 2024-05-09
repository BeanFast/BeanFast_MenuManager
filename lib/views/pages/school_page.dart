import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '/models/school.dart';
import '/models/location.dart';
import '/controllers/school_controller.dart';
import '/routes/app_routes.dart';
import '/views/pages/loading_page.dart';
import '/views/pages/widget/data_table_page.dart';
import '/views/pages/widget/button_data_table.dart';
import '/views/pages/widget/text_data_table_widget.dart';
import 'widget/description_input_widget.dart';

class SchoolView extends GetView<SchoolController> {
  const SchoolView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SchoolController());
    return LoadingView(
      future: controller.refreshData,
      child: Obx(
        () => DataTableView(
          title: 'Quản lý trường',
          header: CreateButtonDataTable(
            onPressed: showCreateSchoolDialog,
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
              label: Text('Số cổng'),
            ),
            const DataColumn(
              label: Text('Số học sinh'),
            ),
            const DataColumn(label: Text(' ')),
          ],
          // ignore: invalid_use_of_protected_member
          rows: controller.rows.value,
        ),
      ),
    );
  }

  DataRow setRow(int index, School school) {
    return DataRow(
      cells: [
        DataCell(Text((index + 1).toString())),
        DataCell(
          TextDataTable(
            data: school.code.toString(),
            maxLines: 2,
            width: 100,
          ),
        ),
        DataCell(
          SizedBox(
            width: 100,
            child: Image.network(
              school.imagePath.toString(),
              fit: BoxFit.fitWidth,
            ),
          ),
        ),
        DataCell(
          TextDataTable(
            data: school.name.toString(),
            maxLines: 2,
            width: 200,
          ),
        ),
        DataCell(Text(school.address.toString())),
        DataCell(Text(school.locations!.length.toString())),
        DataCell(Text(school.studentCount.toString())),
        DataCell(Row(
          children: [
            const Spacer(),
            ManageMenuButtonTable(
                onPressed: () => Get.toNamed(AppRoutes.manageMenu,
                    parameters: {"schoolId": school.id!})),
            DetailButtonDataTable(onPressed: () {}),
            EditButtonDataTable(onPressed: () {}),
          ],
        )),
      ],
    );
  }

  void showCreateSchoolDialog() {
    Get.dialog(
      ConstrainedBox(
        constraints: BoxConstraints(maxWidth: Get.width * 0.8),
        child: AlertDialog(
          title:  Text('Thông trường học',
                  style: Get.textTheme.titleMedium),
          content: Form(
            key: controller.formCreateKey,
            child: SingleChildScrollView(
              child: SizedBox(
                width: Get.width * 0.8,
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
                          onPressed: () {
                            controller.pickImage();
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
                            labelText: 'Tên trường',
                            border: OutlineInputBorder(),
                          ),
                          maxLength: 200,
                          validator: (value) {
                            int minLenght = 10;
                            if (value == null ||
                                value.trim().isEmpty ||
                                value.length < minLenght) {
                              return 'Vui lòng nhập tên trường có độ dài tối thiểu là $minLenght ký tự';
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
                                        style: Get.textTheme.bodyMedium),
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
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
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
                        child: TextButton(
                          onPressed: showCreateLocationDialog,
                          child:  Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Iconsax.add, size: 20,),
                              Text('Thêm cổng trường học', style: Get.textTheme.bodyMedium),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Obx(
                      () => DataTable(
                        columns: const <DataColumn>[
                          DataColumn(
                            label: Text(
                              'STT',
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'Hình ảnh',
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
                        // ignore: invalid_use_of_protected_member
                        rows: controller.locationRows.value,
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

  DataRow setLocationRow(int index, Location location) {
    return DataRow(
      cells: [
        DataCell(Text((index + 1).toString())),
        DataCell(
          SizedBox(
            width: 100,
            child: Image.memory(
              location.imageFile!.files.single.bytes!,
              fit: BoxFit.fitWidth,
            ),
          ),
        ),
        DataCell(
          Text(
            location.name.toString(),
          ),
        ),
        DataCell(
          TextDataTable(
            data: location.description.toString(),
            maxLines: 2,
            width: 200,
          ),
        ),
        DataCell(
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              Get.defaultDialog(
                title: 'Xác nhận',
                content: const Text('Bạn có chắc chắn muốn xoá cổng này?'),
                actions: [
                  ElevatedButton(
                    onPressed: () {
                      controller.removeLocation(index);
                      Get.back();
                    },
                    child: const Text('Đồng ý'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: const Text('Đóng'),
                  ),
                ],
              );
            },
          ),
        ),
      ],
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
          width: Get.width * 0.8,
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
                                  '${area.ward}, ${area.district}, ${area.city}',
                  style: Get.textTheme.bodyMedium),
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

  void showCreateLocationDialog() {
    Get.dialog(
      ConstrainedBox(
        constraints:  BoxConstraints(maxWidth: Get.width * 0.8),
        child: AlertDialog(
          title:  Text('Thông tin cổng',
                  style: Get.textTheme.titleMedium),
          content: Form(
            key: controller.formCreateLocationKey,
            child: SingleChildScrollView(
              child: SizedBox(
                width: Get.width * 0.8,
                child: ListBody(
                  mainAxis: Axis.vertical,
                  children: <Widget>[
                    Obx(
                      () => Padding(
                        padding: const EdgeInsets.only(
                            left: 5.0, right: 5.0, bottom: 10.0, top: 10.0),
                        child:
                            controller.selectedLocationImageImageFile.value ==
                                    null
                                ?  Text('Chưa có ảnh',
                  style: Get.textTheme.bodyMedium)
                                : Image.memory(
                                    controller.selectedLocationImageImageFile
                                        .value!.files.single.bytes!,
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
                            await controller.pickLocationImage();
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
                      child: TextFormField(
                        controller: controller.locationNameText,
                        decoration: const InputDecoration(
                          labelText: 'Tên cổng',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Vui lòng nhập tên cổng trường';
                          }
                          return null;
                        },
                      ),
                    ),
                    DescriptionInput(
                        quillController: controller.locationDescriptionText),
                  ],
                ),
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                controller.addLocation();
              },
              child:  Text('Lưu', style: Get.textTheme.bodyMedium),
            ),
          ],
        ),
      ),
    );
  }
}
