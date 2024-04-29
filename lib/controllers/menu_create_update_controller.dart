import 'package:beanfast_menumanager/services/menu_serivce.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/models/menu_detail.dart';
import '/models/food.dart';
import '/services/food_service.dart';
import '/views/pages/menu_create_page.dart';
import '/controllers/data_table_controller.dart';
import '/utils/logger.dart';

String kitchenId = '';

class MenuCreateController extends DataTableController<Food> {
  //detail
  String currentCode = '';
  //popup create/update
  RxString imagePath = ''.obs;
  List<MenuDetail> menuDetails = <MenuDetail>[];
  RxList<DataRow> menuDetailRows = <DataRow>[].obs;
  final TextEditingController priceController = TextEditingController();

  RxMap<String, double> mapMenuDetails = <String, double>{}.obs;
  @override
  Future<void> refreshData() async {
    initModelList.clear();
    await getData(initModelList);
    currentModelList.clear();
    currentModelList.addAll(initModelList);
    for (var e in currentModelList) {
      if (mapMenuDetails.containsKey(e.id)) {
        currentModelList.remove(e);
      }
    }
    setDataTable(currentModelList);
  }

  void updatePriceMenuDetail(String foodId, double newPrice) {}

  void addItemMenuDetails(String foodId, double price) {
    menuDetails.clear();
    mapMenuDetails.update(
      foodId,
      (value) => price,
      ifAbsent: () => price,
    );
    for (var e in initModelList) {
      if (mapMenuDetails.containsKey(e.id!)) {
        MenuDetail model = MenuDetail(price: mapMenuDetails[e.id], food: e);
        menuDetails.add(model);
        currentModelList.remove(e);
      }
    }
    setDataTable(currentModelList);
    setMenuDetailDataTable(menuDetails);
  }

  Future<void> createMenu() async {
    if (kitchenId.isEmpty) return;
    try {
      var response = await MenuService().create(kitchenId, mapMenuDetails);
      if (response.statusCode == 200) {
        //show dialog success
        Get.back();
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  void removeItemMenuDetails(MenuDetail menuDetail) {
    mapMenuDetails.remove(menuDetail.food!.id);

    menuDetails.remove(menuDetail);
    setDataTable(currentModelList);
    setMenuDetailDataTable(menuDetails);
  }

  @override
  void search(String value) {
    if (value == '') {
      setDataTable(initModelList);
    } else {
      var dataList = initModelList
          .where((e) => e.code!.toLowerCase().contains(value.toLowerCase()))
          .toList();
      setDataTable(dataList);
    }
  }

  @override
  Future getData(list) async {
    logger.i('menu getData');
    try {
      var listData = await FoodService().getAll(null);
      list.addAll(listData);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future loadPage(int page) {
    // TODO: implement loadPage
    throw UnimplementedError();
  }

  @override
  void setDataTable(List<Food> list) {
    rows.value = list.map((dataMap) {
      return const MenuCreateView().setRow(list.indexOf(dataMap), dataMap);
    }).toList();
  }

  void setMenuDetailDataTable(List<MenuDetail> list) {
    menuDetailRows.value = list.map((dataMap) {
      return const MenuCreateView()
          .setMenuDetailRow(list.indexOf(dataMap), dataMap);
    }).toList();
  }

  // void sortByCreateDate(int index) {
  //   columnIndex.value = index;
  //   columnAscending.value = !columnAscending.value;
  //   var dataList = initModelList;
  //   dataList.sort((a, b) => a.createDate!.compareTo(b.createDate!));
  //   if (!columnAscending.value) {
  //     dataList = dataList.reversed.toList();
  //   }
  //   setDataTable(dataList);
  // }
}
