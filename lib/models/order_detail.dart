import 'base_model.dart';
import 'food.dart';
import 'order.dart';

class OrderDetail extends BaseModel {
  String? orderId;
  String? foodId;
  int? quantity;
  double? price;
  String? note;
  Order? order;
  Food? food;

  OrderDetail({
    id,
    status,
    this.orderId,
    this.foodId,
    this.quantity,
    this.price,
    this.note,
  }) : super(id: id, status: status);

  factory OrderDetail.fromJson(dynamic json) => OrderDetail(
        id: json['id'],
        status: json['status'],
        orderId: json["orderId"],
        foodId: json["foodId"],
        quantity: json['quantity'],
        price: double.parse(json['price'].toString()),
        note: json['note'],
      );

  // Map<String, dynamic> toJson() {
  //   return {
  //     "accessToken": accessToken.toString(),
  //     "id": id.toString(),
  //     "storeId": storeId.toString(),
  //     "name": name,
  //     "username": userName,
  //     "role": userRole,
  //     "status": status,
  //     "picUrl": picUrl ?? "",
  //   };
  // }
}
