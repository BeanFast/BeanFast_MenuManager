import 'package:beanfast_menumanager/models/user.dart';
import 'package:beanfast_menumanager/services/session_service.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart' as getx;

import '../services/session_detail_service.dart';
import '/models/session_detail.dart';
import '/views/pages/delivery_page.dart';
import '/controllers/data_table_controller.dart';
import '/utils/logger.dart';

class DeliveryController extends DataTableController<SessionDetail> {
  getx.RxList<User> listDeliverer = <User>[].obs;
  bool isHasDeliverer = true;

  Future<void> getListDeliverer(String sessionDetailId) async {
    try {
      listDeliverer.value =
          await SessionService().getListDelivererBySessionId(sessionDetailId);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> selectDeliverer(
      String sessionDetailId, String delivererId) async {
    try {
      logger.e('selectDeliverer');
      Response response = await SessionDetailService()
          .updateDeliverySchedule(sessionDetailId, delivererId);
      logger.e(response.data);
    } catch (e) {
      throw Exception(e);
    }
  }

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
      data.forEach((e) {
        if (isHasDeliverer == true && e.deliverer != null) {
          list.add(e);
        }
      });
      // list.addAll(data);
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
