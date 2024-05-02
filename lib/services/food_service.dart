import 'package:dio/dio.dart';
import 'package:get/get.dart' as getx;

import '/models/food.dart';
import '/services/api_service.dart';

class FoodService {
  final String baseUrl = 'foods';

  final ApiService _apiService = getx.Get.put(ApiService());

  Future<List<Food>> getAll(bool? isCombo) async {
    Map<String, dynamic> queryParameters = {};

    // if (isCombo != null) {
    //   queryParameters['isCombo'] = isCombo.toString();
    // }
    final response = await _apiService.request.get(baseUrl,
        queryParameters: queryParameters.isNotEmpty ? queryParameters : null);
    List<Food> list = [];
    for (var e in response.data['data']) {
      list.add(Food.fromJson(e));
    }
    return list;
  }

  // Future<Food?> getByCode(String code) async {
  //   final response = await _apiService.request.get('$baseUrl?code=$code');
  //   List<Food> list = [];
  //   for (var e in response.data['data']) {
  //     list.add(Food.fromJson(e));
  //   }
  //   if (list.isNotEmpty) {
  //     return list[0];
  //   }
  //   return null;
  // }

  Future<Food> getById(String id) async {
    final response = await _apiService.request.get('$baseUrl/$id');
    return Food.fromJson(response.data['data']);
  }

  Future<bool> create(Food model, bool isCombo) async {
    FormData formData = FormData.fromMap({
      'name': model.name,
      'price': model.price,
      'description': model.description,
      'IsCombo': isCombo,
      'CategoryId': model.categoryId,
      'Image': MultipartFile.fromBytes(
        model.imageFile!.files.single.bytes!,
        filename: 'uploadFile.jpg',
      ),
    });
    if (isCombo) {
      for (int i = 0; i < model.combos!.length; i++) {
        formData.fields.addAll([
          MapEntry('combos[$i][FoodId]', model.combos![i].foodId.toString()),
          MapEntry(
              'combos[$i][Quantity]', model.combos![i].quantity.toString()),
        ]);
      }
    }
    Response response = await _apiService.request.post(baseUrl, data: formData);
    return response.statusCode == 201;
  }
}
