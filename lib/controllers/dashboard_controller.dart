import 'package:beanfast_menumanager/enums/status_enum.dart';
import 'package:beanfast_menumanager/services/dashboard_service.dart';
import 'package:beanfast_menumanager/services/food_service.dart';
import 'package:beanfast_menumanager/services/school_service.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DashboardController extends GetxController {
  Rx<DateTime> selectedDateEnd = DateTime.now().obs;
  Rx<String> selectedDateStrEnd =
      DateFormat('dd/MM/yyyy').format(DateTime.now()).obs;
  Rx<DateTime> selectedDateStart = DateTime(
          DateTime.now().year, DateTime.now().month - 3, DateTime.now().day)
      .obs;
  Rx<String> selectedDateStrStart = ''.obs;
  DashboardController() {
    selectedDateStrStart =
        DateFormat('dd/MM/yyyy').format(selectedDateStart.value).obs;
  }
  RxList<OrderStatistic> orderStatistics = <OrderStatistic>[].obs;
  RxList<OrderStatistic> completeOrderStatistics = <OrderStatistic>[].obs;
  RxList<OrderStatistic> cancelByCustomerOrderStatistics =
      <OrderStatistic>[].obs;
  RxList<OrderStatisticByDays> orderStatisticByDays =
      <OrderStatisticByDays>[].obs;
  RxList<BestSellerCategory> bestSellerCategory = <BestSellerCategory>[].obs;
  RxList<BestSellerFood> bestSellerFoods = <BestSellerFood>[].obs;
  RxList<TopSellerKitchen> topSellerKitchens = <TopSellerKitchen>[].obs;
  RxList<TopSellerSchool> topSellerSchools = <TopSellerSchool>[].obs;
  RxString totalRevenue = '0'.obs;
  RxString totalOrder = '0'.obs;
  RxString totalFood = '0'.obs;
  RxString totalSchool = '0'.obs;
  Future getBestSellerFoods() async {
    DashboardService().getBestSellerFoods().then((value) {
      bestSellerFoods.value = value;
    });
  }

  Future getTotalFoodCount() async {
    FoodService().getAll(null).then((value) {
      totalFood.value = value.length.toString();
    });
  }

  Future getTotalSchoolCount() async {
    SchoolService().getAll().then((value) {
      totalSchool.value = value.length.toString();
    });
  }

  Future<List<TopSellerKitchen>> getTopSellerKitchens() async {
    var dashboardService = DashboardService();
    var result = await dashboardService.getTopSellerKitchens(4);
    topSellerKitchens.value = result;
    return result;
  }

  Future<List<TopSellerSchool>> getTopSellerSchools() async {
    var dashboardService = DashboardService();
    var result = await dashboardService.getTopSellerSchools(4);
    topSellerSchools.value = result;
    return result;
  }

  Future getBestSellerCategories() async {
    DashboardService().getBestSellerCategories().then((value) {
      bestSellerCategory.value = value;
    });
  }

  Future getOrderStatisticsByDays() async {
    DashboardService().getOrderStatisticsByDays().then((value) {
      orderStatisticByDays.value = value;
    });
  }

  Future getOrderStatistics() async {
    var dashboardService = DashboardService();
    var startDate = selectedDateStart.value;
    var endDate = selectedDateEnd.value;
    dashboardService
        .getOrderStatistics(startDate, endDate,
            status: OrderStatus.completed.code)
        .then((value) {
      completeOrderStatistics.value = value;
      int revenue = 0;
      int orderCount = 0;
      for (var os in value) {
        revenue += os.revenue;
        orderCount += os.count;
      }
      totalRevenue.value = revenue.toString();
      totalOrder.value = orderCount.toString();
    });
    dashboardService.getOrderStatistics(startDate, endDate).then((value) {
      orderStatistics.value = value;
    });
    dashboardService
        .getOrderStatistics(startDate, endDate,
            status: OrderStatus.cancelled.code)
        .then((value) {
      cancelByCustomerOrderStatistics.value = value;
    });
  }
}
