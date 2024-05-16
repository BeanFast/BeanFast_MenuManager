import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '/controllers/session_controller.dart';
import '/enums/status_enum.dart';
import '/models/session.dart';
import '/views/pages/widget/paginated_datatable_widget.dart';
import 'session_detail_page.dart';
import '/views/pages/loading_page.dart';
import '/views/pages/widget/button_data_table.dart';
import 'create_session_page.dart';

class SessionView extends GetView<SessionController> {
  const SessionView({super.key});
  @override
  Widget build(BuildContext context) {
    Get.put(SessionController());
    String? schoolId = Get.parameters['schoolId'];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Danh sách thực đơn'),
        // leading: IconButton(
        //     onPressed: () => Get.back(),
        //     icon: const Icon(Icons.arrow_back_ios_new)),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
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
      future: controller.fetchData,
      child: const PaginatedDataTableView<SessionController>(
        columns: [
          DataColumn(label: Text('Code')),
          DataColumn(label: Text('Mã thực đơn')),
          DataColumn(label: Text('Thời gian đặt hàng')),
          DataColumn(label: Text('Thời gian giao hàng')),
          DataColumn(label: Text('Địa điểm')),
          DataColumn(label: Text('Số đơn hàng')),
          DataColumn(label: Text('Số người giao hàng')),
          DataColumn(label: Text(' ')),
        ],
      ),
    );
  }

  DataRow setRow(Session session) {
    var menu = session.menu!;
    return DataRow(
      cells: [
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: session.sessionDetails!
                .map((sessionDetail) =>
                    Text(sessionDetail.location!.name.toString()))
                .toList(),
          ),
        )),
        DataCell(Text(menu.code.toString())),
        DataCell(Text(menu.code.toString())),
        DataCell(Row(
          children: [
            const Spacer(),
            DetailButtonDataTable(onPressed: () {
              Get.to(SessionDetailPage(sessionId: session.id!));
            }),
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
