import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '/models/session.dart';
import '/routes/app_routes.dart';
import '/views/pages/loading_page.dart';
import '/controllers/session_controller.dart';
import '/views/pages/widget/button_data_table.dart';
import '/views/pages/widget/paginated_data_table_widget.dart';
import 'create_session_page.dart';
import '/enums/status_enum.dart';

class SessionView extends GetView<SessionController> {
  const SessionView({super.key});
  @override
  Widget build(BuildContext context) {
    Get.put(SessionController());
    String? schoolId = Get.parameters['schoolId'];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Danh sách thực đơn'),
        leading: IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(Icons.arrow_back_ios_new)),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Align(
              //   alignment: Alignment.centerLeft,
              //   child: GestureDetector(
              //     onTap: () async {
              //       final DateTimeRange? picked = await showDateRangePicker(
              //         context: context,
              //         initialDateRange: DateTimeRange(
              //           start: controller.selectedDateStart.value,
              //           end: controller.selectedDateEnd.value,
              //         ),
              //         firstDate:
              //             DateTime.now().subtract(const Duration(days: 365)),
              //         lastDate: DateTime.now(),
              //       );

              //       if (picked != null) {
              //         controller.selectedDateStart.value = picked.start;
              //         controller.selectedDateEnd.value = picked.end;
              //         controller.selectedDateStrStart.value =
              //             DateFormat('dd-MM-yyyy').format(picked.start);
              //         controller.selectedDateStrEnd.value =
              //             DateFormat('dd-MM-yyyy').format(picked.end);
              //       }
              //     },
              //     child: Container(
              //       width: 250,
              //       padding: const EdgeInsets.only(
              //           left: 20, right: 20, top: 5, bottom: 5),
              //       alignment: Alignment.center,
              //       decoration: BoxDecoration(
              //           border: Border.all(color: Colors.green),
              //           borderRadius: BorderRadius.circular(12)),
              //       child: Obx(
              //         () => Row(
              //           mainAxisAlignment: MainAxisAlignment.center,
              //           crossAxisAlignment: CrossAxisAlignment.center,
              //           children: [
              //             const Icon(
              //               Icons.calendar_today,
              //             ),
              //             const SizedBox(width: 10),
              //             Text(
              //               '${controller.selectedDateStrStart}  -  ${controller.selectedDateStrEnd}',
              //               style: Get.textTheme.titleSmall,
              //             ),
              //           ],
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
              Align(
                alignment: Alignment.centerRight,
                child: CreateButtonDataTable(
                  onPressed: () {
                    Get.to(CreateSessionPage(
                      schoolId: schoolId!,
                    ));
                  },
                ),
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
                      child: const TabBarView(
                        children: [
                          SessionTabView(status: SessionStatus.orderable),
                          SessionTabView(status: SessionStatus.incomming),
                          SessionTabView(status: SessionStatus.expired),
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
}

class SessionTabView extends GetView<SessionController> {
  final SessionStatus status;
  const SessionTabView({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    Get.put(SessionController());
    controller.status = status;
    return LoadingView(
      future: controller.refreshData,
      child: SingleChildScrollView(
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
              const DataColumn(label: Text('Mã thực đơn')),
              DataColumn(
                  label: const Text('Thời gian đặt hàng'),
                  onSort: (index, ascending) =>
                      controller.sortByCreateDate(index)),
              const DataColumn(label: Text('Thời gian giao hàng')),
              const DataColumn(label: Text('Địa điểm')),
              const DataColumn(label: Text(' ')),
            ],
            // ignore: invalid_use_of_protected_member
            rows: controller.rows.value)),
      ),
    );
  }

  DataRow setRow(int index, Session session) {
    var menu = session.menu!;
    return DataRow(
      cells: [
        DataCell(Text((index + 1).toString())),
        DataCell(Text(session.code.toString())),
        DataCell(Text(menu.code.toString())),
        DataCell(Text(
            'Từ ${DateFormat('HH:mm dd-MM-yy').format(session.orderStartTime!)}'
            '\nđến ${DateFormat('HH:mm dd-MM-yy').format(session.orderEndTime!)}')),
        DataCell(Text(
            'Từ ${DateFormat('HH:mm dd-MM-yy').format(session.deliveryStartTime!)}'
            '\nđến ${DateFormat('HH:mm dd-MM-yy').format(session.deliveryEndTime!)}')),
        DataCell(SingleChildScrollView(
          child: Column(
            children: session.sessionDetails!
                .map((sessionDetail) =>
                    Text(sessionDetail.location!.name.toString()))
                .toList(),
          ),
        )),
        DataCell(Row(
          children: [
            const Spacer(),
            DetailButtonDataTable(
                onPressed: () => Get.toNamed(AppRoutes.menuDetail,
                    parameters: {"menuCode": menu.code!})),
            if (status != SessionStatus.expired)
              DeleteButtonDataTable(onPressed: () {
                Get.defaultDialog(
                  title: 'Xác nhận',
                  content: const Text('Xác nhận xóa phiên bán hàng?'),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () async {
                        await controller.delete(session.id!);
                      },
                      child: const Text('Đồng ý'),
                    ),
                    TextButton(
                      child: const Text('Đóng'),
                      onPressed: () {
                        Get.back();
                      },
                    ),
                  ],
                );
              }),
          ],
        )),
      ],
    );
  }
}
