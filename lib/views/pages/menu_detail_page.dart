import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '/controllers/menu_detail_controller.dart';
import '/models/menu_detail.dart';
import '/utils/format_data.dart';
import '/views/pages/loading_page.dart';
import '/views/pages/widget/paginated_data_table_widget.dart';
import '/views/pages/widget/text_data_table_widget.dart';

class MenuDetailView extends GetView<MenuDetailController> {
  // List<MenuDetail>? menuDetails = [];
  const MenuDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(MenuDetailController());

    return LoadingView(
      future: () async {
        await controller.refreshData();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Center(child: Text('Chi tiết thực đơn')),
          // leading: IconButton(
          //   onPressed: () {
          //     changePage(MenuIndexState.menu.index);
          //     Get.off(HomeView());
          //   },
          //   icon: const Icon(Icons.arrow_back_ios_new),
          // ),
        ),
        body: Padding(
          padding:
              const EdgeInsets.only(top: 20, left: 10, right: 10, bottom: 10),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Column(
                  children: [
                    Card(
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Obx(
                                () => Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('Code: ',
                                            style: Get.textTheme.titleMedium),
                                        const SizedBox(width: 10),
                                        Expanded(
                                          child: Text(
                                              controller.menu.value.code
                                                  .toString(),
                                              style: Get.textTheme.bodyMedium),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 20),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('creatorId: ',
                                            style: Get.textTheme.titleMedium),
                                        const SizedBox(width: 10),
                                        Expanded(
                                          child: Text(
                                              controller.menu.value.creatorId
                                                  .toString(),
                                              style: Get.textTheme.bodyMedium),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 20),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('updaterId: ',
                                            style: Get.textTheme.titleMedium),
                                        const SizedBox(width: 10),
                                        Expanded(
                                          child: Text(
                                              controller.menu.value.updaterId
                                                  .toString(),
                                              style: Get.textTheme.bodyMedium),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 20),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('createDate: ',
                                            style: Get.textTheme.titleMedium),
                                        const SizedBox(width: 10),
                                        Expanded(
                                          child: Text(
                                              controller.menu.value
                                                          .createDate ==
                                                      null
                                                  ? ""
                                                  : DateFormat('dd/MM/yyyy')
                                                      .format(controller.menu
                                                          .value.createDate!),
                                              style: Get.textTheme.bodyMedium),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 20),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('updateDate: ',
                                            style: Get.textTheme.titleMedium),
                                        const SizedBox(width: 10),
                                        Expanded(
                                          child: Text(
                                              controller.menu.value
                                                          .updateDate ==
                                                      null
                                                  ? ""
                                                  : DateFormat('dd/MM/yyyy')
                                                      .format(controller.menu
                                                          .value.updateDate!),
                                              style: Get.textTheme.bodyMedium),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: Get.width,
                  child: Obx(() => PaginatedDataTableView(
                      sortColumnIndex: controller.columnIndex.value,
                      sortAscending: controller.columnAscending.value,
                      search: (value) => controller.search(value),
                      refreshData: controller.refreshData,
                      loadPage: (page) => controller.loadPage(page),
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
                                controller.sortFoodByName(index)),
                        DataColumn(
                            label: const Text('Giá bán'),
                            onSort: (index, ascending) =>
                                controller.sortFoodByPrice(index)),
                        DataColumn(
                            label: const Text('Giá'),
                            onSort: (index, ascending) =>
                                controller.sortFoodByPrice(index)),
                        const DataColumn(
                          label: Text('Loại'),
                        ),
                      ],
                      // ignore: invalid_use_of_protected_member
                      rows: controller.rows.value)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  DataRow setMenuDetailRow(int index, MenuDetail menuDetail) {
    var food = menuDetail.food!;
    return DataRow(
      cells: [
        DataCell(Text((index + 1).toString())),
        DataCell(
          TextDataTable(
            data: food.code.toString(),
            maxLines: 2,
            width: 100,
          ),
        ),
        DataCell(
          SizedBox(
            width: 100,
            child: Image.network(
              food.imagePath.toString(),
              fit: BoxFit.fitWidth,
            ),
          ),
        ),
        DataCell(
          TextDataTable(
            data: food.name.toString(),
            maxLines: 2,
            width: 200,
          ),
        ),
        DataCell(Text(Formatter.formatMoney(menuDetail.price.toString()))),
        DataCell(Text(Formatter.formatMoney(food.price.toString()))),
        DataCell(Text(food.category!.name!)),
      ],
    );
  }
}
