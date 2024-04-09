import 'package:beanfast_menumanager/models/session_detail.dart';
import 'package:beanfast_menumanager/services/api_service.dart';
import 'package:get/get.dart';

class SessionDetailService {
  final ApiService _apiService = Get.put(ApiService());
  final String baseUrl = 'SessionDetails';
  Future<List<SessionDetail>> deliverySchedule() async {
    final response =
        await _apiService.request.get(baseUrl);
    List<SessionDetail> list = [];
    for (var e in response.data['data']) {
      list.add(SessionDetail.fromJson(e));
    }
    return list;
  }
}
