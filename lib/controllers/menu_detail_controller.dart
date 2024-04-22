import 'package:beanfast_menumanager/models/menu_detail.dart';
import 'package:beanfast_menumanager/services/menu_serivce.dart';
import 'package:get/get.dart';

import '/models/menu.dart';
import '/controllers/data_table_controller.dart';
import '/views/pages/menu_detail_page.dart';

class MenuDetailController extends DataTableController<MenuDetail> {
  Rx<Menu> menu = Menu().obs;

  void sortFoodByName(int index) {
    columnIndex.value = index;
    columnAscending.value = !columnAscending.value;
    var dataList = initModelList;
    dataList.sort((a, b) => a.food!.name!.compareTo(b.food!.name!));
    if (!columnAscending.value) {
      dataList = dataList.reversed.toList();
    }
    setDataTable(dataList);
  }

  void sortFoodByPrice(int index) {
    columnIndex.value = index;
    columnAscending.value = !columnAscending.value;
    var dataList = initModelList;
    dataList.sort((a, b) => a.price!.compareTo(b.price!));
    if (!columnAscending.value) {
      dataList = dataList.reversed.toList();
    }
    setDataTable(dataList);
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
    var menuCode = Get.parameters['code'];
    menu.value = await MenuService().getByCode(menuCode!);
    for (var e in menu.value.menuDetails!) {
      list.add(e);
    }
  }

  @override
  Future loadPage(int page) {
    // TODO: implement loadPage
    throw UnimplementedError();
  }

  @override
  void setDataTable(List<MenuDetail> list) {
    rows.value = list.map((dataMap) {
      return const MenuDetailView()
          .setMenuDetailRow(list.indexOf(dataMap), dataMap);
    }).toList();
  }
}
