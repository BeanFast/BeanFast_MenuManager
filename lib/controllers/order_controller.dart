import 'package:get/get.dart';

import '/models/order.dart';
import '/services/init_data.dart';
import '/controllers/data_table_controller.dart';
import '/utils/logger.dart';
import '/views/pages/order_page.dart';

class OrderController extends DataTableController<Order> {
  RxBool headerCheckboxValue = false.obs;
  RxSet<String> selectedOrderIds = <String>{}.obs;
  RxBool showButtonOnHeader = false.obs;

  @override
  void search(String value) {
    if (value == '') {
      setDataTable(initModelList);
    } else {
      currentModelList = initModelList
          .where((e) => e.code!.toLowerCase().contains(value.toLowerCase()))
          .toList();
      setDataTable(currentModelList);
    }
  }

  @override
  Future getData(list) async {
    logger.i('Order getData');
    // final apiDataList = await Api().getData();
    for (var e in apiDataOrderList) {
      list.add(Order.fromJson(e));
    }
  }

  @override
  Future loadPage(int page) {
    // TODO: implement loadPage
    throw UnimplementedError();
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
    currentModelList.sort((a, b) => a.paymentDate!.compareTo(b.paymentDate!));
    if (!columnAscending.value) {
      currentModelList = currentModelList.reversed.toList();
    }
    setDataTable(currentModelList);
  }

  void sortByDeliveryDate(int index) {
    columnIndex.value = index;
    columnAscending.value = !columnAscending.value;
    currentModelList = initModelList;
    currentModelList.sort((a, b) => a.deliveryDate!.compareTo(b.deliveryDate!));
    if (!columnAscending.value) {
      currentModelList = currentModelList.reversed.toList();
    }
    setDataTable(currentModelList);
  }

// Order acctivity - start
  void toggleCheckbox(String id) {
    if (selectedOrderIds.contains(id)) {
      selectedOrderIds.remove(id);
    } else {
      selectedOrderIds.add(id);
    }
    updateHeaderCheckbox();
    updateShowButtonOnHeader();
  }

  void toggleHeaderCheckbox() {
    headerCheckboxValue.value = !headerCheckboxValue.value;
    if (headerCheckboxValue.value) {
      selectedOrderIds.addAll(initModelList.map((e) => e.id!));
    } else {
      selectedOrderIds.clear();
    }
    updateShowButtonOnHeader();
  }

  void updateHeaderCheckbox() {
    if (selectedOrderIds.length == initModelList.length) {
      headerCheckboxValue.value = true;
    } else {
      headerCheckboxValue.value = false;
    }
  }

  void updateShowButtonOnHeader() {
    showButtonOnHeader.value = selectedOrderIds.isNotEmpty;
  }
  
  
}
