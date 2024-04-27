import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '/enums/status_enum.dart';
import '/controllers/order_controller.dart';
import '/models/order.dart';
import '/utils/format_data.dart';
import '/views/pages/loading_page.dart';
import 'button_data_table.dart';
import 'paginated_data_table_widget.dart';
import 'text_data_table_widget.dart';

class OrderTabView extends GetView<OrderController> {
  final OrderStatus status;
  const OrderTabView({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    Get.put(OrderController());
    controller.status = status;
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
                const DataColumn(label: Text('Học sinh')),
                DataColumn(
                    label: const Text('Ngày thanh toán'),
                    onSort: (index, ascending) =>
                        controller.sortByPaymentDate(index)),
                const DataColumn(label: Text('Ngày nhận hàng')),
                const DataColumn(label: Text('Địa điểm')),
                const DataColumn(label: Text('Số sản phẩm')),
                const DataColumn(label: Text('Tổng giá')),
                const DataColumn(label: Text(' ')),
              ],
              // ignore: invalid_use_of_protected_member
              rows: controller.rows.value)),
        ),
      ),
    );
  }

  DataRow setRow(int index, Order order) {
    return DataRow(
      cells: [
        DataCell(Text((index + 1).toString())),
        DataCell(Text(order.code.toString())),
        DataCell(
          TextDataTable(
            data: order.profile!.fullName.toString(),
            maxLines: 2,
            width: 200,
          ),
        ),
        DataCell(Text(order.paymentDate == null
            ? 'Chưa có'
            : DateFormat('dd-MM-yyyy').format(order.paymentDate!))),
        DataCell(Text(order.deliveryDate == null
            ? 'Chưa có'
            : DateFormat('dd-MM-yyyy').format(order.deliveryDate!))),
        DataCell(Text(order.sessionDetail!.code.toString())),
        DataCell(Text(order.orderDetails!.length.toString())),
        DataCell(Text(Formatter.formatMoney(order.totalPrice.toString()))),
        DataCell(Row(
          children: [
            const Spacer(),
            DetailButtonDataTable(onPressed: () {}),
            if (status == OrderStatus.preparing ||
                status == OrderStatus.delivering)
              CancelOrderActivityButtonTable(onPressed: () {
                showCancelDialog(order.id!);
              }),
          ],
        )),
      ],
    );
  }

  void showCancelDialog(String orderId) {
    Get.defaultDialog(
      title: 'Hủy đơn hàng',
      content: const Column(
        children: [
          Text('Đơn hàng sẽ được hoàn tiền sau khi hủy.'),
          Text('Xác nhận hủy?'),
        ],
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () async {
            await controller.cancelOrder(orderId, 'Hủy đơn');
            Get.back();
          },
          child: const Text('Xác nhận'),
        ),
        TextButton(
          child: const Text('Đóng'),
          onPressed: () {
            Get.back();
          },
        ),
      ],
    );
  }
}
