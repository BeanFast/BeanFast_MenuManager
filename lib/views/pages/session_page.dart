import 'package:beanfast_menumanager/models/session.dart';
import 'package:beanfast_menumanager/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../dialog/delete_dialog.dart';
import '/models/menu.dart';
import '../../controllers/session_controller.dart';
import '/views/pages/widget/pickedDate_widget.dart';
import '/views/pages/widget/button_data_table.dart';
import '/views/pages/widget/paginated_data_table_widget.dart';
import '/views/pages/widget/text_data_table_widget.dart';

class SessionView extends GetView<SessionController> {
  const SessionView({super.key});
  @override
  Widget build(BuildContext context) {
    SessionController controller = Get.find();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Danh sách thực đơn'),
        leading: IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(Icons.arrow_back_ios_new)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:
              const EdgeInsets.only(top: 40, left: 10, right: 10, bottom: 10),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: PickedDateView(
                      label: 'Từ ngày',
                      onTap: () {},
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: PickedDateView(
                      label: 'Đến ngày',
                      onTap: () {},
                    ),
                  ),
                  const Spacer(flex: 3),
                  CreateButtonDataTable(
                    onPressed: () {},
                  ),
                ],
              ),
              DefaultTabController(
                length: 3,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const TabBar(
                      tabs: [
                        Tab(text: 'Đang hoạt động'),
                        Tab(text: 'Sắp hoạt động'),
                        Tab(text: 'Lịch sử'),
                      ],
                    ),
                    SizedBox(
                      height: Get.height * 0.8,
                      child: TabBarView(
                        children: [
                          SingleChildScrollView(
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
                                  const DataColumn(label: Text('Bếp')),
                                  DataColumn(
                                      label: const Text('Thời gian phát hành'),
                                      onSort: (index, ascending) =>
                                          controller.sortByCreateDate(index)),
                                  const DataColumn(
                                      label: Text('Thời gian giao hàng')),
                                  const DataColumn(label: Text('Cổng')),
                                  const DataColumn(label: Text('Số sản phẩm')),
                                  const DataColumn(label: Text('Đã bán')),
                                  const DataColumn(label: Text('Trạng thái')),
                                  const DataColumn(label: Text(' ')),
                                ],
                                // ignore: invalid_use_of_protected_member
                                rows: controller.rows.value)),
                          ),
                          const Center(child: Text('Tab 2 Content')),
                          const Center(child: Text('Tab 3 Content')),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  DataRow setRow(int index, Session session) {
    var menu = session.menu!;
    return DataRow(
      cells: [
        DataCell(Text((index + 1).toString())),
        DataCell(
          TextDataTable(
            data: menu.code.toString(),
            maxLines: 2,
            width: 100,
          ),
        ),
        DataCell(
          TextDataTable(
            data: menu.kitchenId.toString(),
            maxLines: 2,
            width: 200,
          ),
        ),
        DataCell(Text(DateFormat('dd-MM-yyyy').format(menu.createDate!))),
        DataCell(Text(DateFormat('dd-MM-yyyy').format(menu.updateDate!))),
        DataCell(Text(session.sessionDetails!.length.toString())),
        DataCell(Text(menu.menuDetails!.length.toString())),
        DataCell(Text((index + 1).toString())),
        DataCell(Text((index + 1).toString())),
        DataCell(Row(
          children: [
            const Spacer(),
            DetailButtonDataTable(
                onPressed: () => Get.toNamed(AppRoutes.menuDetail,
                    parameters: {"menuId": menu.id!})),
            EditButtonDataTable(onPressed: () {}),
            DeleteButtonDataTable(onPressed: () {
              DeleteDialog(onPressed: () {}).showDialogSession();
            }),
          ],
        )),
      ],
    );
  }

  DataRow setPastMenuRow(int index, Menu menu) {
    return DataRow(
      cells: [
        DataCell(Text((index + 1).toString())),
        DataCell(
          TextDataTable(
            data: menu.code.toString(),
            maxLines: 2,
            width: 100,
          ),
        ),
        DataCell(
          TextDataTable(
            data: menu.kitchenId.toString(),
            maxLines: 2,
            width: 200,
          ),
        ),
        DataCell(Text(DateFormat('dd-MM-yyyy').format(menu.createDate!))),
        DataCell(Text(DateFormat('dd-MM-yyyy').format(menu.updateDate!))),
        DataCell(
            Text(menu.schools == null ? '0' : menu.schools!.length.toString())),
        DataCell(Text(menu.code!.toString())),
        DataCell(Text((index + 1).toString())),
        DataCell(Text((index + 1).toString())),
        DataCell(Row(
          children: [
            const Spacer(),
            DetailButtonDataTable(
                onPressed: () => Get.toNamed('/menu-detail?code=123')),
          ],
        )),
      ],
    );
  }
}
