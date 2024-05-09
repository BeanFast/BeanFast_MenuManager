import 'package:beanfast_menumanager/views/pages/widget/image_default.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '/controllers/delivery_controller.dart';
import 'loading_page.dart';
import '/models/area.dart';
import '/models/session_detail.dart';
import 'widget/button_data_table.dart';
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
                  style: Get.textTheme.titleMedium,
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: GestureDetector(
                  onTap: () async {
                    final DateTimeRange? picked = await showDateRangePicker(
                      context: context,
                      initialDateRange: DateTimeRange(
                        start: controller.selectedDateStart.value,
                        end: controller.selectedDateEnd.value,
                      ),
                      firstDate:
                          DateTime.now().subtract(const Duration(days: 365)),
                      lastDate: DateTime.now(),
                    );

                    if (picked != null) {
                      controller.selectedDateStart.value = picked.start;
                      controller.selectedDateEnd.value = picked.end;
                      controller.selectedDateStrStart.value =
                          DateFormat('dd/MM/yyyy').format(picked.start);
                      controller.selectedDateStrEnd.value =
                          DateFormat('dd/MM/yyyy').format(picked.end);
                    }
                  },
                  child: Container(
                    width: 250,
                    padding: const EdgeInsets.only(
                        left: 20, right: 20, top: 5, bottom: 5),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(12)),
                    child: Obx(
                      () => Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.calendar_today,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            '${controller.selectedDateStrStart}  -  ${controller.selectedDateStrEnd}',
                            style: Get.textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
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
                      child: TabBarView(
                        children: [
                          DeliveryTabView(
                            isHasDeliverer: false,
                          ), // Chưa xếp lịch
                          DeliveryTabView(
                            isHasDeliverer: true,
                          ), // Đã xếp lịch
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
  final bool? isHasDeliverer;
  DeliveryTabView({
    super.key,
    this.isHasDeliverer,
  });
  String? sessionDetailId;

  @override
  Widget build(BuildContext context) {
    controller.isHasDeliverer = isHasDeliverer!;
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
            EditButtonDataTable(onPressed: () {
              showSelectedDelivererDialog(sessionDetail.id!);
            }),
          ],
        )),
      ],
    );
  }

  void showSelectedDelivererDialog(String sessionDetailId) {
    controller.getSelectedListDeliverer(sessionDetailId);
    Get.dialog(AlertDialog(
      title:  Text('Người giao hàng', style:  Get.textTheme.titleMedium),
      content: SizedBox(
        width: Get.width * 0.8,
        height: Get.height * 0.5,
        child: Column(
          children: [
            Row(
              children: [
                TextButton(
                  onPressed: () {
                    showDelivererDialog(sessionDetailId);
                  },
                  child:  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // ignore: prefer_const_constructors
                      Icon(Icons.add_outlined, size: 20,),
                      Text('Cập nhật người giao hàng', style: Get.textTheme.bodyMedium),
                    ],
                  ),
                ),
                const SizedBox(width: 20),
                TextButton(
                  onPressed: () async {
                    await controller.selectDeliverer(sessionDetailId);
                    Get.back();
                  },
                  child:  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.add_outlined, size: 20,),
                      Text('Tạo', style: Get.textTheme.bodyMedium),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: Get.height * 0.44,
              child: SingleChildScrollView(
                child: Obx(
                  () => Column(
                    children: controller.selectedListDeliverer.map(
                      (deliverer) {
                        return Card(
                          child: ListTile(
                            leading: CustomNetworkImage(
                              deliverer.avatarPath.toString(),
                              height: 50,
                              width: 50,
                            ),
                            title: Text(deliverer.fullName.toString() , style:  Get.textTheme.bodyMedium),
                            subtitle: Text(deliverer.email.toString(), style:  Get.textTheme.bodySmall),
                            trailing: DeleteButtonDataTable(onPressed: () {
                              controller.removeDeliverer(deliverer);
                            }),
                          ),
                        );
                      },
                      label: const Text('Cập nhật người giao hàng'),
                    ),
                  ),
                  const SizedBox(width: 20),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: FloatingActionButton.extended(
                      icon: const Icon(Icons.add_outlined),
                      onPressed: () async {
                        await controller.selectDeliverer(sessionDetailId);
                        Get.back();
                      },
                      label: const Text('Tạo'),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: Get.height * 0.44,
                child: SingleChildScrollView(
                  child: Obx(
                    () => Column(
                      children: controller.selectedListDeliverer.map(
                        (deliverer) {
                          return Card(
                            child: ListTile(
                              leading: CustomNetworkImage(
                                deliverer.avatarPath.toString(),
                                height: 50,
                                width: 50,
                              ),
                              title: Text(deliverer.fullName.toString() , style:  Get.textTheme.bodyMedium),
                            subtitle: Text(deliverer.email.toString(), style:  Get.textTheme.bodySmall),
                              trailing: DeleteButtonDataTable(onPressed: () {
                                controller.removeDeliverer(deliverer);
                              }),
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

  void showDelivererDialog(String sessionDetailId) {
    Get.dialog(AlertDialog(
      title:  Text('Chọn người giao hàng', style:  Get.textTheme.titleMedium),
      content: LoadingView(
        future: () async {
          await controller.getListDeliverer(sessionDetailId);
        },
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
                      children: controller.listDeliverer.map(
                        (deliverer) {
                          return Card(
                            child: ListTile(
                              leading: CustomNetworkImage(
                                deliverer.avatarPath.toString(),
                                height: 50,
                                width: 50,
                              ),
                              title: Text(deliverer.fullName.toString(), style:  Get.textTheme.bodyMedium),
                              subtitle: Text(deliverer.email.toString(),  style:  Get.textTheme.bodySmall),
                              onTap: () {
                                Get.back();
                                controller.addDeliverer(deliverer);
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
