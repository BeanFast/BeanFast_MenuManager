import 'package:beanfast_menumanager/models/session.dart';
import 'package:beanfast_menumanager/services/session_service.dart';
import 'package:get/get.dart';

import '/controllers/data_table_controller.dart';
import '/utils/logger.dart';
import '../views/pages/session_page.dart';

class SessionController extends DataTableController<Session> {
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
    logger.i('menu getData');
    var schoolId = Get.parameters['schoolId'];
    print(schoolId);
    final apiDataList = await SessionService().getSessionsBySchoolId(schoolId!);
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
  void setDataTable(List<Session> list) {
    rows.value = list.map((dataMap) {
      return const SessionView().setRow(list.indexOf(dataMap), dataMap);
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
