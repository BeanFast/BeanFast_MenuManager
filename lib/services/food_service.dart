import 'package:dio/dio.dart';
import 'package:get/get.dart' as getx;

import '/models/food.dart';
import '/services/api_service.dart';

class FoodService {
  final String baseUrl = 'foods';

  // ApiService1(this.baseUrl);
  // final ApiService _apiService = Get.find();
  final ApiService _apiService = getx.Get.put(ApiService());

  Future<List<Food>> getAll() async {
    final response = await _apiService.request.get(baseUrl);
    List<Food> list = [];
    for (var e in response.data['data']) {
      list.add(Food.fromJson(e));
    }
    return list;
  }

  Future<Food?> getByCode(String code) async {
    final response = await _apiService.request.get('$baseUrl?code=$code');
    List<Food> list = [];
    for (var e in response.data['data']) {
      list.add(Food.fromJson(e));
    }
    if (list.isNotEmpty) {
      return list[0];
    }
    return null;
  }

  Future<Food> getById(String id) async {
    final response = await _apiService.request.get('$baseUrl/$id');
    return Food.fromJson(response.data['data']);
  }

  Future create(Food model) async {
    FormData formData = FormData.fromMap({
      'name': model.name,
      'price': model.price,
      'description': model.description,
      'IsCombo': model.isCombo,
      'Image': await MultipartFile.fromFile(model.imagePath!,
          filename: 'uploadFile.jpg'),
      'CategoryId': model.categoryId,
    });
    await _apiService.request.post(baseUrl, data: formData);
  }
}
