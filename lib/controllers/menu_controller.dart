import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '/services/menu_serivce.dart';
import '/models/kitchen.dart';
import '/models/menu.dart';
import '/views/pages/menu_page.dart';
import 'paginated_data_table_controller.dart';

class MenuController extends PaginatedDataTableController<Menu> {
  //detail
  String currentCode = '';
  //popup create/update
  RxString imagePath = ''.obs;
  RxList<Kitchen> listKitchen = <Kitchen>[].obs;

  @override
  void setDataTable(List<Menu> list) {
    rows.value = list.map((dataMap) {
      return const MenuView().setRow(dataMap);
    }).toList();
  }

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      imagePath.value = pickedFile.path;
    }
  }

  @override
  Future fetchData() async {
    try {
      var data = await MenuService().getAll();
      dataList = data;
      setDataTable(dataList);
    } catch (e) {
      throw Exception(e);
    }
  }
}
