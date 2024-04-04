import 'base_model.dart';
import 'exchange_gift.dart';
import 'order.dart';

class OrderActivity extends BaseModel {
  String? orderId;
  String? exchangeGiftId;
  String? code;
  String? name;
  DateTime? time;
  String? imagePath;
  Order? order;
  ExchangeGift? exchangeGift;

  OrderActivity({
    id,
    status,
    this.orderId,
    this.exchangeGiftId,
    this.code,
    this.name,
    this.time,
    this.imagePath,
  }) : super(id: id, status: status);

  factory OrderActivity.fromJson(dynamic json) => OrderActivity(
        id: json["id"],
        status: json['status'],
        orderId: json["orderId"],
        exchangeGiftId: json['exchangeGiftId'],
        code: json['code'],
        name: json['name'],
        time: DateTime.parse(json['time']),
        imagePath: json['imagePath'],
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
