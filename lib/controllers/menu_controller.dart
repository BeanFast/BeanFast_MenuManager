import 'package:beanfast_menumanager/services/kitchen_service.dart';
import 'package:beanfast_menumanager/services/menu_serivce.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../models/kitchen.dart';
import '/models/menu.dart';
import '/controllers/data_table_controller.dart';
import '/utils/logger.dart';
import '/views/pages/menu_page.dart';

class MenuController extends DataTableController<Menu> {
  //detail
  String currentCode = '';
  //popup create/update
  RxString imagePath = ''.obs;
  RxList<Kitchen> listKitchen = <Kitchen>[].obs;

  Future<void> getKitchens() async {
    // listKitchen.clear();
    try {
      listKitchen.value = await KitchenService().getAll();
    } catch (e) {
      throw Exception(e);
    }
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
      var listData = await MenuService().getAll();
      list.addAll(listData);
    } on DioException catch (e) {
      Get.snackbar('Lỗi', e.response!.data['message']);
    }
  }

  @override
  Future loadPage(int page) {
    // TODO: implement loadPage
    throw UnimplementedError();
  }

  @override
  void setDataTable(List<Menu> list) {
    rows.value = list.map((dataMap) {
      return const MenuView().setRow(list.indexOf(dataMap), dataMap);
    }).toList();
  }

  void sortByCreateDate(int index) {
    columnIndex.value = index;
    columnAscending.value = !columnAscending.value;
    var dataList = initModelList;
    dataList.sort((a, b) => a.createDate!.compareTo(b.createDate!));
    if (!columnAscending.value) {
      dataList = dataList.reversed.toList();
    }
    setDataTable(dataList);
  }

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      imagePath.value = pickedFile.path;
    }
  }
}
