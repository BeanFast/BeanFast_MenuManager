import 'package:get/get.dart' as getx;

import '/models/session_detail.dart';
import '/services/api_service.dart';

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

  Future<List<SessionDetail>> getBySessionId(String id) async {
    // final response = await _apiService.request.get('$baseUrl?');
    List<SessionDetail> list = [];
    // for (var e in response.data['data']) {
    //   list.add(SessionDetail.fromJson(e));
    // }
    return list;
  }

  // Future<Response> updateDeliverySchedule(
  //     String sessionDetailId, List<String> listDelivererId) async {
  //   List<String> list = [];
  //   for (var e in listDelivererId) {
  //     list.add(e);
  //   }
  //   Map<String, dynamic> data = {
  //     'delivererId': list,
  //   };
  //   final response =
  //       await _apiService.request.put('$baseUrl/$sessionDetailId', data: data);
  //   logger.i(response.statusCode);
  //   logger.i(response.data);
  //   return response;
  // }
}
