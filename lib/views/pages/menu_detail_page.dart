import 'package:beanfast_menumanager/utils/format_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '/contrains/contrain.dart';
import '/enums/menu_index_enum.dart';
import '/models/menu_detail.dart';
import '/views/pages/home_page.dart';
import '/views/pages/loading_page.dart';
import '/controllers/menu_detail_controller.dart';
import '/views/pages/widget/text_data_table_widget.dart';
import '/views/pages/widget/paginated_data_table_widget.dart';
import 'widget/row_info_item_widget.dart';

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
          leading: IconButton(
            onPressed: () {
              changePage(MenuIndexState.menu.index);
              Get.off(HomeView());
            },
            icon: const Icon(Icons.arrow_back_ios_new),
          ),
        ),
        body: Padding(
          padding:
              const EdgeInsets.only(top: 40, left: 10, right: 10, bottom: 10),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      Card(
                        child: Container(
                          padding: const EdgeInsets.only(
                            left: 15,
                            right: 15,
                            top: 30,
                            bottom: 30,
                          ),
                          child: Obx(
                            () => Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                RowInfoItemWidget(
                                    title: 'Code: ',
                                    data:
                                        controller.menu.value.code.toString()),
                                RowInfoItemWidget(
                                    title: 'creatorId: ',
                                    data: controller.menu.value.creatorId
                                        .toString()),
                                RowInfoItemWidget(
                                    title: 'updaterId: ',
                                    data: controller.menu.value.updaterId
                                        .toString()),
                                RowInfoItemWidget(
                                    title: 'createDate: ',
                                    data: DateFormat('dd/MM/yyyy').format(
                                        controller.menu.value.createDate!)),
                                RowInfoItemWidget(
                                    title: 'updateDate: ',
                                    data: DateFormat('dd/MM/yyyy').format(
                                        controller.menu.value.updateDate!)),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
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
