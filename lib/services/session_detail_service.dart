import 'package:get/get.dart';

import '/models/session_detail.dart';
import '/services/api_service.dart';

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
