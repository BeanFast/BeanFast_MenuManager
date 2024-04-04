import 'package:beanfast_menumanager/services/api_service.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class MenuService {
  final ApiService _apiService = Get.put(ApiService());
  Future<dynamic> getAll() async {
    final response = await _apiService.request.get('menus');
    return response.data["data"];
  }

  Future<dynamic> delete(String id) async {
    try {
      final response = await _apiService.request.delete('menus/$id');
      return response.data["data"];
    } on DioException catch (e) {
      return e.response!.data["message"];
    }
  }
}
