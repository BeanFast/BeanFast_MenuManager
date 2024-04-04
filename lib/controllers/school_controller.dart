import 'package:beanfast_menumanager/services/school_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '/utils/logger.dart';
import '/models/school.dart';
import '/services/init_data.dart';
import '/views/pages/school_page.dart';
import 'data_table_controller.dart';

class SchoolController extends DataTableController<School> {
  TextEditingController searchController = TextEditingController();
  List<School> initData = <School>[];
  List<School> dataList = <School>[];
  RxList<DataRow> rows = <DataRow>[].obs;
  Rx<String> searchString = ''.obs;
  RxString imagePath = ''.obs;

  Rx<int> columnIndex = 0.obs;
  Rx<bool> columnAscending = true.obs;

  void searchName() {
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
    logger.i('school getData');
    final apiDataList = await SchoolService().getAll();
    for (var e in apiDataList) {
      initModelList.add(e);
    }
  }

  void setDataTable(List<School> list) {
    rows.value = list.map((dataMap) {
      return const SchoolView().setRow(list.indexOf(dataMap), dataMap);
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
