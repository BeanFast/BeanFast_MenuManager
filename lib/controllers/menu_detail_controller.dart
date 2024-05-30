import 'package:get/get.dart';

import '/models/menu.dart';
import '/models/menu_detail.dart';
import '/services/menu_serivce.dart';
import '/views/pages/menu_detail_page.dart';
import 'paginated_data_table_controller.dart';

class MenuDetailController extends PaginatedDataTableController<MenuDetail> {
  Rx<Menu> menu = Menu().obs;

  @override
  void setDataTable(List<MenuDetail> list) {
    rows.value = list.map((dataMap) {
      return const MenuDetailView().setRow(dataMap);
    }).toList();
  }

  @override
  Future fetchData() async {
    var menuCode = Get.parameters['code'];
    try {
      menu.value = await MenuService().getByCode(menuCode!);
      setDataTable(menu.value.menuDetails!);
    } catch (e) {}
  }
}
