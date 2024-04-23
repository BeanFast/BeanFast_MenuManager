import 'package:beanfast_menumanager/services/area_service.dart';
import 'package:beanfast_menumanager/services/school_service.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../models/area.dart';
import '/models/school.dart';
import '/views/pages/school_page.dart';
import 'data_table_controller.dart';

class SchoolController extends DataTableController<School> {
  RxString imagePath = ''.obs;
  RxList<Area> listArea = <Area>[].obs;
  List<Area> listInitArea = [];
  Rx<Area?> selectedArea = Rx<Area?>(null);
  
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
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      imagePath.value = pickedFile.path;
    }
  }

  void selectArea(Area area) {
    selectedArea.value = area;
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

  @override
  Future loadPage(int page) {
    // TODO: implement loadPage
    throw UnimplementedError();
  }
}
