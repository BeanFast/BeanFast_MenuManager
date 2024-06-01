import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '/controllers/menu_detail_controller.dart';
import '/models/menu_detail.dart';
import '/utils/format_data.dart';
import 'loading_page.dart';
import 'widget/paginated_datatable_widget.dart';

class MenuDetailView extends GetView<MenuDetailController> {
  const MenuDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(MenuDetailController());

    return LoadingView(
      future: controller.fetchData,
      child: Scaffold(
        appBar: AppBar(
          title: const Center(child: Text('Chi tiết thực đơn')),
        ),
        body: Padding(
          padding:
              const EdgeInsets.only(top: 20, left: 10, right: 10, bottom: 10),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Card(
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    child: Obx(
                      () => Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Code: ', style: Get.textTheme.titleMedium),
                              const SizedBox(width: 10),
                              Text(controller.menu.value.code.toString(),
                                  style: Get.textTheme.bodyMedium),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Ngày tạo: ',
                                  style: Get.textTheme.titleMedium),
                              const SizedBox(width: 10),
                              Text(
                                  controller.menu.value.createDate == null
                                      ? ""
                                      : DateFormat('dd/MM/yyyy').format(
                                          controller.menu.value.createDate!),
                                  style: Get.textTheme.bodyMedium),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Ngày cập nhật: ',
                                  style: Get.textTheme.titleMedium),
                              const SizedBox(width: 10),
                              Text(
                                  controller.menu.value.updateDate == null
                                      ? ""
                                      : DateFormat('dd/MM/yyyy').format(
                                          controller.menu.value.updateDate!),
                                  style: Get.textTheme.bodyMedium),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: Get.width,
                  height: 700,
                  child: const PaginatedDataTableView<MenuDetailController>(
                    title: 'Danh sách món ăn',
                    columns: [
                      DataColumn(label: Text('Code')),
                      DataColumn(label: Text('Hình ảnh')),
                      DataColumn(label: Text('Tên sản phẩm')),
                      DataColumn(label: Text('Giá bán')),
                      DataColumn(label: Text('Giá')),
                      DataColumn(label: Text('Loại')),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  DataRow setRow(MenuDetail menuDetail) {
    var food = menuDetail.food!;
    return DataRow(
      cells: [
        DataCell(Text(food.code.toString())),
        DataCell(
          SizedBox(
            width: 100,
            child: Image.network(
              food.imagePath.toString(),
              fit: BoxFit.fitWidth,
            ),
          ),
        ),
        DataCell(Text(food.name.toString())),
        DataCell(Text(Formatter.formatMoney(menuDetail.price.toString()))),
        DataCell(Text(Formatter.formatMoney(food.price.toString()))),
        DataCell(Text(food.category!.name!)),
      ],
    );
  }
}
