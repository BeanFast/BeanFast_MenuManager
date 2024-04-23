import 'package:get/get.dart' as getx;

import '/models/gift.dart';
import '/services/api_service.dart';

class GiftService {
  final String baseUrl = 'gifts';

  final ApiService _apiService = getx.Get.put(ApiService());

  Future<List<Gift>> getAll() async {
    final response = await _apiService.request.get('$baseUrl?page=1&size=100');
    List<Gift> list = [];
    for (var e in response.data['data']['items']) {
      list.add(Gift.fromJson(e));
    }
    return list;
  }

  // Future<Response> getById(String id) async {
  //   final response = await _apiService.request.get('$baseUrl/$id');
  //   return response;
  // }
}
