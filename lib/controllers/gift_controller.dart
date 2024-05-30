import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '/controllers/gift_service.dart';
import '/models/gift.dart';
import '/views/pages/gift_page.dart';
import 'paginated_data_table_controller.dart';

class GiftController extends PaginatedDataTableController<Gift> {
  final GlobalKey<FormState> formCreateKey = GlobalKey<FormState>();
  RxString imagePath = ''.obs;
  final TextEditingController foodName = TextEditingController();
  final TextEditingController foodPrice = TextEditingController();
  RxList<String> messageErrors = <String>[].obs;

 


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

   void search(String value) {
    if (value.isEmpty) {
      setDataTable(dataList);
    } else {
      var list = dataList
          .where((e) =>
              e.code!.toLowerCase().contains(value.toLowerCase()) ||
              e.name!.toLowerCase().contains(value.toLowerCase()))
          .toList();
      setDataTable(list);
    }
  }
  
  @override
  void setDataTable(List<Gift> list) {
    rows.value = list.map((dataMap) {
      return const GiftView().setRow(dataMap);
    }).toList();
  }
  
  @override
  Future fetchData() async {
    try {
      var data = await GiftService().getAll();
      dataList = data;
      setDataTable(dataList);
    } catch (e) {
      throw Exception(e);
    }
  }
}
