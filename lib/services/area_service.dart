import 'package:get/get.dart';

import '/services/api_service.dart';
import '/models/area.dart';

class AreaService {
  final String baseUrl = 'areas';

  final ApiService _apiService = Get.put(ApiService());

  Future<List<Area>> getAll() async {
    final response = await _apiService.request.get('$baseUrl/all');
    List<Area> list = [];
    for (var e in response.data['data']) {
      list.add(Area.fromJson(e));
    }
    return list;
  }
}
