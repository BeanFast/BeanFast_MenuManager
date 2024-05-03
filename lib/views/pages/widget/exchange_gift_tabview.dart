import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '/controllers/exchange_gift_controller.dart';
import '/models/exchange_gift.dart';
import '/contains/theme_color.dart';
import '/enums/status_enum.dart';
import 'button_data_table.dart';
import 'paginated_data_table_widget.dart';
import 'text_data_table_widget.dart';
import '/views/pages/loading_page.dart';
import '/utils/format_data.dart';

class ExchangeGiftTabView extends GetView<ExchangeGiftController> {
  final ExchangeGiftStatus status;
  const ExchangeGiftTabView({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    Get.put(ExchangeGiftController());
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
                const DataColumn(label: Text('Tổng điểm')),
                const DataColumn(label: Text(' ')),
              ],
              // ignore: invalid_use_of_protected_member
              rows: controller.rows.value)),
        ),
      ),
    );
  }

  DataRow setRow(int index, ExchangeGift exchangeGift) {
    return DataRow(
      cells: [
        DataCell(Text((index + 1).toString())),
        DataCell(Text(exchangeGift.code.toString())),
        DataCell(
          TextDataTable(
            data: exchangeGift.profile!.fullName.toString(),
            maxLines: 2,
            width: 200,
          ),
        ),
        DataCell(Text(exchangeGift.paymentDate == null
            ? 'Chưa có'
            : DateFormat('dd-MM-yy').format(exchangeGift.paymentDate!))),
        DataCell(Text(exchangeGift.deliveryDate == null
            ? 'Chưa có'
            : DateFormat('dd-MM-yy').format(exchangeGift.deliveryDate!))),
        DataCell(Text(exchangeGift.sessionDetail!.code.toString())),
        DataCell(Text(Formatter.formatPoint(exchangeGift.points.toString()))),
        DataCell(Row(
          children: [
            const Spacer(),
            DetailButtonDataTable(onPressed: () {}),
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
        surfaceTintColor: Colors.white,
        backgroundColor: ThemeColor.bgColor,
        title: const Text('Lý do bạn muốn huỷ đơn hàng?'),
        content: Form(
          key: controller.formKey,
          child: SizedBox(
              // height: Get.height / 2,
              width: Get.width,
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
            child: const Text('Đóng'),
          ),
        ],
      ),
    );
  }
}
