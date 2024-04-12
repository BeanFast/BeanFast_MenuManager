import 'package:dio/dio.dart';

import 'package:beanfast_menumanager/models/session.dart';
import 'package:beanfast_menumanager/models/user.dart';
import 'package:beanfast_menumanager/services/api_service.dart';
import 'package:beanfast_menumanager/utils/logger.dart';
import 'package:get/get.dart' as getx;

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
      Map<String, dynamic> orderDetail = {
        "LocationId": e.locationId,
      };
      sessionDetails.add(orderDetail);
    });
    Map<String, dynamic> data = {
      'menuId': session.menuId,
      'orderStartTime': session.orderStartTime,
      'orderEndTime': session.orderEndTime,
      'deliveryStartTime': session.deliveryStartTime,
      'deliveryEndTime': session.deliveryEndTime,
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
