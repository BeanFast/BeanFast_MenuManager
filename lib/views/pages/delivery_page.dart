import 'package:beanfast_menumanager/models/user.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '/controllers/delivery_controller.dart';
import '/views/pages/widget/pickedDate_widget.dart';
import 'loading_page.dart';
import '/models/area.dart';
import '/models/session_detail.dart';
import 'widget/button_data_table.dart';
import 'widget/data_table_page.dart';
import 'widget/paginated_data_table_widget.dart';
import 'widget/text_data_table_widget.dart';

class DeliveryView extends GetView<DeliveryController> {
  const DeliveryView({super.key});
  @override
  Widget build(BuildContext context) {
    Get.put(DeliveryController());

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding:
              const EdgeInsets.only(top: 40, left: 10, right: 10, bottom: 10),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Text(
                  'Quản lý giao hàng',
                  textAlign: TextAlign.start,
                  style: Get.textTheme.headlineMedium,
                ),
              ),
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
                ],
              ),
              DefaultTabController(
                length: 2,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const TabBar(
                      tabs: [
                        Tab(text: 'Chưa xếp lịch'),
                        Tab(text: 'Đã xếp lịch'),
                      ],
                    ),
                    SizedBox(
                      height: Get.height * 0.8,
                      child:  TabBarView(
                        children: [
                          DeliveryTabView(), // Đang chuẩn bị
                          DeliveryTabView(), // Đang giao
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

// ignore: must_be_immutable
class DeliveryTabView extends GetView<DeliveryController> {
   DeliveryTabView({super.key});

  String? sessionDetailId;

  @override
  Widget build(BuildContext context) {
    return LoadingView(
      future: controller.refreshData,
      child: SingleChildScrollView(
        child: SizedBox(
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
                const DataColumn(label: Text('Trường')),
                const DataColumn(label: Text('Cổng')),
                const DataColumn(label: Text('Địa chỉ')),
                DataColumn(
                    label: const Text('Khung giờ'),
                    onSort: (index, ascending) => {}),
                const DataColumn(label: Text('Số đơn hàng')),
                const DataColumn(label: Text(' ')),
              ],
              // ignore: invalid_use_of_protected_member
              rows: controller.rows.value)),
        ),
      ),
    );
  }

  DataRow setRow(int index, SessionDetail sessionDetail) {
    Area area = sessionDetail.location!.school!.area!;
    return DataRow(
      cells: [
        DataCell(Text((index + 1).toString())),
        DataCell(Text(sessionDetail.code.toString())),
        DataCell(
          TextDataTable(
            data: sessionDetail.location!.school!.name.toString(),
            maxLines: 1,
            width: 100,
          ),
        ),
        DataCell(
          TextDataTable(
            data: sessionDetail.location!.name.toString(),
            maxLines: 1,
            width: 100,
          ),
        ),
        DataCell(
          TextDataTable(
            data:
                '${sessionDetail.location!.school!.address}, ${area.ward}, ${area.district}, ${area.city}',
            maxLines: 1,
            width: 100,
          ),
        ),
        DataCell(Text(DateFormat('dd/MM/yy - ')
                .format(sessionDetail.session!.deliveryStartTime!) +
            DateFormat('dd/MM/yy')
                .format(sessionDetail.session!.deliveryEndTime!))),
        DataCell(Text(sessionDetail.orders!.length.toString())),
        DataCell(Row(
          children: [
            const Spacer(),
            DetailButtonDataTable(onPressed: () {}),
            EditButtonDataTable(onPressed: () {
              showDeliverersDialog(sessionDetail.id!);
            }),
          ],
        )),
      ],
    );
  }

  void showDeliverersDialog(String id) {
    sessionDetailId = id;
    Get.dialog(
      AlertDialog(
        content: SizedBox(
          height: Get.height * 0.8,
          width: Get.width,
          child: LoadingView(
            future: controller.refreshData,
            child: Obx(
              () => DataTableView(
                title: 'Danh sách người giao hàng',
                isShowCreateDialog: false,
                showCreateDialog: () {},
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
                  const DataColumn(label: Text('Email')),
                  DataColumn(
                      label: const Text('Tên'),
                      onSort: (index, ascending) => (index, ascending) {}),
                  const DataColumn(label: Text('Số điện thoại')),
                  const DataColumn(label: Text(' ')),
                ],
                // ignore: invalid_use_of_protected_member
                rows: controller.rows.value,
              ),
            ),
          ),
        ),
      ),
    );
  }

  DataRow setDelivererRow(int index, User user) {
    return DataRow(
      cells: [
        DataCell(Text((index + 1).toString())),
        DataCell(
          Text(
            user.code.toString(),
          ),
        ),
        DataCell(
          SizedBox(
            width: 100,
            child: Image.network(
              user.avatarPath.toString(),
              fit: BoxFit.fitWidth,
            ),
          ),
        ),
        DataCell(
          Text(
            user.email.toString(),
          ),
        ),
        DataCell(Text(user.fullName.toString())),
        DataCell(Text(user.phone.toString())),
        DataCell(Row(
          children: [
            const Spacer(),
            IconButton(
              icon: const Icon(Icons.add_circle_outline),
              onPressed: () =>
                  controller.selectDeliverer(sessionDetailId!, user.id!),
            ),
          ],
        )),
      ],
    );
  }
}
