import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '/controllers/gift_service.dart';
import '/models/gift.dart';
import '/views/pages/gift_page.dart';
import '/controllers/data_table_controller.dart';

class GiftController extends DataTableController<Gift> {
  final GlobalKey<FormState> formCreateKey = GlobalKey<FormState>();
  RxString imagePath = ''.obs;
  final TextEditingController foodName = TextEditingController();
  final TextEditingController foodPrice = TextEditingController();
  // Rx<Category> categorySelected = Category().obs;
  // RxList<Category> listCategories = <Category>[].obs;
  RxList<String> messageErrors = <String>[].obs;

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

  @override
  Future getData(list) async {
    try {
      var data = await GiftService().getAll();
      initModelList.addAll(data);
    } on DioException catch (e) {
      message = e.response!.data['message'];
    }
  }

  @override
  Future loadPage(int page) {
    // TODO: implement loadPage
    throw UnimplementedError();
  }

  @override
  void setDataTable(List<Gift> list) {
    rows.value = list.map((dataMap) {
      return const GiftView().setRow(list.indexOf(dataMap), dataMap);
    }).toList();
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

  Future<void> initDialog() async {
    // imagePath.value = '';
    // foodName.text = '';
    // foodPrice.text = '';
    // listCategories.clear();
    // try {
    //   var data = await CategoryService().getAll();
    //   listCategories.addAll(data);
    //   categorySelected.value = listCategories[0];
    // } catch (e) {
    //   logger.e('FoodController: $e');
    // }
  }

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      imagePath.value = pickedFile.path;
    }
  }

  void submitForm() {
    // messageErrors.value = [];
    // model.value!.name = foodName.text;
    // model.value!.price = Formatter.formatPriceToDouble(foodPrice.text);
    // model.value!.categoryId = categorySelected.value.id;
    // model.value!.imagePath = imagePath.value;
    // model.value!.description = '';
    // if (formCreateKey.currentState!.validate() && imagePath.value.isNotEmpty) {
    //   try {
    //     // FoodService().create(food);
    //     Get.back();
    //   } catch (e) {
    //     throw Exception(e);
    //   }
    // } else {
    //   messageErrors.add('Thông tin chưa chính xác');
    // }
    // if (imagePath.value.isEmpty) messageErrors.add('Ảnh trống');
  }
}
