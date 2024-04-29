import 'package:beanfast_menumanager/services/api_service.dart';
import 'package:get/get.dart' as getx;

class BestSellerFood {
  String id;
  String name;
  int soldCount;
  factory BestSellerFood.fromJson(Map<String, dynamic> json) {
    return BestSellerFood(
      id: json['id'],
      name: json['name'],
      soldCount: json['soldCount'],
    );
  }

  BestSellerFood({
    required this.id,
    required this.name,
    required this.soldCount,
  });
}

class OrderStatistic {
  String month;
  int count;
  int revenue;
  OrderStatistic(
      {required this.month, required this.count, required this.revenue});
  factory OrderStatistic.fromJson(Map<String, dynamic> json) {
    return OrderStatistic(
      month: json['month'],
      count: json['count'],
      revenue: json['revenue'],
    );
  }
}

class DashboardService {
  final ApiService _apiService = getx.Get.put(ApiService());
  Future<List<BestSellerFood>> getBestSellerFoods() async {
    final response =
        await _apiService.request.get("foods/bestsellers?number=10");
    List<BestSellerFood> result = [];
    if (response.statusCode == 200) {
      for (var e in response.data['data']) {
        result.add(BestSellerFood.fromJson(e));
      }
    }
    return result;
  }

  Future<List<OrderStatistic>> getOrderStatistics() async {
    final response = await _apiService.request
        .get("orders/countByMonth?startDate=2024-02-12&endDate=2024-04-12");
    List<OrderStatistic> result = [];
    if (response.statusCode == 200) {
      for (var e in response.data['data']) {
        result.add(OrderStatistic.fromJson(e));
      }
    }
    return result;
  }
}
