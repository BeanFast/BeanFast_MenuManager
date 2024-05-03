import 'package:beanfast_menumanager/services/api_service.dart';
import 'package:beanfast_menumanager/views/pages/widget/app_color_dashboard.dart';
import 'package:get/get.dart' as getx;
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

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

class BestSellerCategory {
  String category;
  double totalSold;
  late Color color;
  // Color color = AppColors.getRandomContentColor();
  BestSellerCategory({
    required this.category,
    required this.totalSold,
  });

  factory BestSellerCategory.fromJson(Map<String, dynamic> json) {
    return BestSellerCategory(
      category: json['category'],
      totalSold: json['totalSold'],
    );
  }
}

class OrderStatisticByDays {
  String day;
  int count;
  int revenue;
  factory OrderStatisticByDays.fromJson(Map<String, dynamic> json) {
    return OrderStatisticByDays(
      day: json['day'],
      count: json['count'],
      revenue: json['revenue'],
    );
  }

  OrderStatisticByDays({
    required this.day,
    required this.count,
    required this.revenue,
  });
  // Color color = AppColors.getRandomContentColor();
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

class TopSellerSchool {
  String schoolName;
  int count;
  double percentage;
  int revenue;
  late Color color;
  TopSellerSchool({
    required this.schoolName,
    required this.count,
    required this.percentage,
    required this.revenue,
  });

  factory TopSellerSchool.fromJson(Map<String, dynamic> json) {
    return TopSellerSchool(
      schoolName: json['schoolName'],
      count: json['count'],
      percentage: json['percentage'],
      revenue: json['revenue'],
    );
  }
}

class TopSellerKitchen {
  String name;
  int totalOrder;
  int totalItem;
  double percentage;
  late Color color;
  factory TopSellerKitchen.fromJson(Map<String, dynamic> json) {
    return TopSellerKitchen(
      name: json['name'],
      totalOrder: json['totalOrder'],
      totalItem: json['totalItem'],
      percentage: json['percentage'],
    );
  }

  TopSellerKitchen({
    required this.name,
    required this.totalOrder,
    required this.totalItem,
    required this.percentage,
  });
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

  Future<List<BestSellerCategory>> getBestSellerCategories() async {
    final response =
        await _apiService.request.get("categories/topSellers?topCount=5");
    List<BestSellerCategory> result = [];
    if (response.statusCode == 200) {
      List<dynamic> res = response.data['data'];

      for (var i = 0; i < res.length; i++) {
        var e = res[i];
        var cate = BestSellerCategory.fromJson(e);
        cate.color = AppColors.getContentColor(i);
        result.add(cate);
      }
    }
    return result;
  }

  Future<List<TopSellerKitchen>> getTopSellerKitchens(int topCount) async {
    final response = await _apiService.request
        .get("/orders/kitchens/bestSellers?topCount=${topCount}&desc=true");
    List<TopSellerKitchen> result = [];
    if (response.statusCode == 200) {
      List<dynamic> res = response.data['data'];

      for (var i = 0; i < res.length; i++) {
        var e = res[i];
        var kitchen = TopSellerKitchen.fromJson(e);
        kitchen.color = AppColors.getContentColor(i);
        result.add(kitchen);
      }
      // for (var e in response.data['data']) {
      //   var topSellerKitchen = TopSellerKitchen.fromJson(e);
      //   topSellerKitchen.color = AppColors.getRandomContentColor();
      //   result.add();
      // }
    }
    return result;
  }

  Future<List<TopSellerSchool>> getTopSellerSchools(int topCount) async {
    final response = await _apiService.request
        .get("/orders/schools/bestSellers?topCount=${topCount}");
    List<TopSellerSchool> result = [];
    if (response.statusCode == 200) {
      List<dynamic> res = response.data['data'];

      for (var i = 0; i < res.length; i++) {
        var e = res[i];
        var school = TopSellerSchool.fromJson(e);
        school.color = AppColors.getContentColor(i);
        result.add(school);
      }
    }
    return result;
  }

  Future<List<OrderStatistic>> getOrderStatistics(
      DateTime startDate, DateTime endDate,
      {int status = -1}) async {
    final response = await _apiService.request.get(
        "orders/countByMonth?startDate=${DateFormat('yyyy-MM-dd').format(startDate)}&endDate=${DateFormat('yyyy-MM-dd').format(endDate)}${status == -1 ? '' : '&status=$status'}");
    List<OrderStatistic> result = [];
    if (response.statusCode == 200) {
      for (var e in response.data['data']) {
        result.add(OrderStatistic.fromJson(e));
      }
    }
    return result;
  }

  Future<List<OrderStatisticByDays>> getOrderStatisticsByDays() async {
    final response =
        await _apiService.request.get("/orders/countByDay?dateCount=7");
    List<OrderStatisticByDays> result = [];
    if (response.statusCode == 200) {
      for (var e in response.data['data']) {
        result.add(OrderStatisticByDays.fromJson(e));
      }
    }
    return result;
  }
}
