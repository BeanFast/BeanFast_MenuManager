import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '/models/school.dart';
import '/controllers/school_controller.dart';
import '/routes/app_routes.dart';
import '/views/pages/loading_page.dart';
import '/views/pages/widget/data_table_page.dart';
import '/views/pages/widget/button_data_table.dart';
import '/views/pages/widget/text_data_table_widget.dart';

class SchoolView extends GetView<SchoolController> {
  const SchoolView({super.key});

  @override
  Widget build(BuildContext context) {
    final SchoolController controller = Get.find();
    return LoadingView(
      future: controller.refreshData,
      child: Obx(
        () => DataTableView(
          title: 'Quản lý trường',
          isShowCreateDialog: true,
          showCreateDialog: showCreateSchoolDialog,
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
        constraints: BoxConstraints(maxWidth: Get.width),
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
                    child: controller.imagePath.isEmpty
                        ? const Text('No image selected')
                        : Image.network(
                            controller.imagePath.value,
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
                  ListTile(
                    leading: const Icon(Iconsax.location),
                    title: const Text('Khu vực'),
                    subtitle: Obx(
                      () => Text(controller.selectedArea.value == null
                          ? 'Chưa chọn khu vực'
                          : '${controller.selectedArea.value!.ward}, ${controller.selectedArea.value!.district}, ${controller.selectedArea.value!.city}'),
                    ),
                    trailing: IconButton(
                      iconSize: 24,
                      onPressed: () {
                        showAreaDialog();
                      },
                      icon: const Icon(Iconsax.arrow_circle_right),
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
                        ],
                      ),
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

  void showAreaDialog() {
    Get.dialog(AlertDialog(
      title: const Text('Chọn khu vực'),
      content: LoadingView(
        future: () async {
          await controller.getAllArea();
        },
        child: SizedBox(
          width: Get.width,
          height: Get.height * 0.5,
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: TextField(
                  onChanged: (value) => (value),
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

  void showCreateGateDialog() {
    Get.dialog(
      ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 700),
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
