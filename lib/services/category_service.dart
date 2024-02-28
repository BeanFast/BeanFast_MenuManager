import 'package:get/get.dart';

import '/services/api_service.dart';

class CategoryService {
  // final String baseUrl;

  // ApiService1(this.baseUrl);
  // final ApiService _apiService = Get.find();
  final ApiService _apiService = Get.put(ApiService());

  Future<dynamic> getAll() async {
    final response = await _apiService.request.get('category');
    return response.data;
  }

  Future<dynamic> getById(String id) async {
    final response = await _apiService.request.get('category/$id');
    return response.data;
  }
}