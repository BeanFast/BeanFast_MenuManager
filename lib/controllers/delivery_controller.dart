import 'package:beanfast_menumanager/models/session_detail.dart';
import 'package:beanfast_menumanager/views/pages/delivery_page.dart';

import '/controllers/data_table_controller.dart';
import '/utils/logger.dart';

class DeliveryController extends DataTableController<SessionDetail> {
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
    final apiDataList = [];
    // = await SessionDetailService().deliverySchedule();
    for (var e in apiDataList) {
      initModelList.add(e);
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
