import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '/utils/logger.dart';
import '/models/order.dart';
import '/controllers/order_controller.dart' as controller;
import '/views/pages/widget/button_data_table.dart';
import '/views/pages/widget/text_data_table_widget.dart';
import '/views/pages/widget/data_table_page.dart';

class OrderView extends StatelessWidget {
  const OrderView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller.OrderController orderController = Get.find();
    logger.i('build OrderView');
    return Obx(
      () => DataTableView(
        title: 'Quản lý bếp',
        isShowCreateDialog: true,
        showCreateDialog: () => Get.toNamed('/order-create'),
        refreshData: orderController.refreshData,
        search: (value) {
          orderController.searchString.value = value;
          orderController.search();
        },
        sortColumnIndex: orderController.columnIndex.value,
        sortAscending: orderController.columnAscending.value,
        columns: <DataColumn>[
          const DataColumn(
            label: Text('Stt'),
          ),
          const DataColumn(
            label: Text('Code'),
          ),
          const DataColumn(label: Text('Bếp')),
          DataColumn(
              label: const Text('Ngày tạo'),
              onSort: (index, ascending) =>
                  orderController.sortByDeliveryDate(index)),
          const DataColumn(
            label: Text('Ngày cập nhật'),
          ),
          const DataColumn(
            label: Text('Số sản phẩm'),
          ),
          const DataColumn(label: Text('Trạng thái')),
          const DataColumn(label: Text(' ')),
        ],
        // ignore: invalid_use_of_protected_member
        rows: orderController.rows.value,
      ),
    );
  }

  DataRow setRow(int index, Order order) {
    return DataRow(
      cells: [
        DataCell(Text((index + 1).toString())),
        DataCell(
          TextDataTable(
            data: order.code.toString(),
            maxLines: 2,
            width: 100,
          ),
        ),
        DataCell(
          TextDataTable(
            data: order.code.toString(),
            maxLines: 2,
            width: 200,
          ),
        ),
        DataCell(Text(DateFormat('dd-MM-yyyy').format(order.paymentDate!))),
        DataCell(Text(DateFormat('dd-MM-yyyy').format(order.deliveryDate!))),
        DataCell(Text(
            order.orderDetailIds == null ? '0' : order.orderDetailIds!.length.toString())),
        DataCell(Text(order.status.toString())),
        DataCell(Row(
          children: [
            const Spacer(),
            DetailButtonDataTable(
                goToPage: () =>
                    Get.toNamed('/order-detail?code=123')),
            EditButtonDataTable(showDialog: () {}),
            DeleteButtonDataTable(agree: () {}),
          ],
        )),
      ],
    );
  }
}
