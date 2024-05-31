import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../exchange_gift_detail_page.dart';
import '/controllers/exchange_gift_controller.dart';
import '/enums/status_enum.dart';
import '/models/exchange_gift.dart';
import '/utils/format_data.dart';
import '/views/pages/loading_page.dart';
import 'button_data_table.dart';
import 'paginated_datatable_widget.dart';

class ExchangeGiftTabView extends GetView<ExchangeGiftController> {
  final ExchangeGiftStatus status;
  const ExchangeGiftTabView({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    Get.put(ExchangeGiftController());
    controller.status = status;
    return LoadingView(
      future: controller.fetchData,
      child: const PaginatedDataTableView<ExchangeGiftController>(
        title: 'Danh sách trường học',
        columns: <DataColumn>[
          DataColumn(label: Text('Code')),
          DataColumn(label: Text('Học sinh')),
          DataColumn(label: Text('Ngày thanh toán')),
          DataColumn(label: Text('Trường')),
          DataColumn(label: Text('Khung giờ')),
          DataColumn(label: Text('Cổng')),
          DataColumn(label: Text('Tổng điểm')),
          DataColumn2(label: Text(''), fixedWidth: 85),
        ],
      ),
    );
  }

  DataRow setRow(ExchangeGift exchangeGift) {
    return DataRow(
      cells: [
        DataCell(Text(exchangeGift.code.toString())),
        DataCell(Text(exchangeGift.profile!.fullName.toString())),
        DataCell(Text(exchangeGift.paymentDate == null
            ? 'Chưa có'
            : DateFormat('dd/MM/yy').format(exchangeGift.paymentDate!))),
        DataCell(Text(exchangeGift.sessionDetail!.location!.school!.name.toString())),
        DataCell(Text(
            '${DateFormat('HH:mm dd/MM/yy').format(exchangeGift.sessionDetail!.session!.deliveryStartTime!)} - ${DateFormat('HH:mm dd/MM/yy').format(exchangeGift.sessionDetail!.session!.deliveryEndTime!)}')),
        DataCell(Text(exchangeGift.sessionDetail!.location!.name.toString())),
        DataCell(Text(Formatter.formatPoint(exchangeGift.points.toString()))),
        DataCell(Row(
          children: [
            const Spacer(),
            DetailButtonDataTable(onPressed: () {
              Get.to(ExchangeGiftDetailView(
                orderGiftId: exchangeGift.id!,
              ));
            }),
            if (status == ExchangeGiftStatus.preparing ||
                status == ExchangeGiftStatus.delivering)
              CancelOrderActivityButtonTable(onPressed: () {
                showCancelDialog(exchangeGift.id!);
              }),
          ],
        )),
      ],
    );
  }

  void showCancelDialog(String exchangeGiftId) {
    controller.reasonCancelExchangeGiftText.clear();
    Get.dialog(
      AlertDialog(
        title: Text('Lý do bạn muốn huỷ đơn hàng?',
            style: Get.textTheme.titleMedium),
        content: Form(
          key: controller.formKey,
          child: SizedBox(
              child: TextFormField(
            controller: controller.reasonCancelExchangeGiftText,
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
                await controller.cancelExchangeGift(exchangeGiftId);
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
