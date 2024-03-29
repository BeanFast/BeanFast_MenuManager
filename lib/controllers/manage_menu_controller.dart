import '/models/menu.dart';
import '/services/init_data.dart';
import '/controllers/data_table_controller.dart';
import '/utils/logger.dart';
import '/views/pages/manage_menu_page.dart';

class ManageMenuController extends DataTableController<Menu> {
  @override
  void search(String value) {
    if (value == '') {
      setDataTable(initModelList);
    } else {
      currentModelList = initModelList
          .where((e) =>
              e.code!.toLowerCase().contains(value.toLowerCase()))
          .toList();
      setDataTable(currentModelList);
    }
  }

  @override
  Future getData(list) async {
    logger.i('menu getData');
    // final apiDataList = await Api().getData();
    for (var e in apiDataMenuList) {
      initModelList.add(Menu.fromJson(e));
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
      return const ManageMenuView().setRow(list.indexOf(dataMap), dataMap);
    }).toList();
  }

  void sortByCreateDate(int index) {
    columnIndex.value = index;
    columnAscending.value = !columnAscending.value;
    currentModelList.sort((a, b) => a.createDate!.compareTo(b.createDate!));
    if (!columnAscending.value) {
      currentModelList = currentModelList.reversed.toList();
    }
    setDataTable(currentModelList);
  }
}
