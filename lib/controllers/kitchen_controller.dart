import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/area.dart';
import '../services/area_service.dart';
import '/services/kitchen_service.dart';
import '/utils/logger.dart';
import '/views/pages/kitchen_page.dart';
import '/models/kitchen.dart';
import 'data_table_controller.dart';

class KitchenController extends DataTableController<Kitchen> {
  RxList<Area> listArea = <Area>[].obs;
  List<Area> listInitArea = [];
  //Form
  final GlobalKey<FormState> formCreateKey = GlobalKey<FormState>();
  final TextEditingController nameText = TextEditingController();
  final TextEditingController addressText = TextEditingController();
  Rx<Area?> selectedArea = Rx<Area?>(null);
  var selectedImageFile = Rxn<FilePickerResult>();

  Future submitForm() async {
    if (selectedImageFile.value == null) {
      Get.snackbar('Thất bại', 'Ảnh trống');
      return;
    }
    if (selectedArea.value == null) {
      Get.snackbar('Thất bại', 'Chưa có thông tin khu vực');
      return;
    }
    if (formCreateKey.currentState!.validate()) {
      Kitchen model = Kitchen();
      model.name = nameText.text;
      model.address = addressText.text;
      model.areaId = selectedArea.value!.id!;
      model.imageFile = selectedImageFile.value!;
      try {
        await KitchenService().create(model);
        Get.back();
        Get.snackbar('Thành công', '');
        refreshData();
      } on DioException catch (e) {
        Get.snackbar('Lỗi', e.response!.data['title']);
      }
    } else {
      Get.snackbar('Thát bại', 'Thông tin chưa chính xác');
    }
  }

  @override
  void search(String value) {
    if (value.isEmpty) {
      setDataTable(initModelList);
    } else {
      currentModelList = initModelList
          .where((e) =>
              e.code!.toLowerCase().contains(value.toLowerCase()) ||
              e.name!.toLowerCase().contains(value.toLowerCase()))
          .toList();
      setDataTable(currentModelList);
    }
  }

  void sortByName(int index) {
    columnIndex.value = index;
    columnAscending.value = !columnAscending.value;
    currentModelList.sort((a, b) => a.name!.compareTo(b.name!));
    if (!columnAscending.value) {
      currentModelList = currentModelList.reversed.toList();
    }
    setDataTable(currentModelList);
  }

  Future<void> pickImage() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: FileType.image);
    if (result != null) {
      selectedImageFile.value = result;
    }
  }

  void searchArea(String value) {
    listArea.clear();
    if (value.isEmpty) {
      listArea.addAll(listInitArea);
    } else {
      listArea.value = listInitArea
          .where((e) =>
              e.ward!.toLowerCase().contains(value.toLowerCase()) ||
              e.district!.toLowerCase().contains(value.toLowerCase()) ||
              e.city!.toLowerCase().contains(value.toLowerCase()))
          .toList();
    }
  }

  Future getAllArea() async {
    listArea.clear();
    try {
      var data = await AreaService().getAll();
      listInitArea = data;
      listArea.addAll(listInitArea);
    } on DioException catch (e) {
      message = e.response!.data['message'];
    }
  }

  void selectArea(Area area) {
    selectedArea.value = area;
  }

  @override
  Future getData(list) async {
    final apiDataList = await KitchenService().getAll();
    logger.i('kitchen getData');
    for (var e in apiDataList) {
      initModelList.add(e);
    }
  }

  @override
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
}
