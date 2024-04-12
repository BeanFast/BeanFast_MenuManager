import 'package:beanfast_menumanager/services/order_service.dart';
import 'package:beanfast_menumanager/utils/logger.dart';
import 'package:get/get.dart';

import '../enums/status_enum.dart';
import '../views/pages/widget/order_cancelled_tabview.dart';
import '../views/pages/widget/order_completed_tabview.dart';
import '../views/pages/widget/order_delivering_tabview.dart';
import '../views/pages/widget/order_preparing_tabview.dart';
import '/controllers/data_table_controller.dart';
import '/models/order.dart';

abstract class OrderController extends DataTableController<Order> {
  OrderStatus status = OrderStatus.preparing;




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
    try {
      final data = await OrderService().getByStatus(status);
      list.addAll(data);
    } catch (e) {
      throw Exception(e);
    }
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

  void cancelOrder(String orderId) {
    logger.e('cancelOrder');
  }
}

class OrderPreparingController extends OrderController {
  RxBool headerCheckboxValue = false.obs;
  RxSet<String> selectedOrderIds = <String>{}.obs;
  RxBool showButtonOnHeader = false.obs;

  @override
  void setDataTable(List<Order> list) {
    rows.value = list.map((dataMap) {
      return const OrderPreparingTabView()
          .setRow(list.indexOf(dataMap), dataMap);
    }).toList();
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

  @override
  Future loadPage(int page) {
    // TODO: implement loadPage
    throw UnimplementedError();
  }
}

class OrderDeliveringController extends OrderController {
  @override
  void setDataTable(List<Order> list) {
    rows.value = list.map((dataMap) {
      return const OrderDeliveringTabView()
          .setRow(list.indexOf(dataMap), dataMap);
    }).toList();
  }

  @override
  Future loadPage(int page) {
    // TODO: implement loadPage
    throw UnimplementedError();
  }
}

class OrderCompletedController extends OrderController {
  @override
  void setDataTable(List<Order> list) {
    rows.value = list.map((dataMap) {
      return const OrderCompletedTabView()
          .setRow(list.indexOf(dataMap), dataMap);
    }).toList();
  }

  @override
  Future loadPage(int page) {
    // TODO: implement loadPage
    throw UnimplementedError();
  }
}

class OrderCancelledController extends OrderController {
  @override
  void setDataTable(List<Order> list) {
    rows.value = list.map((dataMap) {
      return const OrderCancelledTabView()
          .setRow(list.indexOf(dataMap), dataMap);
    }).toList();
  }

  @override
  Future loadPage(int page) {
    // TODO: implement loadPage
    throw UnimplementedError();
  }


}
