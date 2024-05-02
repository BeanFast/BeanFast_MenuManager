import 'package:beanfast_menumanager/utils/logger.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/models/exchange_gift.dart';
import '/services/exchange_gift_service.dart';
import '/views/pages/widget/exchange_gift_tabview.dart';
import '/enums/status_enum.dart';
import '/controllers/data_table_controller.dart';

class ExchangeGiftController extends DataTableController<ExchangeGift> {
  ExchangeGiftStatus status = ExchangeGiftStatus.preparing;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController reasonCancelExchangeGiftText =
      TextEditingController();

  @override
  void search(String value) {
    if (value == '') {
      setDataTable(initModelList);
    } else {
      currentModelList = initModelList
          .where((e) => e.code!.toLowerCase().contains(value.toLowerCase()))
          .toList();
      setDataTable(currentModelList);
    }
  }

  @override
  Future getData(list) async {
    try {
      final data = await ExchangeGiftService().getByStatus(status);
      list.addAll(data);
    } catch (e) {
      throw Exception(e);
    }
  }

  void sortByPaymentDate(int index) {
    columnIndex.value = index;
    columnAscending.value = !columnAscending.value;
    currentModelList.sort((a, b) => a.paymentDate!.compareTo(b.paymentDate!));
    if (!columnAscending.value) {
      currentModelList = currentModelList.reversed.toList();
    }
    setDataTable(currentModelList);
  }

  void sortByDeliveryDate(int index) {
    columnIndex.value = index;
    columnAscending.value = !columnAscending.value;
    currentModelList = initModelList;
    currentModelList.sort((a, b) => a.deliveryDate!.compareTo(b.deliveryDate!));
    if (!columnAscending.value) {
      currentModelList = currentModelList.reversed.toList();
    }
    setDataTable(currentModelList);
  }

  Future cancelExchangeGift(String exchangeGiftId) async {
    try {
      String reason = reasonCancelExchangeGiftText.text.trim();
      logger.e(reason);
      await ExchangeGiftService().cancelExchangeGift(exchangeGiftId, reason);
      Get.snackbar('Thành công', 'Hủy đơn thành công');
      await refreshData();
    } on DioException catch (e) {
      logger.e(e.message);
      Get.snackbar('Lỗi', e.response!.data['message']);
    }
  }

  @override
  Future loadPage(int page) {
    throw UnimplementedError();
  }

  @override
  void setDataTable(List<ExchangeGift> list) {
    rows.value = list.map((dataMap) {
      return ExchangeGiftTabView(
        status: status,
      ).setRow(list.indexOf(dataMap), dataMap);
    }).toList();
  }
}
