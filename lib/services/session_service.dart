import 'package:dio/dio.dart';

import '/models/session.dart';
import '/models/user.dart';
import '/services/api_service.dart';
import '/utils/logger.dart';
import 'package:get/get.dart' as getx;
import 'package:intl/intl.dart';

class SessionService {
  final ApiService _apiService = getx.Get.put(ApiService());
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

  Future<List<User>> getListDelivererBySessionId(String sessionDetailId) async {
    final response = await _apiService.request
        .get("$baseUrl/deliverers/available/$sessionDetailId");
    List<User> list = [];
    for (var e in response.data['data']) {
      list.add(User.fromJson(e));
    }
    return list;
  }

  Future createSession(Session session) async {
    List<Map<String, dynamic>> sessionDetails = [];
    session.sessionDetails?.forEach((e) {
      Map<String, dynamic> location = {
        "LocationId": e.locationId,
      };
      sessionDetails.add(location);
    });
    Map<String, dynamic> data = {
      'menuId': session.menuId,
      'orderStartTime':
          DateFormat('yyyy-MM-ddTHH:mm:ss').format(session.orderStartTime!),
      'orderEndTime':
          DateFormat('yyyy-MM-ddTHH:mm:ss').format(session.orderEndTime!),
      'deliveryStartTime':
          DateFormat('yyyy-MM-ddTHH:mm:ss').format(session.deliveryStartTime!),
      'deliveryEndTime':
          DateFormat('yyyy-MM-ddTHH:mm:ss').format(session.deliveryEndTime!),
      'sessionDetails': sessionDetails,
    };
    try {
      await _apiService.request.post(baseUrl, data: data);
      // return response;
    } on DioException catch (e) {
      logger.e(e.response!.data);
      // return null;
    }
  }
}
