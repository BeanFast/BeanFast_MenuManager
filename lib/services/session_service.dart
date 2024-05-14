import 'package:get/get.dart' as getx;
import 'package:intl/intl.dart';

import '/models/session.dart';
import '/models/user.dart';
import '/services/api_service.dart';
import '/enums/status_enum.dart';

class SessionService {
  final ApiService _apiService = getx.Get.put(ApiService());
  final String baseUrl = 'sessions';

  Future<List<Session>> getSessionsBySchoolId(
      String schoolId, SessionStatus? status) async {
    Map<String, dynamic> queryParameters = {};
    queryParameters['schoolId'] = schoolId;
    if (status != null) {
      switch (status) {
        case SessionStatus.orderable:
          queryParameters['Orderable'] = true;
          break;
        case SessionStatus.incomming:
          queryParameters['Incomming'] = true;
          break;
        case SessionStatus.expired:
          queryParameters['Expired'] = true;
          break;
        default:
          queryParameters['Orderable'] = true;
      }
    }
    final response = await _apiService.request.get(baseUrl,
        queryParameters: queryParameters.isNotEmpty ? queryParameters : null);
    List<Session> list = [];
    for (var e in response.data['data']) {
      list.add(Session.fromJson(e));
    }
    return list;
  }

  Future<bool> delete(String id) async {
    final response = await _apiService.request.delete("$baseUrl/$id");
    return response.statusCode == 200;
  }

  Future<List<User>> getListDelivererBySessionDetailId(
      String sessionDetailId) async {
    final response = await _apiService.request
        .get("$baseUrl/deliverers/available/$sessionDetailId");
    List<User> list = [];
    for (var e in response.data['data']) {
      list.add(User.fromJson(e));
    }
    return list;
  }

  Future<bool> updateDeliverySchedule(
      String sessionDetailId, List<String> listDelivererId) async {
    // List<String> list = [];
    // for (var e in listDelivererId) {
    //   list.add(e);
    // }
    Map<String, dynamic> data = {
      'DelivererIds': listDelivererId,
    };
    final response = await _apiService.request
        .put('$baseUrl/SessionDetails/$sessionDetailId', data: data);
    return response.statusCode == 200;
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
    await _apiService.request.post(baseUrl, data: data);
  }
}
