import 'package:get/get.dart';

import '/models/school.dart';
import '/services/api_service.dart';
import '/utils/logger.dart';

class SchoolService {
  final String baseUrl = 'schools';
  final ApiService _apiService = Get.put(ApiService());
  Future<List<School>> getAll() async {
    var response = await _apiService.request.get(baseUrl);
    List<School> list = [];
    for (var e in response.data['data']) {
      list.add(School.fromJson(e));
    }
    logger.e(list.length);
    return list;
  }

  Future<School> getById(String id) async {
    var response = await _apiService.request.get('$baseUrl/$id');
    return School.fromJson(response.data['data']);
  }
}
