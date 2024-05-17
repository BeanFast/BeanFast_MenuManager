import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '/models/session_detail.dart';
import '/models/user.dart';
import '/models/order.dart';
import '/models/session.dart';
import '/views/pages/session_detail_page.dart';
import '/services/session_service.dart';
import 'paginated_data_table_controller.dart';

class SessionDetailController extends PaginatedDataTableController<Order> {
  String? sessionId;
  Rx<Session> data = Session().obs;
  Rx<SessionDetail?> selectedSessionDetail = Rx<SessionDetail?>(null);
  RxList<User> delivererList = <User>[].obs;
  Set<String> selectedIdDelivererList = {};

  void selectSessionDetail(String sessionDetailId) {
    selectedIdDelivererList.clear(); //clear
    selectedSessionDetail.value = data.value.sessionDetails!
        .firstWhere((e) => e.id == sessionDetailId); //find
    selectedSessionDetail.value!.deliverers?.forEach((deliverer) {
      selectedIdDelivererList.add(deliverer.id!);
    });
    dataList = selectedSessionDetail.value?.orders ?? []; //set order list
    dataList.sort((a, b) => a.status!.compareTo(b.status!));
    setDataTable(dataList);
  }

  Future<void> fetchDeliverersData(String sessionDetailId) async {
    try {
      delivererList.value = await SessionService()
          .getListDelivererBySessionDetailId(sessionDetailId);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future addDeliverer(String delivererId) async {
    selectedIdDelivererList.add(delivererId);
    await updateDeliverer();
  }

  Future removeDeliverer(String delivererId) async {
    selectedIdDelivererList.remove(delivererId);
    await updateDeliverer();
  }

  Future updateDeliverer() async {
    try {
      await SessionService().updateDeliverySchedule(
          selectedSessionDetail.value!.id!, selectedIdDelivererList.toList());
      await fetchData();
    } on DioException catch (e) {
      Get.snackbar('Lỗi', e.response!.data['message']);
    }
  }

  @override
  void setDataTable(List<Order> list) {
    rows.value = list.map((dataMap) {
      return SessionDetailPage.setRow(dataMap);
    }).toList();
  }

  @override
  Future fetchData() async {
    if (sessionId != null) {
      try {
        data.value = await SessionService().getById(sessionId!);
        selectSessionDetail(data.value.sessionDetails!
                .any((e) => e.id == selectedSessionDetail.value?.id)
            ? selectedSessionDetail.value!.id!
            : data.value.sessionDetails![0].id!);
      } catch (e) {
        throw Exception(e);
      }
    }
  }
}
