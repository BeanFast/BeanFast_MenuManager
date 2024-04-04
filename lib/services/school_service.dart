import 'package:beanfast_menumanager/models/school.dart';
import 'package:beanfast_menumanager/services/api_service.dart';
import 'package:get/get.dart';

class SchoolService {
  final String baseUrl = 'schools';
  final ApiService _apiService = Get.put(ApiService());
  Future<List<School>> getAll() async {
    var response = await _apiService.request.get(baseUrl);
    List<School> list = [];
    for (var e in response.data['data']) {
      list.add(School.fromJson(e));
    }
    return list;
  }
}
