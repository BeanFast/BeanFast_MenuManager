import 'package:beanfast_menumanager/services/kitchen_service.dart';
import 'package:beanfast_menumanager/utils/logger.dart';
import 'package:beanfast_menumanager/views/pages/kitchen_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '/models/kitchen.dart';
import '/services/init_data.dart';
import 'data_table_controller.dart';

class KitchenController extends DataTableController<Kitchen> {
  TextEditingController searchController = TextEditingController();
  List<Kitchen> initData = <Kitchen>[];
  List<Kitchen> dataList = <Kitchen>[];
  RxList<DataRow> rows = <DataRow>[].obs;
  Rx<String> searchString = ''.obs;
  RxString imagePath = ''.obs;

  Rx<String> a = 'a'.obs;

  Rx<int> columnIndex = 0.obs;
  Rx<bool> columnAscending = true.obs;

  void searchName() {
    logger.i('message');
    if (searchString.value == '') {
      setDataTable(initData);
    } else {
      dataList = initData
          .where((e) =>
              e.name!.toLowerCase().contains(searchString.value.toLowerCase()))
          .toList();
      setDataTable(dataList);
    }
  }

  void sortByName(int index) {
    columnIndex.value = index;
    columnAscending.value = !columnAscending.value;
    dataList.sort((a, b) => a.name!.compareTo(b.name!));
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

  @override
  Future getData(list) async {
    final apiDataList = await KitchenService().getAll();
    logger.i('kitchen getData');
    for (var e in apiDataList) {
      initModelList.add(e);
    }
  }

  void setDataTable(List<Kitchen> list) {
    rows.value = list.map((dataMap) {
      return const KitchenView().setRow(list.indexOf(dataMap), dataMap);
    }).toList();
  }

  @override
  Future loadPage(int page) {
    // TODO: implement loadPage
    throw UnimplementedError();
  }

  @override
  void search(String value) {
    // TODO: implement search
  }
}
