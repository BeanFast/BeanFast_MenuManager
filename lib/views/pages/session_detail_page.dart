import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';

import '/enums/status_enum.dart';
import '/models/order.dart';
import '/utils/format_data.dart';
import '/controllers/session_detail_controller.dart';
import '/views/dialog/order_dialog.dart';
import '/views/pages/loading_page.dart';
import '/views/pages/widget/paginated_datatable_widget.dart';
import 'order_detail_page.dart';
import 'widget/button_data_table.dart';
import 'widget/image_default.dart';

class SessionDetailPage extends GetView<SessionDetailController> {
  final String sessionId;
  const SessionDetailPage({super.key, required this.sessionId});

  @override
  Widget build(BuildContext context) {
    Get.put(SessionDetailController());
    controller.sessionId = sessionId;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chi tiết phiên'),
      ),
      body: LoadingView(
        future: controller.fetchData,
        child: Obx(
          () => SingleChildScrollView(
            child: Column(
              children: [
                Card(
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text('Code: ', style: Get.textTheme.titleMedium),
                            const SizedBox(width: 10),
                            Text(controller.data.value.code.toString(),
                                style: Get.textTheme.bodyMedium),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            Text('Mã thực đơn: ',
                                style: Get.textTheme.titleMedium),
                            const SizedBox(width: 10),
                            Text(controller.data.value.menu!.code.toString(),
                                style: Get.textTheme.bodyMedium),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            Text('Thời gian đặt hàng: ',
                                style: Get.textTheme.titleLarge),
                            const SizedBox(width: 10),
                            Row(
                              children: [
                                Text(
                                    'Từ ${DateFormat('HH:mm dd/MM/yyyy').format(controller.data.value.orderStartTime!)}',
                                    style: Get.textTheme.bodyMedium),
                                Text(
                                    ' đến ${DateFormat('HH:mm dd/MM/yyyy').format(controller.data.value.orderEndTime!)}',
                                    style: Get.textTheme.bodyMedium),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            Text('Thời gian nhận hàng: ',
                                style: Get.textTheme.titleMedium),
                            const SizedBox(width: 10),
                            Row(
                              children: [
                                Text(
                                    'Từ ${DateFormat('HH:mm dd/MM/yyyy').format(controller.data.value.deliveryStartTime!)}',
                                    style: Get.textTheme.bodyMedium),
                                Text(
                                    ' đến ${DateFormat('HH:mm dd/MM/yyyy').format(controller.data.value.deliveryEndTime!)}',
                                    style: Get.textTheme.bodyMedium),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Text('Cổng giao hàng ',
                            style: Get.textTheme.titleMedium),
                        const SizedBox(height: 10),
                        Column(
                          children: controller.data.value.sessionDetails!
                              .map(
                                (sessionDetail) => GestureDetector(
                                  onTap: () {
                                    controller
                                        .selectSessionDetail(sessionDetail.id!);
                                  },
                                  child: ListTile(
                                    leading: const Icon(
                                      Iconsax.location,
                                      size: 20,
                                    ),
                                    title: Column(
                                      children: [
                                        Text(
                                          'Cổng: ${sessionDetail.location!.name.toString()}',
                                          style: Get.textTheme.bodyMedium,
                                        ),
                                        Text(
                                          'Số đơn: ${sessionDetail.orders!.length}',
                                          style: Get.textTheme.bodyMedium,
                                        ),
                                        Text(
                                          'Số người giao: ${sessionDetail.deliverers!.length}',
                                          style: Get.textTheme.bodyMedium,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: Get.width,
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text('Danh sách người giao hàng',
                                  style: Get.textTheme.titleMedium),
                              const Spacer(),
                              CreateButtonDataTable(onPressed: () {
                                showDeliverersDialog(controller
                                    .selectedSessionDetail.value!.id!);
                              }),
                            ],
                          ),
                          Column(
                            children: controller
                                .selectedSessionDetail.value!.deliverers!
                                .map(
                                  (deliverer) => Card(
                                    child: ListTile(
                                      leading: CustomNetworkImage(
                                        deliverer.avatarPath.toString(),
                                        height: 50,
                                        width: 50,
                                      ),
                                      title: Text(deliverer.fullName.toString(),
                                          style: Get.textTheme.bodyMedium),
                                      subtitle: Text(deliverer.email.toString(),
                                          style: Get.textTheme.bodySmall),
                                      trailing: controller.selectedSessionDetail
                                                  .value!.deliverers!.length >
                                              1
                                          ? DeleteButtonDataTable(
                                              onPressed: () async {
                                                await controller
                                                    .removeDeliverer(
                                                        deliverer.id!);
                                              },
                                            )
                                          : null,
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.8,
                  child: const PaginatedDataTableView<SessionDetailController>(
                    title: 'Danh sách đơn hàng',
                    columns: [
                      DataColumn(label: Text('Code')),
                      DataColumn(label: Text('Học sinh')),
                      DataColumn(label: Text('Ngày thanh toán')),
                      DataColumn(label: Text('Người giao')),
                      DataColumn(label: Text('Số sản phẩm')),
                      DataColumn(label: Text('Tổng giá')),
                      DataColumn(label: Text(' ')),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  static DataRow setRow(Order order) {
    return DataRow(
      cells: [
        DataCell(Text(order.code.toString())),
        DataCell(Text(order.profile!.fullName.toString())),
        DataCell(Text(order.paymentDate == null
            ? 'Chưa có'
            : DateFormat('HH:mm dd/MM/yy').format(order.paymentDate!))),
        DataCell(Text(order.sessionDetail!.code.toString())),
        DataCell(Text(order.orderDetails!.length.toString())),
        DataCell(Text(Formatter.formatMoney(order.totalPrice.toString()))),
        DataCell(Row(
          children: [
            const Spacer(),
            DetailButtonDataTable(onPressed: () {
              Get.to(OrderDetailView(order));
            }),
            if (order.status == OrderStatus.preparing.code ||
                order.status == OrderStatus.delivering.code)
              CancelOrderActivityButtonTable(onPressed: () {
                OrderDialogs.showCancelOrderDialog(order.id!);
              }),
          ],
        )),
      ],
    );
  }

  void showDeliverersDialog(String sessionDetailId) {
    Get.dialog(AlertDialog(
      title: Text('Chọn người giao hàng', style: Get.textTheme.titleMedium),
      content: LoadingView(
        future: () => controller.fetchDeliverersData(sessionDetailId),
        child: SizedBox(
          width: Get.width * 0.8,
          height: Get.height * 0.5,
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: TextField(
                  onChanged: (value) => (value),
                  decoration: const InputDecoration(
                    labelText: 'Tìm kiếm',
                  ),
                  style: Get.theme.textTheme.bodyMedium,
                ),
              ),
              SizedBox(
                height: Get.height * 0.44,
                child: SingleChildScrollView(
                  child: Obx(
                    () => Column(
                      children: controller.delivererList.map(
                        (deliverer) {
                          return Card(
                            child: ListTile(
                              leading: CustomNetworkImage(
                                deliverer.avatarPath.toString(),
                                height: 50,
                                width: 50,
                              ),
                              title: Text(deliverer.fullName.toString(),
                                  style: Get.textTheme.bodyMedium),
                              subtitle: Text(deliverer.email.toString(),
                                  style: Get.textTheme.bodySmall),
                              onTap: () async {
                                Get.back();
                                await controller.addDeliverer(deliverer.id!);
                              },
                            ),
                          );
                        },
                      ).toList(),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
