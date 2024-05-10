import 'package:beanfast_menumanager/views/pages/order_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '/contains/theme_color.dart';
import '/enums/status_enum.dart';
import '/controllers/order_controller.dart';
import '/models/order.dart';
import 'button_data_table.dart';
import 'paginated_data_table_widget.dart';
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

                // In your widget
                DataColumn(
                  label: Row(
                    children: [
                      const Text('Địa điểm'),
                      IconButton(
                        icon: const Icon(Icons.arrow_drop_down),
                        onPressed: () {
                          Get.dialog(
                            AlertDialog(
                              title: Text('Địa điểm',
                                  style: Get.textTheme.titleMedium),
                              content: SizedBox(
                                width: Get.width * 0.3,
                                height: Get.height * 0.3,
                                child: Column(
                                  children: [
                                    TextField(
                                      onChanged: (value) => {},
                                      decoration: const InputDecoration(
                                        labelText: 'Tìm kiếm',
                                      ),
                                      style: Get.theme.textTheme.bodyMedium,
                                    ),
                                    const SizedBox(height: 10),
                                    SizedBox(
                                      height: Get.height * 0.22,
                                      child: SingleChildScrollView(
                                        child: Column(
                                          children: List.generate(
                                            10,
                                            (index) => GestureDetector(
                                              onTap: () {
                                                Get.snackbar('ListTile Tapped',
                                                    'Index: $index');
                                              },
                                              child: const Card(
                                                child: ListTile(
                                                  title: Text(
                                                      'Trường THPT Nguyễn Trãi'),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                DataColumn(
                    label: Row(
                  children: [
                    const Text('Số sản phẩm'),
                    IconButton(
                      icon: const Icon(Icons.arrow_drop_down),
                      onPressed: () {
                        Get.dialog(
                          AlertDialog(
                            title: Text('Số sản phẩm',
                                style: Get.textTheme.titleMedium),
                            content: SizedBox(
                              width: Get.width * 0.5,
                              height: Get.height * 0.8,
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 40,
                                    child: TextField(
                                      onChanged: (value) => {},
                                      decoration: const InputDecoration(
                                        labelText: 'Tìm kiếm',
                                      ),
                                      style: Get.theme.textTheme.bodyMedium,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  DefaultTabController(
                                    length: 2,
                                    child: Expanded(
                                      child: Column(
                                        children: <Widget>[
                                          const TabBar(
                                            tabs: [
                                              Tab(text: 'Tab 1'),
                                              Tab(text: 'Tab 2'),
                                            ],
                                          ),
                                          Expanded(
                                            child: TabBarView(
                                              children: [
                                                SizedBox(
                                                  child: SingleChildScrollView(
                                                    child: Column(
                                                      children: List.generate(
                                                        20,
                                                        (index) =>
                                                            GestureDetector(
                                                          onTap: () {
                                                            Get.snackbar(
                                                                'ListTile Tapped',
                                                                'Index: $index');
                                                          },
                                                          child:  Card(
                                                            child: ListTile(
                                                              title: Text(
                                                                  'Code $index'),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                // Add the content for Tab 2 here
                                                SizedBox(
                                                  child: SingleChildScrollView(
                                                    child: Column(
                                                      children: List.generate(
                                                        10,
                                                        (index) =>
                                                            GestureDetector(
                                                          onTap: () {
                                                            Get.snackbar(
                                                                'ListTile Tapped',
                                                                'Index: $index');
                                                          },
                                                          child:  Card(
                                                            child: ListTile(
                                                              title: Text(
                                                                  'Code $index'),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                )),
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
            : DateFormat('dd/MM/yyyy').format(order.paymentDate!))),
        DataCell(Text(order.deliveryDate == null
            ? 'Chưa có'
            : DateFormat('dd/MM/yyyy').format(order.deliveryDate!))),
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
