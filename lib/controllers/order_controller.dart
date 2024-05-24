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
  Rx<Order> order = Order().obs;

  RxList<School> schoolList = <School>[].obs;
  List<School> schoolDataList = [];
  RxList<Session> sessionList = <Session>[].obs;
  List<Session> sessionDataList = [];
  RxList<SessionDetail> sessionDetailList = <SessionDetail>[].obs;
  List<SessionDetail> sessionDetailDataList = [];
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
      final data = await OrderService().getByStatus(
          status,
          selectedSchool.value?.id,
          selectedSession.value?.id,
          selectedSessionDetail.value?.id);
      dataList = data;
      setDataTable(dataList);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future fetchOrder(String id) async {
    try {
      order.value = await OrderService().getById(id);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future fetchSchoolData() async {
    try {
      schoolDataList = await SchoolService().getAll();
      schoolList.value = schoolDataList;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future fetchSessionData() async {
    if (selectedSchool.value != null) {
      try {
        sessionDataList = await SessionService()
            .getSessionsBySchoolId(selectedSchool.value!.id!, null);
        sessionDataList.sort(
            (a, b) => b.deliveryStartTime!.compareTo(a.deliveryStartTime!));
        sessionList.value = sessionDataList;
      } catch (e) {
        throw Exception(e);
      }
    }
  }

  Future fetchSessionDetailData() async {
    if (selectedSession.value != null) {
      try {
        //api get session by School Id đã có session
        sessionDetailDataList = sessionDataList
            .firstWhere((e) => e.id == selectedSession.value?.id)
            .sessionDetails!;
        sessionDetailList.value = sessionDetailDataList;
      } catch (e) {
        throw Exception(e);
      }
    }
  }

  Future selectSchool(School value) async {
    selectedSchool.value = value;
    selectedSession.value = null;
    await fetchData();
  }

  void searchSchool(String value) {
    if (value == '') {
      schoolList.value = schoolDataList;
    } else {
      schoolList.value = schoolDataList
          .where((e) => e.name!.toLowerCase().contains(value.toLowerCase()))
          .toList();
    }
  }

  Future selectSession(Session value) async {
    selectedSession.value = value;
    selectedSessionDetail.value = null;
    await fetchData();
  }

  Future selectSessionDetail(SessionDetail value) async {
    selectedSessionDetail.value = value;
    await fetchData();
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

  Future cancelOrder(String orderId, String reason) async {
    try {
      await OrderService().cancelOrder(orderId, reason);
      Get.snackbar('Thành công', 'Hủy đơn thành công');
      await fetchData();
    } on DioException catch (e) {
      Get.snackbar('Lỗi', e.response!.data['message']);
    }
  }
}
