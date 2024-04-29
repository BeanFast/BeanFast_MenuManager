import 'package:beanfast_menumanager/models/category.dart';
import 'package:get/get.dart';

import '/services/api_service.dart';

class CategoryService {
  final String baseUrl = 'categories';

  // ApiService1(this.baseUrl);
  // final ApiService _apiService = Get.find();
  final ApiService _apiService = Get.put(ApiService());

  Future<List<Category>> getAll() async {
    final response = await _apiService.request.get(baseUrl);
    List<Category> list = [];
    for (var e in response.data['data']) {
      list.add(Category.fromJson(e));
    }
    return list;
  }

  Future<dynamic> getById(String id) async {
    final response = await _apiService.request.get('$baseUrl/$id');
    return response.data;
  }
}
