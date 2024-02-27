import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '/models/order.dart';
import '/controllers/order_controller.dart';
import '/views/pages/widget/pickedDate_widget.dart';
import '/views/pages/widget/button_data_table.dart';
import '/views/pages/widget/paginated_data_table_widget.dart';
import '/views/pages/widget/text_data_table_widget.dart';

class OrderView extends GetView<OrderController> {
  const OrderView({super.key});

  @override
  Widget build(BuildContext context) {
    // OrderController controller = Get.find();
    return Scaffold(
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
                    showDialog: () {},
                  ),
                ],
              ),
              DefaultTabController(
                length: 4,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const TabBar(
                      tabs: [
                        Tab(text: 'Đang chuẩn bị'),
                        Tab(text: 'Đang giao'),
                        Tab(text: 'Hoàn thành'),
                        Tab(text: 'Đã hủy'),
                      ],
                    ),
                    SizedBox(
                      height: Get.height * 0.8,
                      child: TabBarView(
                        children: [
                          SingleChildScrollView(
                            child: SizedBox(
                              width: Get.width,
                              child: Obx(() => PaginatedDataTableView(
                                  header: EditOrderActivityButtonTable(
                                    showDialog: () {},
                                  ),
                                  sortColumnIndex: controller.columnIndex.value,
                                  sortAscending:
                                      controller.columnAscending.value,
                                  search: (value) => controller.search(value),
                                  refreshData: controller.refreshData,
                                  columns: [
                                    DataColumn(
                                      label: Checkbox(
                                          value: false, onChanged: (value) {}),
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
                                        onSort: (index, ascending) => controller
                                            .sortByPaymentDate(index)),
                                    const DataColumn(
                                        label: Text('Ngày nhận hàng')),
                                    const DataColumn(label: Text('Địa điểm')),
                                    const DataColumn(
                                        label: Text('Số sản phẩm')),
                                    const DataColumn(label: Text('Tổng giá')),
                                    const DataColumn(label: Text('Trạng thái')),
                                    const DataColumn(label: Text(' ')),
                                  ],
                                  // ignore: invalid_use_of_protected_member
                                  rows: controller.rows.value)),
                            ),
                          ),
                          const Center(child: Text('Tab 2 Content')),
                          const Center(child: Text('Tab 3 Content')),
                          const Center(child: Text('Tab 4 Content')),
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

  DataRow setRow(int index, Order order) {
    return DataRow(
      cells: [
        DataCell(Checkbox(value: false, onChanged: (value) {})),
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
            DetailButtonDataTable(goToPage: () {}),
            EditOrderActivityButtonTable(showDialog: () {}),
            CancelOrderActivityButtonTable(showDialog: () {}),
          ],
        )),
      ],
    );
  }

  DataRow setCancelOrderRow(int index, Order order) {
    return DataRow(
      cells: [
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
        DataCell(Text(order.status.toString())),
        DataCell(Row(
          children: [
            const Spacer(),
            DetailButtonDataTable(
                goToPage: () => Get.toNamed('/order-detail?code=123')),
          ],
        )),
      ],
    );
  }
}
