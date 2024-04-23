import 'package:dio/dio.dart';
import 'package:get/get.dart' as getx;

import '/enums/status_enum.dart';
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
      order.orderDetails![0].food =
          await FoodService().getById(order.orderDetails![0].foodId!);
    }
    return list;
  }

  Future<List<Order>> getByStatus(OrderStatus status) async {
    final response =
        await _apiService.request.get('$baseUrl?status=${status.code}');
    List<Order> list = [];
    for (var e in response.data['data']) {
      list.add(Order.fromJson(e));
    }
    return list;
  }

  Future<Order> getById(String id) async {
    final response = await _apiService.request.get('food/$id');
    return Order.fromJson(response.data['data']);
  }

  Future<bool> cancelOrder(String orderId, String reason) async {
    FormData formData = FormData.fromMap({
      'Reason': reason,
    });
    Response response = await _apiService.request
        .put('$baseUrl/cancel/$orderId', data: formData);
    return response.statusCode == 200;
  }
}
