import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '/models/menu.dart';
import '/models/school.dart';
import '/models/session.dart';
import '/models/user.dart';
import '/services/menu_serivce.dart';
import '/services/school_service.dart';
import '/services/session_service.dart';

class SessionCreatedController extends GetxController {
  var selectedMenuId = ''.obs;
  String schoolId = '';
  Rxn<DateTime> orderStartTime = Rxn<DateTime>();
  Rxn<DateTime> orderEndTime = Rxn<DateTime>();
  Rxn<DateTime> deliveryStartTime = Rxn<DateTime>();
  Rxn<DateTime> deliveryEndTime = Rxn<DateTime>();

  void updateSelectedValue(String value) {
    selectedMenuId.value = value;
  }

  var deliverers = <User>[].obs;
  RxList<Menu> listMenu = <Menu>[].obs;
  Rx<School> school = School().obs;

  var selectedDeliverers = <String, User>{}.obs; // session detail : deliverer

  Future freshData() async {
    try {
      listMenu.value = await MenuService().getBySchoolId(schoolId);
      school.value = await SchoolService().getById(schoolId);
    } on DioException catch (e) {
      Get.snackbar('Lỗi', e.message.toString());
    }
  }

  Future getDeliverers() async {
    if (deliveryStartTime.value == null || deliveryEndTime.value == null) {
      Get.snackbar('Hệ thống', 'Thời gian giao hàng còn trống');
      return;
    }
    try {
      var data = await SessionService().getListDelivererByDeliveryDate(
          deliveryStartTime.value!, deliveryEndTime.value!);
      selectedDeliverers.forEach((key, value) {
        data.removeWhere((e) => e.id == value.id);
      });
      deliverers.value = data;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> createSession() async {
    if (selectedMenuId.value == '') {
      Get.snackbar('Thất bại', 'Chưa có menu');
      return;
    }
    if (orderStartTime.value == null ||
        orderEndTime.value == null ||
        deliveryStartTime.value == null ||
        deliveryEndTime.value == null) {
      Get.snackbar('Hệ thống', 'Thời gian còn trống');
      return;
    }
    if (orderStartTime.value!.isAfter(orderEndTime.value!)) {
      Get.snackbar('Thất bại', 'Thời gian đặt hàng không hợp lệ');
      return;
    }
    if (deliveryStartTime.value!.isAfter(deliveryEndTime.value!)) {
      Get.snackbar('Thất bại', 'Thời gian giao hàng không hợp lệ');
      return;
    }
    if (orderEndTime.value!
        .add(const Duration(hours: 6))
        .isAfter(deliveryStartTime.value!)) {
      Get.snackbar('Thất bại', 'Thời gian đặt hàng phải sao giao hàng 6 giờ');
      return;
    }
    Map<String, User> deliverers = selectedDeliverers;
    Session session = Session(
      menuId: selectedMenuId.value,
      orderStartTime: orderStartTime.value,
      orderEndTime: orderEndTime.value,
      deliveryStartTime: deliveryStartTime.value,
      deliveryEndTime: deliveryEndTime.value,
    );
    try {
      await SessionService().createSession(session, deliverers);
      Get.back();
      Get.snackbar('Thông báo', 'Tạo thành công');
      await freshData();
    } on DioException catch (e) {
      if (e.response?.data['message'] == null) {
        Get.snackbar('Lỗi', e.message.toString());
      } else {
        Get.snackbar('Lỗi', e.response?.data['message']);
      }
    }
  }
}
