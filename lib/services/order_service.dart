import 'package:dio/dio.dart';
import 'package:get/get.dart' as getx;

import '../utils/logger.dart';
import '/enums/status_enum.dart';
import '/models/food.dart';
import '/models/order.dart';
import '/services/api_service.dart';
import 'food_service.dart';

class OrderService {
  final String baseUrl = 'orders';
  final ApiService _apiService = getx.Get.put(ApiService());

  Future<List<Order>> getAll() async {
    final response = await _apiService.request.get(baseUrl);
    List<Order> list = [];
    for (var e in response.data['data']) {
      list.add(Order.fromJson(e));
      var order = list.last;
      var responseFood =
          await FoodService().getById(order.orderDetails![0].foodId!);
      order.orderDetails![0].food = Food.fromJson(responseFood.data['data']);
    }
    return list;
  }

  Future<List<Order>> getByStatus(OrderStatus status) async {
    final response =
        await _apiService.request.get('$baseUrl?status=${status.code}');
    List<Order> list = [];
    for (var e in response.data['data']) {
      list.add(Order.fromJson(e));
      // var order = list.last;
      // var responseFood =
      //     await FoodService().getById(order.orderDetails![0].foodId!);
      // order.orderDetails![0].food = Food.fromJson(responseFood.data['data']);
    }
    return list;
  }

  Future<Order> getById(String id) async {
    final response = await _apiService.request.get('food/$id');
    return Order.fromJson(response.data['data']);
  }

  Future<Response> createOrder(
    String sessionDetailId,
    String profileId,
  ) async {
    try {
      List<Map<String, dynamic>> orderDetails = [];

      Map<String, dynamic> data = {
        'sessionDetailId': '9D2EF316-F4C6-490C-B762-E3BD16406793',
        'profileId': '2A6B1E8E-7BF3-41EF-9DA6-32D028AAC212',
        'orderDetails': orderDetails,
      };
      final response = await _apiService.request.post(baseUrl, data: data);
      logger.i(response);
      return response;
    } catch (e) {
      throw Exception('Failed to login: $e');
    }
  }
}
