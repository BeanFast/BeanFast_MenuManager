import 'base_model.dart';
import 'exchange_gift.dart';
import 'location.dart';
import 'order.dart';
import 'session.dart';
import 'user.dart';

class SessionDetail extends BaseModel {
  String? locationId;
  String? sessionId;
  String? delivererId;
  String? code;
  Location? location;
  Session? session;
  User? user;
  List<Order>? orders;
  List<ExchangeGift>? exchangeGifts;

  SessionDetail({
    id,
    status,
    this.locationId,
    this.sessionId,
    this.delivererId,
    this.code,
  }) : super(id: id, status: status);

  factory SessionDetail.fromJson(dynamic json) => SessionDetail(
        id: json["id"],
        status: json['status'],
        locationId: json["locationId"],
        sessionId: json['sessionId'],
        delivererId: json['delivererId'],
        code: json['code'],
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
