import 'package:beanfast_menumanager/enums/status_enum.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '/models/order.dart';
import '/controllers/order_controller.dart';
import 'button_data_table.dart';
import 'paginated_data_table_widget.dart';
import 'text_data_table_widget.dart';

class OrderPreparingTabView extends GetView<OrderPreparingController> {
  const OrderPreparingTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        width: Get.width,
        child: Obx(() => PaginatedDataTableView(
            header: Obx(() {
              return Visibility(
                visible: controller.showButtonOnHeader.value,
                child: EditOrderActivityButtonTable(
                  onPressed: () {},
                ),
              );
            }),
            sortColumnIndex: controller.columnIndex.value,
            sortAscending: controller.columnAscending.value,
            search: (value) => controller.search(value),
            refreshData: controller.refreshData,
            loadPage: (page) => controller.loadPage(page),
            columns: [
              DataColumn(
                label: Checkbox(
                  value: controller.headerCheckboxValue.value,
                  onChanged: (value) {
                    controller.toggleHeaderCheckbox();
                  },
                ),
              ),
              const DataColumn(
                label: Text('Stt'),
              ),
              const DataColumn(
                label: Text('Code'),
              ),
              const DataColumn(label: Text('Khách hàng')),
              DataColumn(
                  label: const Text('Ngày thanh toán'),
                  onSort: (index, ascending) =>
                      controller.sortByPaymentDate(index)),
              const DataColumn(label: Text('Ngày nhận hàng')),
              const DataColumn(label: Text('Địa điểm')),
              const DataColumn(label: Text('Số sản phẩm')),
              const DataColumn(label: Text('Tổng giá')),
              const DataColumn(label: Text('Trạng thái')),
              const DataColumn(label: Text(' ')),
            ],
            // ignore: invalid_use_of_protected_member
            rows: controller.rows.value)),
      ),
    );
  }

  DataRow setRow(int index, Order order) {
    return DataRow(
      cells: [
        DataCell(
          Obx(() => Checkbox(
                value: controller.selectedOrderIds.contains(order.id!),
                onChanged: (value) {
                  controller.toggleCheckbox(order.id!);
                },
              )),
        ),
        DataCell(Text((index + 1).toString())),
        DataCell(Text(order.code.toString())),
        DataCell(
          TextDataTable(
            data: order.sessionDetailId.toString(),
            maxLines: 2,
            width: 200,
          ),
        ),
        DataCell(Text(DateFormat('dd-MM-yyyy').format(order.paymentDate!))),
        DataCell(Text(DateFormat('dd-MM-yyyy').format(order.deliveryDate!))),
        DataCell(Text(order.orderDetails == null
            ? '0'
            : order.orderDetails!.length.toString())),
        DataCell(Text(order.code!.toString())),
        DataCell(Text(order.orderDetails.toString())),
        DataCell(Text(order.status.toString())),
        DataCell(Row(
          children: [
            const Spacer(),
            DetailButtonDataTable(onPressed: () {}),
            EditOrderActivityButtonTable(onPressed: () {}),
            CancelOrderActivityButtonTable(onPressed: () {}),
          ],
        )),
      ],
    );
  }
}
