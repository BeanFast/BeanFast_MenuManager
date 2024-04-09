import 'package:beanfast_menumanager/models/order_activity.dart';
import 'package:beanfast_menumanager/utils/format_data.dart';
import 'package:beanfast_menumanager/views/dialog/order_activity_dialog.dart';
import 'package:beanfast_menumanager/views/pages/loading_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../enums/status_enum.dart';
import '/models/order.dart';
import '/controllers/order_controller.dart';
import 'button_data_table.dart';
import 'paginated_data_table_widget.dart';
import 'text_data_table_widget.dart';

class OrderPreparingTabView extends GetView<OrderPreparingController> {
  const OrderPreparingTabView({super.key});

  @override
  Widget build(BuildContext context) {
    controller.status = OrderStatus.preparing;
    return LoadingView(
      future: controller.refreshData,
      child: SingleChildScrollView(
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
                const DataColumn(label: Text('Học sinh')),
                DataColumn(
                    label: const Text('Ngày thanh toán'),
                    onSort: (index, ascending) =>
                        controller.sortByPaymentDate(index)),
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
            data: order.profile!.fullName.toString(),
            maxLines: 2,
            width: 200,
          ),
        ),
        DataCell(Text(DateFormat('dd-MM-yyyy').format(order.paymentDate!))),
        DataCell(Text(order.sessionDetail!.code.toString())),
        DataCell(Text(order.orderDetails!.length.toString())),
        DataCell(Text(Formatter.formatMoney(order.totalPrice.toString()))),
        DataCell(Row(
          children: [
            const Spacer(),
            DetailButtonDataTable(onPressed: () {}),
            CancelOrderActivityButtonTable(onPressed: () {
              OrderActivityDialog.showCancelDialog(order.id!);
            }),
          ],
        )),
      ],
    );
  }
}
