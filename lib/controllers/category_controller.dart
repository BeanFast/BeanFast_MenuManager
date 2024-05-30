import '/models/category.dart';
import '/services/category_service.dart';
import '/views/pages/category_page.dart';
import 'paginated_data_table_controller.dart';

class CategoryController extends PaginatedDataTableController<Category> {
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
  void setDataTable(List<Category> list) {
    rows.value = list.map((dataMap) {
      return const CategoryView().setRow(dataMap);
    }).toList();
  }

  @override
  Future fetchData() async {
    try {
      var data = await CategoryService().getAll();
      dataList = data;
      setDataTable(dataList);
    } catch (e) {
      throw Exception(e);
    }
  }
}
