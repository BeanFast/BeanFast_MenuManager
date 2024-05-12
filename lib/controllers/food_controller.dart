import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:get/get.dart';

import '/models/combo.dart';
import '/utils/format_data.dart';
import '/models/food.dart';
import '/models/category.dart';
import '/views/pages/food_page.dart';
import '/services/food_service.dart';
import '/services/category_service.dart';
import 'paginated_data_table_controller.dart';

class FoodController extends PaginatedDataTableController<Food> {
  //Form
  final GlobalKey<FormState> formCreateKey = GlobalKey<FormState>();
  var selectedImageFile = Rxn<FilePickerResult>();
  RxList<DataRow> foodRows = <DataRow>[].obs;
  final TextEditingController nameText = TextEditingController();
  final TextEditingController priceText = TextEditingController();
  final TextEditingController quantiyText = TextEditingController();
  final QuillController descriptionText = QuillController.basic();
  RxList<Category> listCategory = <Category>[].obs;
  List<Category> listInitCategory = [];
  List<Food> listFood = [];
  List<Food> listInitFood = [];
  RxList<Food> listCombo = <Food>[].obs;
  Rx<Category?> selectedCategory = Rx<Category?>(null);
  RxMap<String, int> combos = <String, int>{}.obs;

  void clearForm() {
    nameText.clear();
    priceText.clear();
    descriptionText.clear();
    selectedCategory.value = null;
    combos.clear();
    listCategory.clear();
  }

  // @override
  // void search(String value) {
  //   if (value.isEmpty) {
  //     setDataTable(initModelList);
  //   } else {
  //     currentModelList = initModelList
  //         .where((e) =>
  //             e.code!.toLowerCase().contains(value.toLowerCase()) ||
  //             e.name!.toLowerCase().contains(value.toLowerCase()))
  //         .toList();
  //     setDataTable(currentModelList);
  //   }
  // }

  // void sortByName(int index) {
  //   sortColumnIndex.value = index;
  //   columnAscending.value = !columnAscending.value;
  //   currentModelList.sort((a, b) => a.name!.compareTo(b.name!));
  //   if (!columnAscending.value) {
  //     currentModelList = currentModelList.reversed.toList();
  //   }
  //   setDataTable(currentModelList);
  // }

  // void sortByPrice(int index) {
  //   columnIndex.value = index;
  //   columnAscending.value = !columnAscending.value;
  //   currentModelList.sort((a, b) => a.price!.compareTo(b.price!));
  //   if (!columnAscending.value) {
  //     currentModelList = currentModelList.reversed.toList();
  //   }
  //   setDataTable(currentModelList);
  // }

  Future getAllCategory() async {
    listCategory.clear();
    try {
      var data = await CategoryService().getAll();
      listInitCategory = data;
      listCategory.addAll(listInitCategory);
    }  catch (e) {
      throw Exception(e);
    }
  }

  void searchCategory(String value) {
    listCategory.clear();
    if (value.isEmpty) {
      listCategory.addAll(listInitCategory);
    } else {
      listCategory.value = listInitCategory
          .where((e) => e.name!.toLowerCase().contains(value.toLowerCase()))
          .toList();
    }
  }

  Future getAllFood() async {
    listFood.clear();
    try {
      var data = await FoodService().getAll(false);
      listInitFood = data;
      listFood.addAll(listInitFood);
      for (var c in combos.entries) {
        listFood.removeWhere((e) => e.id! == c.key);
      }
      setFoodDataTable(listFood);
    } catch (e) {
      throw Exception(e);
    }
  }

  void searchFood(String value) {
    listFood.clear();
    if (value.isEmpty) {
      listFood.addAll(listInitFood);
    } else {
      listFood = listInitFood
          .where((e) => e.name!.toLowerCase().contains(value.toLowerCase()))
          .toList();
      setFoodDataTable(listFood);
    }
  }

  void addFood(String id) {
    combos.putIfAbsent(id, () => 1);
    Food food = listInitFood.firstWhere((e) => e.id! == id);
    listCombo.add(food);
    listFood.remove(food);
    setFoodDataTable(listFood);
  }

  void updateFood(String id, int quantity) {
    if (quantity < 1) {
      return;
    }
    combos.update(id, (value) => quantity);
  }

  void removeFood(String id) {
    if (combos.containsKey(id)) {
      combos.remove(id);
      listCombo.removeWhere((e) => e.id == id);
    }
  }

  Future pickImage() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: FileType.image);
    if (result != null) {
      selectedImageFile.value = result;
    }
  }

  Future submitForm(bool isCombo) async {
    if (selectedImageFile.value == null) {
      Get.snackbar('Thất bại', 'Ảnh trống');
      return;
    }
    if (selectedCategory.value == null) {
      Get.snackbar('Thất bại', 'Chưa có thông tin loại');
      return;
    }
    if (isCombo && combos.isEmpty) {
      Get.snackbar('Thất bại', 'Combo chưa có thức ăn');
      return;
    }
    if (formCreateKey.currentState!.validate()) {
      try {
        Food model = Food(
          name: nameText.text.trim(),
          price: Formatter.formatPriceToDouble(priceText.text.trim()),
          categoryId: selectedCategory.value!.id,
          description: descriptionText.document.toPlainText().trim(),
          imageFile: selectedImageFile.value!,
        );
        if (isCombo) {
          List<Combo>? listCombo = [];
          for (var e in combos.entries) {
            Combo combo = Combo();
            combo.foodId = e.key;
            combo.quantity = e.value;
            listCombo.add(combo);
          }
          model.combos = listCombo;
        }
        await FoodService().create(model, isCombo);
        Get.back();
        Get.snackbar('Thành công', '');
        await fetchData();
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

  @override
  void setDataTable(List<Food> list) {
    rows.value = list.map((dataMap) {
      return const FoodView().setRow(dataMap);
    }).toList();
  }

  void setFoodDataTable(List<Food> list) {
    foodRows.value = list.map((dataMap) {
      return const FoodView().setFoodRow(list.indexOf(dataMap), dataMap);
    }).toList();
  }

  @override
  Future fetchData() async {
    try {
      var data = await FoodService().getAll(null);
      dataList = data;
      setDataTable(dataList);
    } catch (e) {
      throw Exception(e);
    }
  }
}
