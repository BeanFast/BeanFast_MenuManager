import 'package:dio/dio.dart';
import 'package:get/get.dart' as getx;

import '/models/menu.dart';
import '/services/api_service.dart';

class MenuService {
  final String baseUrl = 'menus';
  final ApiService _apiService = getx.Get.put(ApiService());

  Future<List<Menu>> getAll() async {
    List<Menu> list = [];
    final response = await _apiService.request.get(baseUrl);
    for (var e in response.data['data']) {
      list.add(Menu.fromJson(e));
    }
    return list;
  }

  Future<List<Menu>> getBySchoolId(String schoolId) async {
    List<Menu> list = [];
    final response =
        await _apiService.request.get('$baseUrl?schoolId=$schoolId');
    for (var e in response.data['data']) {
      list.add(Menu.fromJson(e));
    }
    return list;
  }

  Future<Menu> getById(String id) async {
    try {
      final response = await _apiService.request.get('$baseUrl/$id');
      return Menu.fromJson(response.data["data"]);
    } on DioException catch (e) {
      return e.response!.data["message"];
    }
  }

  Future<bool> create(
      String kitchenId, Map<String, double> mapMenuDetails) async {
    List<Map<String, dynamic>> menuDetails = [];
    mapMenuDetails.forEach((key, value) {
      Map<String, dynamic> orderDetail = {
        "foodId": key,
        "price": value,
      };
      menuDetails.add(orderDetail);
    });
    Map<String, dynamic> data = {
      'kitchenId': kitchenId,
      'menuDetails': menuDetails,
    };
    final response = await _apiService.request.post(baseUrl, data: data);
    return response.statusCode == 200;
  }

  Future<Menu> getByCode(String code) async {
    final response = await _apiService.request.get('$baseUrl?code=$code');
    final menuData = response.data["data"][0];
    return Menu.fromJson(menuData);
  }

  Future<dynamic> delete(String id) async {
    try {
      final response = await _apiService.request.delete('$baseUrl/$id');
      return response.data["data"];
    } on DioException catch (e) {
      return e.response!.data["message"];
    }
  }
}
