import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/views/pages/widget/order_tabview.dart';
import '/services/order_service.dart';
import '/enums/status_enum.dart';
import '/controllers/data_table_controller.dart';
import '/models/order.dart';

class OrderController extends DataTableController<Order> {
  OrderStatus status = OrderStatus.preparing;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController reasonCancelOrderText = TextEditingController();

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
      final data = await OrderService().getByStatus(status);
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

  Future cancelOrder(String orderId) async {
    try {
      String reason = reasonCancelOrderText.text.trim();
      await OrderService().cancelOrder(orderId, reason);
      Get.snackbar('Thành công', 'Hủy đơn thành công');
      await refreshData();
    } on DioException catch (e) {
      Get.snackbar('Lỗi', e.response!.data['message']);
    }
  }

  @override
  Future loadPage(int page) {
    throw UnimplementedError();
  }

  @override
  void setDataTable(List<Order> list) {
    rows.value = list.map((dataMap) {
      return OrderTabView(
        status: status,
      ).setRow(list.indexOf(dataMap), dataMap);
    }).toList();
  }


}
