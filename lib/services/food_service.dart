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
    final response = await _apiService.request.get('foods');
    List<Food> list = [];
    for (var e in response.data['data']) {
      list.add(Food.fromJson(e));
    }
    return list;
  }

  Future<Food?> getByCode(String code) async {
    final response = await _apiService.request.get('foods?code=$code');
    List<Food> list = response.data["data"] as List<Food>;
    if (list.isNotEmpty) {
      return Food.fromJson(list[0]);
    }
    return null;
  }

  Future<dynamic> getById(String id) async {
    final response = await _apiService.request.get('$baseUrl/$id');
    return response.data;
  }

  Future<dynamic> create(Food food) async {
    try {
      // Tạo FormData để chứa file
      FormData formData = FormData.fromMap({
        "file":
            await MultipartFile.fromFile(food.imagePath!, filename: "file.txt"),
      });

      Response response =
          await _apiService.request.post(baseUrl, data: formData);

      print("Response: ${response.data}");
    } catch (e) {
      print("Error: $e");
    }
  }
}
