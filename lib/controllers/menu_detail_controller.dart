import '/services/init_data.dart';
import '/models/food.dart';
import '/controllers/data_table_controller.dart';
import '/views/pages/menu_detail_page.dart';

class MenuDetailController extends DataTableController<Food> {

  void sortFoodByName(int index) {
    columnIndex.value = index;
    columnAscending.value = !columnAscending.value;
    var dataList = initData;
    dataList.sort((a, b) => a.name!.compareTo(b.name!));
    if (!columnAscending.value) {
      dataList = dataList.reversed.toList();
    }
    setDataTable(dataList);
  }

  void sortFoodByPrice(int index) {
    columnIndex.value = index;
    columnAscending.value = !columnAscending.value;
    var dataList = initData;
    dataList.sort((a, b) => a.price!.compareTo(b.price!));
    if (!columnAscending.value) {
      dataList = dataList.reversed.toList();
    }
    setDataTable(dataList);
  }

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
    for (var e in apiDataFoodList) {
      initData.add(Food.fromJson(e));
    }
  }

  @override
  void setDataTable(List<Food> list) {
    rows.value = list.map((dataMap) {
      return const MenuDetailView().setFoodRow(list.indexOf(dataMap), dataMap);
    }).toList();
  }
}
