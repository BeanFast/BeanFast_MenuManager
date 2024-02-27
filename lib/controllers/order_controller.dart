import 'package:image_picker/image_picker.dart';

import '/models/order.dart';
import '/services/init_data.dart';
import '/controllers/data_table_controller.dart';
import '/utils/logger.dart';
import '/views/pages/order_page.dart';

class OrderController extends DataTableController<Order> {

  //detail
  String currentCode = '';

  @override
  void search(String value) {
    if (value == '') {
      setDataTable(initData);
    } else {
      dataList = initData
          .where((e) =>
              e.code!.toLowerCase().contains(value.toLowerCase()))
          .toList();
      setDataTable(dataList);
    }
  }

  @override
  void getData(List<Order> list) async {
    logger.i('Order getData');
    // final apiDataList = await Api().getData();
    for (var e in apiDataOrderList) {
      list.add(Order.fromJson(e));
    }
  }

  @override
  void setDataTable(List<Order> list) {
    rows.value = list.map((dataMap) {
      return const OrderView().setRow(list.indexOf(dataMap), dataMap);
    }).toList();
  }

  void sortByPaymentDate(int index) {
    columnIndex.value = index;
    columnAscending.value = !columnAscending.value;
    dataList.sort((a, b) => a.paymentDate!.compareTo(b.paymentDate!));
    if (!columnAscending.value) {
      dataList = dataList.reversed.toList();
    }
    setDataTable(dataList);
  }
  
  void sortByDeliveryDate(int index) {
    columnIndex.value = index;
    columnAscending.value = !columnAscending.value;
    dataList.sort((a, b) => a.deliveryDate!.compareTo(b.deliveryDate!));
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
