import 'package:beanfast_menumanager/services/menu_serivce.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '/models/menu.dart';
import '/controllers/data_table_controller.dart';
import '/utils/logger.dart';
import '/views/pages/menu_page.dart';

class MenuController extends DataTableController<Menu> {
  //detail
  String currentCode = '';
  //popup create/update
  RxString imagePath = ''.obs;

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
    // final apiDataList = await Api().getData();
    final menuListResponse = await MenuService().getAll();
    for (var e in menuListResponse) {
      var menu = Menu.fromJson(e);
      for (var element in menu.menuDetails!) {
        if (element.food!.imagePath!.contains("Chưa có ảnh")) {
          element.food!.imagePath =
              "https://firebasestorage.googleapis.com/v0/b/framemates-9999.appspot.com/o/Food%2Fh%E1%BB%A7%20ti%E1%BA%BFu%20b%C3%B2%20kho.jpeg?alt=media&token=8ec2a2c9-826a-456e-9bdc-3cc49cbb2f8b";
        }
      }
      initModelList.add(menu);
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
