import 'package:beanfast_menumanager/services/session_detail_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/models/school.dart';
import '/models/session.dart';
import '/models/session_detail.dart';
import '/services/school_service.dart';
import '/services/session_service.dart';
import '/services/order_service.dart';
import '/enums/status_enum.dart';
import '/models/order.dart';
import '/views/pages/widget/order_tabview.dart';
import 'paginated_data_table_controller.dart';

class OrderController extends PaginatedDataTableController<Order> {
  OrderStatus status = OrderStatus.preparing;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController reasonCancelOrderText = TextEditingController();
  RxList<School> schoolList = <School>[].obs;
  RxList<Session> sessionList = <Session>[].obs;
  RxList<SessionDetail> sessionDetailList = <SessionDetail>[].obs;
  Rx<School?> selectedSchool = Rx<School?>(null);
  Rx<Session?> selectedSession = Rx<Session?>(null);
  Rx<SessionDetail?> selectedSessionDetail = Rx<SessionDetail?>(null);
  RxString datePicker = 'Ngày/Tháng/Năm'.obs;

  @override
  void setDataTable(List<Order> list) {
    rows.value = list.map((dataMap) {
      return OrderTabView(
        status: status,
      ).setRow(dataMap);
    }).toList();
  }

  @override
  Future fetchData() async {
    try {
      final data = await OrderService().getByStatus(status);
      dataList = data;
      setDataTable(dataList);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future fetchSchoolData() async {
    try {
      final data = await SchoolService().getAll();
      schoolList.value = data;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future fetchSessionData() async {
    if (selectedSchool.value != null) {
      try {
        final data = await SessionService().getSessionsBySchoolId(selectedSchool.value!.id!, null);
        sessionList.value = data;
      } catch (e) {
        throw Exception(e);
      }
    }
  }

  Future fetchSessionDetailData() async {
    if (selectedSession.value != null) {
      try {
        final data = await SessionDetailService().getBySessionId(selectedSession.value!.id!);
        sessionDetailList.value = data;
      } catch (e) {
        throw Exception(e);
      }
    }
  }

  void selectSchool(School value) {
    selectedSchool.value = value;
  }

  void selectSession(Session value) {
    selectedSession.value = value;
  }

  void selectSessionDetail(SessionDetail value) {
    selectedSessionDetail.value = value;
  }

  void setDate(String value) {
    datePicker.value = value;
  }

  // @override
  // void search(String value) {
  //   if (value == '') {
  //     setDataTable(initModelList);
  //   } else {
  //     currentModelList = initModelList
  //         .where((e) => e.code!.toLowerCase().contains(value.toLowerCase()))
  //         .toList();
  //     setDataTable(currentModelList);
  //   }
  // }

  // void sortByPaymentDate(int index) {
  //   columnIndex.value = index;
  //   columnAscending.value = !columnAscending.value;
  //   currentModelList.sort((a, b) => a.paymentDate!.compareTo(b.paymentDate!));
  //   if (!columnAscending.value) {
  //     currentModelList = currentModelList.reversed.toList();
  //   }
  //   setDataTable(currentModelList);
  // }

  // void sortByDeliveryDate(int index) {
  //   columnIndex.value = index;
  //   columnAscending.value = !columnAscending.value;
  //   currentModelList = initModelList;
  //   currentModelList.sort((a, b) => a.deliveryDate!.compareTo(b.deliveryDate!));
  //   if (!columnAscending.value) {
  //     currentModelList = currentModelList.reversed.toList();
  //   }
  //   setDataTable(currentModelList);
  // }

  Future cancelOrder(String orderId) async {
    try {
      String reason = reasonCancelOrderText.text.trim();
      await OrderService().cancelOrder(orderId, reason);
      Get.snackbar('Thành công', 'Hủy đơn thành công');
      await fetchData();
    } on DioException catch (e) {
      Get.snackbar('Lỗi', e.response!.data['message']);
    }
  }
}
