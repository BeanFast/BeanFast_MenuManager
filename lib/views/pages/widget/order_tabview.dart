import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '/views/dialog/order_dialog.dart';
import '/views/pages/order_detail_page.dart';
import '/views/pages/loading_page.dart';
import '/utils/data_table.dart';
import '/enums/status_enum.dart';
import '/controllers/order_controller.dart';
import '/models/order.dart';
import 'button_data_table.dart';
import '/utils/format_data.dart';

class OrderTabView extends GetView<OrderController> {
  final OrderStatus status;
  const OrderTabView({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    Get.put(OrderController());
    controller.status = status;
    return LoadingView(
      future: controller.fetchData,
      child: Obx(
        () => PaginatedDataTable2(
          availableRowsPerPage: const [2, 5, 10, 30, 100],
          rowsPerPage: controller.rowsPerPage.value,
          columnSpacing: 0,
          onRowsPerPageChanged: (value) {
            controller.changeRowsPerPage(value!);
          },
          columns: const [
            DataColumn(label: Text('Code')),
            DataColumn(label: Text('Học sinh')),
            DataColumn(label: Text('Ngày thanh toán')),
            DataColumn(label: Text('Trường')),
            DataColumn(label: Text('Khung giờ')),
            DataColumn(label: Text('Cổng')),
            DataColumn(label: Text('Số sản phẩm')),
            DataColumn(label: Text('Tổng giá')),
            DataColumn2(label: Text(''), fixedWidth: 85),
          ],
          // ignore: invalid_use_of_protected_member
          source: MyDataTableSource(rows: controller.rows.value),
        ),
      ),
    );
  }

  DataRow setRow(Order order) {
    OrderController controller = Get.find();
    return DataRow(
      cells: [
        DataCell(Text(order.code.toString())),
        DataCell(Text(order.profile!.fullName.toString())),
        DataCell(Text(order.paymentDate == null
            ? 'Chưa có'
            : DateFormat('HH:mm dd/MM/yy').format(order.paymentDate!))),
        DataCell(Text(order.sessionDetail!.location!.school!.name.toString())),
        DataCell(Text(
            '${DateFormat('HH:mm dd/MM/yy').format(order.sessionDetail!.session!.deliveryStartTime!)} - ${DateFormat('HH:mm dd/MM/yy').format(order.sessionDetail!.session!.deliveryEndTime!)}')),
        DataCell(Text(order.sessionDetail!.location!.name.toString())),
        DataCell(Text(order.orderDetails!.length.toString())),
        DataCell(Text(Formatter.formatMoney(order.totalPrice.toString()))),
        DataCell(Row(
          children: [
            const Spacer(),
            DetailButtonDataTable(onPressed: () {
              Get.to(OrderDetailView(order.id!));
            }),
            if (status == OrderStatus.preparing ||
                status == OrderStatus.delivering)
              CancelOrderActivityButtonTable(onPressed: () {
                OrderDialogs.showCancelOrderDialog(order.id!, controller.cancelOrder);
              }),
          ],
        )),
      ],
    );
  }
}
