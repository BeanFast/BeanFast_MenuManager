import 'package:beanfast_menumanager/models/kitchen.dart';
import 'package:beanfast_menumanager/services/api_service.dart';
import 'package:get/get.dart';

class KitchenService {
  final ApiService _apiService = Get.put(ApiService());
  final String baseUrl = 'kitchens';
  Future<List<Kitchen>> getAll() async {
    final response = await _apiService.request.get(baseUrl);
    List<Kitchen> list = [];
    for (var e in response.data['data']) {
      list.add(Kitchen.fromJson(e));
    }
    return list;
  }
}
