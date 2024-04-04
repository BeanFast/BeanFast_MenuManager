import 'package:beanfast_menumanager/models/session.dart';
import 'package:beanfast_menumanager/services/api_service.dart';
import 'package:get/get.dart';

class SessionService {
  final ApiService _apiService = Get.put(ApiService());
  final String baseUrl = 'sessions';
  Future<List<Session>> getSessionsBySchoolId(String schoolId) async {
    final response =
        await _apiService.request.get("$baseUrl?schoolId=$schoolId");
    List<Session> list = [];
    for (var e in response.data['data']) {
      list.add(Session.fromJson(e));
    }
    return list;
  }
}
