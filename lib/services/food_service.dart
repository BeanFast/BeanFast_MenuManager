import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get/get.dart' as getx;

import '/models/food.dart';
import '/services/api_service.dart';

class FoodService {
  final String baseUrl = 'food';

  // ApiService1(this.baseUrl);
  // final ApiService _apiService = Get.find();
  final ApiService _apiService = getx.Get.put(ApiService());

  Future<dynamic> getAll() async {
    final response = await _apiService.request.get(baseUrl);
    return response.data;
  }

  Future<dynamic> getById(String id) async {
    final response = await _apiService.request.get('$baseUrl/$id');
    return response.data;
  }

  Future<dynamic> create(Food food) async {
    try {
      // Tạo FormData để chứa file
      FormData formData = FormData.fromMap({
        "file": await MultipartFile.fromFile(food.imagePath!, filename: "file.txt"),
      });

      Response response = await _apiService.request.post(baseUrl, data: formData);

      print("Response: ${response.data}");
    } catch (e) {
      print("Error: $e");
    }
  }
}
