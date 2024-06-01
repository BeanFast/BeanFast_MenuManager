import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/contains/contrain.dart';
import '/models/menu_detail.dart';
import '/models/food.dart';
import '/services/food_service.dart';
import '/views/pages/menu_create_page.dart';
import '/services/menu_serivce.dart';
import 'paginated_data_table_controller.dart';

class MenuCreateController extends PaginatedDataTableController<Food> {
  //detail
  String currentCode = '';
  //popup create/update
  RxString imagePath = ''.obs;
  List<MenuDetail> menuDetails = <MenuDetail>[];
  RxList<DataRow> menuDetailRows = <DataRow>[].obs;
  final TextEditingController priceController = TextEditingController();

  RxMap<String, double> mapMenuDetails = <String, double>{}.obs;

  void updatePriceMenuDetail(String foodId, double newPrice) {}

  void addItemMenuDetails(String foodId, double price) {
    menuDetails.clear();
    mapMenuDetails.update(
      foodId,
      (value) => price,
      ifAbsent: () => price,
    );
    List<Food> list = [];
    list.addAll(dataList);
    for (var e in dataList) {
      if (mapMenuDetails.containsKey(e.id!)) {
        MenuDetail model = MenuDetail(price: mapMenuDetails[e.id], food: e);
        menuDetails.add(model);
        list.remove(e);
      }
    }
    setDataTable(list);
    setMenuDetailDataTable(menuDetails);
  }

  Future<void> createMenu() async {
    if (currentKitchen.value?.id == null) return;
    try {
      await MenuService().create(currentKitchen.value!.id!, mapMenuDetails);
      Get.back();
      Get.snackbar('Thông báo', 'Tạo thành công');
    } on DioException catch (e) {
      Get.snackbar('Lỗi', e.response!.data['message']);
    }
  }

  void removeItemMenuDetails(MenuDetail menuDetail) {
    mapMenuDetails.remove(menuDetail.food!.id);

    menuDetails.remove(menuDetail);
    // setDataTable(currentModelList);
    setMenuDetailDataTable(menuDetails);
  }

  @override
  void setDataTable(List<Food> list) {
    rows.value = list.map((dataMap) {
      return const MenuCreateView().setRow(dataMap);
    }).toList();
  }

  void setMenuDetailDataTable(List<MenuDetail> list) {
    menuDetailRows.value = list.map((dataMap) {
      return const MenuCreateView()
          .setMenuDetailRow(list.indexOf(dataMap), dataMap);
    }).toList();
  }

  @override
  Future fetchData() async {
    try {
      var data = await FoodService().getAll(null);
      dataList = data;
      setDataTable(dataList);
    } catch (e) {
      throw Exception(e);
    }
  }
}
