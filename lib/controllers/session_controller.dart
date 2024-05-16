import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '/models/session.dart';
import '/services/session_service.dart';
import '/enums/status_enum.dart';
import '/utils/logger.dart';
import '/views/pages/session_page.dart';
import 'paginated_data_table_controller.dart';

class SessionController extends PaginatedDataTableController<Session> {
  SessionStatus status = SessionStatus.orderable;
  Rx<DateTime> selectedDateStart = DateTime.now().obs;
  Rx<String> selectedDateStrStart =
      DateFormat('dd/MM/yyyy').format(DateTime.now()).obs;

  Rx<DateTime> selectedDateEnd = DateTime.now().obs;
  Rx<String> selectedDateStrEnd =
      DateFormat('dd/MM/yyyy').format(DateTime.now()).obs;

  Future delete(String id) async {
    logger.e(id);
    try {
      await SessionService().delete(id);
      Get.back();
      await fetchData();
      Get.snackbar('Thành công', 'Xóa thành công');
    } on DioException catch (e) {
      Get.back();
      Get.snackbar('Thất bại', e.response!.data['message']);
    }
  }

  // void sortByCreateDate(int index) {
  //   columnIndex.value = index;
  //   columnAscending.value = !columnAscending.value;
  //   // currentModelList.sort((a, b) => a.createDate!.compareTo(b.createDate!));
  //   if (!columnAscending.value) {
  //     currentModelList = currentModelList.reversed.toList();
  //   }
  //   setDataTable(currentModelList);
  // }

  @override
  void setDataTable(List<Session> list) {
    rows.value = list.map((dataMap) {
      return SessionTabView(status: status).setRow(dataMap);
    }).toList();
  }

  @override
  Future fetchData() async {
    try {
      var schoolId = Get.parameters['schoolId'];
      final data =
          await SessionService().getSessionsBySchoolId(schoolId!, status);
      data.sort((a, b) => b.deliveryStartTime!.compareTo(a.deliveryStartTime!));
      dataList = data;
      setDataTable(dataList);
    } catch (e) {
      throw Exception(e);
    }
  }
}
