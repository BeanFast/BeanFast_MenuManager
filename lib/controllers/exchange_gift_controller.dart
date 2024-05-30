import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/models/exchange_gift.dart';
import '/services/exchange_gift_service.dart';
import '/views/pages/widget/exchange_gift_tabview.dart';
import '/enums/status_enum.dart';
import 'paginated_data_table_controller.dart';
import '/utils/logger.dart';

class ExchangeGiftController
    extends PaginatedDataTableController<ExchangeGift> {
  Rxn<ExchangeGift> model = Rxn();
  ExchangeGiftStatus status = ExchangeGiftStatus.preparing;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController reasonCancelExchangeGiftText =
      TextEditingController();

  Future getById(String id) async {
    model.value = null;
    try {
      var data = await ExchangeGiftService().getById(id);
      model.value = data;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future cancelExchangeGift(String exchangeGiftId) async {
    try {
      String reason = reasonCancelExchangeGiftText.text.trim();
      logger.e(reason);
      await ExchangeGiftService().cancelExchangeGift(exchangeGiftId, reason);
      Get.snackbar('Thành công', 'Hủy đơn thành công');
      await fetchData();
    } on DioException catch (e) {
      logger.e(e.message);
      Get.snackbar('Lỗi', e.response!.data['message']);
    }
  }

  @override
  void setDataTable(List<ExchangeGift> list) {
    rows.value = list.map((dataMap) {
      return ExchangeGiftTabView(
        status: status,
      ).setRow(dataMap);
    }).toList();
  }

  @override
  Future fetchData() async {
    try {
      var data = await ExchangeGiftService().getByStatus(status);
      dataList = data;
      setDataTable(dataList);
    } catch (e) {
      throw Exception(e);
    }
  }
}
