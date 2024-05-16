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

  void selectSessionDetail(String sessionDetailId) {
    selectedSessionDetail.value =
        data.value.sessionDetails!.firstWhere((e) => e.id == sessionDetailId);
    dataList = selectedSessionDetail.value?.orders ?? [];
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
    selectedSessionDetail.value!.deliverers!.add(User(id: delivererId));
    await updateDeliverer();
  }

  Future removeDeliverer(String delivererId) async {
    selectedSessionDetail.value!.deliverers!
        .removeWhere((e) => e.id == delivererId);
    await updateDeliverer();
  }

  Future updateDeliverer() async {
    try {
      List<String> idList = [];
      for (var e in selectedSessionDetail.value!.deliverers!) {
        idList.add(e.id.toString());
      }
      await SessionService().updateDeliverySchedule(
          selectedSessionDetail.value!.id!, idList);
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
        selectSessionDetail(selectedSessionDetail.value?.id ??
            data.value.sessionDetails![0].id!);
      } catch (e) {
        throw Exception(e);
      }
    }
  }
}
