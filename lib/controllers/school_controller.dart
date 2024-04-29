import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:get/get.dart';

import '/models/location.dart';
import '/models/area.dart';
import '/models/school.dart';
import '/views/pages/school_page.dart';
import '/services/school_service.dart';
import '/services/area_service.dart';
import 'data_table_controller.dart';

class SchoolController extends DataTableController<School> {
  //Form
  final GlobalKey<FormState> formCreateKey = GlobalKey<FormState>();
  final TextEditingController nameText = TextEditingController();
  final TextEditingController addressText = TextEditingController();
  RxList<DataRow> locationRows = <DataRow>[].obs;
  var selectedImageFile = Rxn<FilePickerResult>();
  RxList<Area> listArea = <Area>[].obs;
  RxList<Location> listLocation = <Location>[].obs;
  List<Area> listInitArea = [];
  Rx<Area?> selectedArea = Rx<Area?>(null);
  //location form
  final GlobalKey<FormState> formCreateLocationKey = GlobalKey<FormState>();
  final TextEditingController locationNameText = TextEditingController();
  final QuillController locationDescriptionText = QuillController.basic();
  var selectedLocationImageImageFile = Rxn<FilePickerResult>();

  Future submitForm() async {
    if (selectedImageFile.value == null) {
      Get.snackbar('Thất bại', 'Ảnh trống');
      return;
    }
    if (selectedArea.value == null) {
      Get.snackbar('Thất bại', 'Chưa có thông tin khu vực');
      return;
    }
    if (listLocation.isEmpty) {
      Get.snackbar('Thất bại', 'Chưa có thông tin cổng');
      return;
    }
    if (formCreateKey.currentState!.validate()) {
      School model = School();
      model.name = nameText.text.trim();
      model.address = addressText.text.trim();
      model.areaId = selectedArea.value!.id!;
      model.locations = listLocation;
      model.imageFile = selectedImageFile.value!;
      try {
        await SchoolService().create(model);
        Get.back();
        Get.snackbar('Thành công', '');
        refreshData();
      } on DioException catch (e) {
        if (e.response != null) {
          if (e.response!.data['message'] != null) {
            Get.snackbar('Lỗi', e.response!.data['message']);
            return;
          }
        }
        Get.snackbar('Lỗi', 'Tạo thất bại');
      }
    } else {
      Get.snackbar('Thát bại', 'Thông tin chưa chính xác');
    }
  }

  void addLocation() {
    if (selectedLocationImageImageFile.value == null) {
      Get.snackbar('Thất bại', 'Ảnh trống');
      return;
    }
    if (locationDescriptionText.document.toPlainText().trim().isEmpty) {
      Get.snackbar('Thất bại', 'Chưa có mô tả');
      return;
    }
    if (formCreateLocationKey.currentState!.validate()) {
      Location model = Location();
      model.imageFile = selectedLocationImageImageFile.value;
      model.name = locationNameText.text.trim();
      model.description = locationDescriptionText.document.toPlainText().trim();
      listLocation.add(model);

      locationNameText.clear();
      selectedLocationImageImageFile.value = null;
      locationDescriptionText.clear();
    } else {
      Get.snackbar('Thất bại', 'Thông tin chưa chính xác');
    }
    Get.back();
    setLocationDataTable(listLocation);
  }

  void removeLocation(int index) {
    listLocation.removeAt(index);
    setLocationDataTable(listLocation);
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

  Future<void> pickLocationImage() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: FileType.image);
    if (result != null) {
      selectedLocationImageImageFile.value = result;
    }
  }

  void selectArea(Area area) {
    selectedArea.value = area;
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

  @override
  Future getData(list) async {
    try {
      var data = await SchoolService().getAll();
      initModelList.addAll(data);
    } on DioException catch (e) {
      message = e.response!.data['message'];
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

  @override
  void setDataTable(List<School> list) {
    rows.value = list.map((dataMap) {
      return const SchoolView().setRow(list.indexOf(dataMap), dataMap);
    }).toList();
  }

  void setLocationDataTable(List<Location> list) {
    locationRows.value = list.map((dataMap) {
      return const SchoolView().setLocationRow(list.indexOf(dataMap), dataMap);
    }).toList();
  }

  @override
  Future loadPage(int page) {
    // TODO: implement loadPage
    throw UnimplementedError();
  }
}
