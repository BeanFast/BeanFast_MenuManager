import 'package:dio/dio.dart';
import 'package:get/get.dart' as getx;

import '/models/session_detail.dart';
import '/services/api_service.dart';
import '/utils/logger.dart';

class SessionDetailService {
  final ApiService _apiService = getx.Get.put(ApiService());
  final String baseUrl = 'SessionDetails';

  Future<List<SessionDetail>> deliverySchedule() async {
    final response = await _apiService.request.get('$baseUrl/deliveryschedule');
    List<SessionDetail> list = [];
    for (var e in response.data['data']) {
      list.add(SessionDetail.fromJson(e));
    }
    return list;
  }

  Future<Response> updateDeliverySchedule(
      String sessionDetailId, String delivererId) async {
    Map<String, dynamic> data = {
      'delivererId': delivererId,
    };

    final response =
        await _apiService.request.put('$baseUrl/$sessionDetailId', data: data);
    logger.i(response.statusCode);
    logger.i(response.data);
    return response;
  }
}
