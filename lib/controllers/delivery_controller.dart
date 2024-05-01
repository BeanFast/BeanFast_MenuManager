import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '/models/user.dart';
import '/services/session_service.dart';
import '/services/session_detail_service.dart';
import '/models/session_detail.dart';
import '/views/pages/delivery_page.dart';
import '/controllers/data_table_controller.dart';

class DeliveryController extends DataTableController<SessionDetail> {
  RxList<User> listDeliverer = <User>[].obs;
  bool isHasDeliverer = true;
  RxList<User> selectedListDeliverer = <User>[].obs;

  void getSelectedListDeliverer(String sessionDetailId) {
    if (isHasDeliverer) {
      SessionDetail model =
          initModelList.firstWhere((e) => e.id == sessionDetailId);
      selectedListDeliverer.value = model.deliverers!;
    }
  }

  void addDeliverer(User deliverer) {
    selectedListDeliverer.add(deliverer);
  }

  void removeDeliverer(User deliverer) {
    selectedListDeliverer.remove(deliverer);
  }

  Future<void> getListDeliverer(String sessionDetailId) async {
    try {
      List<User> list = await SessionService()
          .getListDelivererBySessionDetailId(sessionDetailId);
      for (var deliverer in selectedListDeliverer) {
        list.removeWhere((e) => e.id == deliverer.id);
      }
      listDeliverer.value = list;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> selectDeliverer(String sessionDetailId) async {
    if (selectedListDeliverer.isEmpty) {
      Get.snackbar('Thất bại', 'Chưa chọn người giao hàng');
      return;
    }
    try {
      List<String> selectedDelivererId = [];
      for (var e in selectedListDeliverer) {
        selectedDelivererId.add(e.id.toString());
      }
      await SessionService()
          .updateDeliverySchedule(sessionDetailId, selectedDelivererId);
      await refreshData();
    } on DioException catch (e) {
      Get.snackbar('Lỗi', e.response!.data['message']);
    }
  }

  Rx<DateTime> selectedDateStart = DateTime.now().obs;
  Rx<String> selectedDateStrStart =
      DateFormat('dd-MM-yyyy').format(DateTime.now()).obs;

  Rx<DateTime> selectedDateEnd = DateTime.now().obs;
  Rx<String> selectedDateStrEnd =
      DateFormat('dd-MM-yyyy').format(DateTime.now()).obs;

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
      List<SessionDetail> data =
          await SessionDetailService().deliverySchedule();
      for (var e in data) {
        if ((isHasDeliverer && e.deliverers!.isNotEmpty)) {
          list.add(e);
        }
        if (!isHasDeliverer && e.deliverers!.isEmpty) {
          list.add(e);
        }
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future loadPage(int page) {
    // TODO: implement loadPage
    throw UnimplementedError();
  }

  @override
  void setDataTable(List<SessionDetail> list) {
    rows.value = list.map((dataMap) {
      return DeliveryTabView().setRow(list.indexOf(dataMap), dataMap);
    }).toList();
  }

  void sortByCreateDate(int index) {
    columnIndex.value = index;
    columnAscending.value = !columnAscending.value;
    // currentModelList.sort((a, b) => a.createDate!.compareTo(b.createDate!));
    if (!columnAscending.value) {
      currentModelList = currentModelList.reversed.toList();
    }
    setDataTable(currentModelList);
  }
}
