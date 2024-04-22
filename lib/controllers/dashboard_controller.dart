import 'package:beanfast_menumanager/services/dashboard_service.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DashboardController extends GetxController {
  Rx<DateTime> selectedDateStart = DateTime.now().obs;
  Rx<String> selectedDateStrStart =
      DateFormat('dd-MM-yyyy').format(DateTime.now()).obs;
  RxList<OrderStatistic> orderStatistics = <OrderStatistic>[].obs;
  Rx<DateTime> selectedDateEnd = DateTime.now().obs;
  Rx<String> selectedDateStrEnd =
      DateFormat('dd-MM-yyyy').format(DateTime.now()).obs;
  RxList<BestSellerFood> bestSellerFoods = <BestSellerFood>[].obs;

  Future getBestSellerFoods() async {
    DashboardService().getBestSellerFoods().then((value) {
      bestSellerFoods.value = value;
    });
  }

  Future getOrderStatistics() async {
    DashboardService().getOrderStatistics().then((value) {
      orderStatistics.value = value;
      print(value);
    });
  }
}
