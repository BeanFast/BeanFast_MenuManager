import 'package:beanfast_menumanager/services/api_service.dart';
import 'package:get/get.dart';

class MenuService {
  final ApiService _apiService = Get.put(ApiService());
  Future<dynamic> getAll() async {
    final response = await _apiService.request.get('menus');
    return response.data["data"];
  }
}
