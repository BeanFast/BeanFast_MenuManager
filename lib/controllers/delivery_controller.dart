import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:intl/intl.dart';

import '../services/session_detail_service.dart';
import '/models/session_detail.dart';
import '/views/pages/delivery_page.dart';
import '/controllers/data_table_controller.dart';
import '/utils/logger.dart';

class DeliveryController extends DataTableController<SessionDetail> {
    Rx<DateTime> selectedDateStart = DateTime.now().obs;
  Rx<String> selectedDateStrStart =
      DateFormat('dd-MM-yyyy').format(DateTime.now()).obs;

  Rx<DateTime> selectedDateEnd = DateTime.now().obs;
  Rx<String> selectedDateStrEnd =
      DateFormat('dd-MM-yyyy').format(DateTime.now()).obs;
      
  void selectDeliverer(String sessionDetailId, String delivererId) {
    logger.e(selectDeliverer);
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
      final data = await SessionDetailService().deliverySchedule();
      list.addAll(data);
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
