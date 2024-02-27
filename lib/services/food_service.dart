import 'package:beanfast_menumanager/services/api_service.dart';
import 'package:get/get.dart';

class ApiService1 {
  // final String baseUrl;

  // ApiService1(this.baseUrl);

  final ApiService _apiService = Get.find();

  // Ví dụ hàm gọi API
  Future<dynamic> getAll() async {
    try {
      print('ApiService1 - fetchData');
      // final response = await _apiService.request.get('/api/endpoint');
      final response = await _apiService.request.get('food1');
      // Xử lý dữ liệu response ở đây
      // print(response.data);
      return response.data;
    } catch (error) {
      // Xử lý lỗi ở đây
      print('Error: $error');
    }
  }

  Future<dynamic> getById(String id) async {
    try {
      print('ApiService1 - fetchData');
      final response = await _apiService.request.get('food/$id');
      // Xử lý dữ liệu response ở đây
      // print(response.data);
      return response.data;
    } catch (error) {
      // Xử lý lỗi ở đây
      print('Error: $error');
    }
  }
}
