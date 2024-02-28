import 'package:image_picker/image_picker.dart';

import '/models/menu.dart';
import '/services/init_data.dart';
import '/controllers/data_table_controller.dart';
import '/utils/logger.dart';
import '/views/pages/manage_menu_page.dart';

class ManageMenuController extends DataTableController<Menu> {
  @override
  void search(String value) {
    if (value == '') {
      setDataTable(initData);
    } else {
      var dataList = initData
          .where((e) =>
              e.code!.toLowerCase().contains(value.toLowerCase()))
          .toList();
      setDataTable(dataList);
    }
  }

  @override
  Future getData() async {
    logger.i('menu getData');
    // final apiDataList = await Api().getData();
    for (var e in apiDataMenuList) {
      initData.add(Menu.fromJson(e));
    }
  }

  @override
  void setDataTable(List<Menu> list) {
    rows.value = list.map((dataMap) {
      return const ManageMenuView().setRow(list.indexOf(dataMap), dataMap);
    }).toList();
  }

  void sortByCreateDate(int index) {
    columnIndex.value = index;
    columnAscending.value = !columnAscending.value;
    var dataList = initData;
    dataList.sort((a, b) => a.createDate!.compareTo(b.createDate!));
    if (!columnAscending.value) {
      dataList = dataList.reversed.toList();
    }
    setDataTable(dataList);
  }

  // Future<void> pickImage() async {
  //   final picker = ImagePicker();
  //   final pickedFile = await picker.pickImage(source: ImageSource.gallery);
  //   if (pickedFile != null) {
  //     imagePath.value = pickedFile.path;
  //   }
  // }
}
