import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '/views/pages/order_detail_page.dart';
import '/utils/data_table.dart';
import '/contains/theme_color.dart';
import '/enums/status_enum.dart';
import '/controllers/order_controller.dart';
import '/models/order.dart';
import 'button_data_table.dart';
import 'text_data_table_widget.dart';
import '/views/pages/loading_page.dart';
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
            DataColumn(
              label: Text('Code'),
            ),
            DataColumn(label: Text('Học sinh')),
            DataColumn(
              label: Text('Ngày thanh toán'),
            ),
            DataColumn(label: Text('Trường')),
            DataColumn(label: Text('Khung giờ')),
            DataColumn(label: Text('Cổng')),
            DataColumn(
              label: Text('Địa điểm'),
            ),
            DataColumn(label: Text('Số sản phẩm')),
            DataColumn(label: Text('Tổng giá')),
            DataColumn(label: Text(' ')),
          ],
          // ignore: invalid_use_of_protected_member
            source: MyDataTableSource(rows: controller.rows.value),
        ),
      ),
    );
  }

  DataRow setRow(Order order) {
    return DataRow(
      cells: [
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
            : DateFormat('dd/MM/yyyy').format(order.paymentDate!))),
        DataCell(Text(order.deliveryDate == null
            ? 'Chưa có'
            : DateFormat('dd/MM/yyyy').format(order.deliveryDate!))),
        DataCell(Text(order.sessionDetail!.code.toString())),
        DataCell(Text(order.sessionDetail!.code.toString())),
        DataCell(Text(order.sessionDetail!.code.toString())),
        DataCell(Text(order.orderDetails!.length.toString())),
        DataCell(Text(Formatter.formatMoney(order.totalPrice.toString()))),
        DataCell(Row(
          children: [
            const Spacer(),
            DetailButtonDataTable(onPressed: () {
              Get.to(OrderDetailView(order));
            }),
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
    controller.reasonCancelOrderText.clear();
    Get.dialog(
      AlertDialog(
        surfaceTintColor: Colors.white,
        backgroundColor: ThemeColor.bgColor,
        title: const Text('Lý do bạn muốn huỷ đơn hàng?'),
        content: Form(
          key: controller.formKey,
          child: SizedBox(
              // height: Get.height / 2,
              width: Get.width * 0.8,
              child: TextFormField(
                controller: controller.reasonCancelOrderText,
                decoration: const InputDecoration(),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Vui lòng nhập lý do';
                  }
                  return null;
                },
              )),
        ),
        actions: [
          TextButton(
            onPressed: () async {
              if (controller.formKey.currentState!.validate()) {
                Get.back();
                await controller.cancelOrder(orderId);
              }
            },
            child: Text('Huỷ đơn hàng',
                style: Get.textTheme.bodyMedium!.copyWith(color: Colors.red)),
          ),
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: Text('Đóng', style: Get.textTheme.bodyMedium),
          ),
        ],
      ),
    );
  }
}
