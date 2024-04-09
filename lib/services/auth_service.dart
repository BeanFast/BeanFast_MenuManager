import 'package:dio/dio.dart';
import 'package:get/get.dart' as getx;

import '/models/user.dart';
import '/utils/logger.dart';
import '/services/api_service.dart';

class AuthService {
  final String baseUrl = 'auth';
  final ApiService _apiService = getx.Get.put(ApiService());
  Future<Response> login(String email, String password) async {
    try {
      Map<String, dynamic> data = {
        'email': email,
        'password': password,
      };
      final response =
          await _apiService.request.post('$baseUrl/login', data: data);
      logger.i(response.statusCode);
      logger.i(response.data);
      return response;
    } catch (e) {
      throw Exception('Failed to login: $e');
    }
  }

  Future<User> getUser() async {
    final response = await _apiService.request.get('$baseUrl/current');
    return User.fromJson(response.data['data']);
  }
}
