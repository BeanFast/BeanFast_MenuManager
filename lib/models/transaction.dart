import 'base_model.dart';
import 'order.dart';
import 'wallet.dart';
import 'exchange_gift.dart';

class Transaction extends BaseModel {
  String? orderId;
  String? exchangeGiftId;
  String? walletId;
  String? code;
  DateTime? time;
  double? value;
  Order? order;
  ExchangeGift? exchangeGift;
  Wallet? wallet;

  Transaction({
    id,
    status,
    this.orderId,
    this.exchangeGiftId,
    this.walletId,
    this.code,
    this.time,
    this.value,
  }) : super(id: id, status: status);

  factory Transaction.fromJson(dynamic json) => Transaction(
        id: json["id"],
        status: json['status'],
        orderId: json["orderId"],
        exchangeGiftId: json['exchangeGiftId'],
        walletId: json['walletId'],
        code: json['code'],
        time: json['time'],
        value: json['value'],
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
