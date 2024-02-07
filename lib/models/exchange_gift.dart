import 'base_model.dart';
import 'profile.dart';
import 'gift.dart';
import 'transaction.dart';
import 'order_activity.dart';
import 'session_detail.dart';

class ExchangeGift extends BaseModel {
  String? profileId;
  String? sessionDetailId;
  String? giftId;
  String? code;
  int? points;
  DateTime? paymentDate;
  DateTime? deliveryDate;
  Profile? profile;
  SessionDetail? sessionDetail;
  Gift? gift;
  List<OrderActivity>? activities;
  List<Transaction>? transactions;

  ExchangeGift({
    id,
    status,
    this.profileId,
    this.sessionDetailId,
    this.giftId,
    this.code,
    this.points,
    this.paymentDate,
    this.deliveryDate,
  }) : super(id: id, status: status);

  factory ExchangeGift.fromJson(dynamic json) => ExchangeGift(
        id: json["id"],
        status: json['status'],
        profileId: json["profileId"],
        sessionDetailId: json['sessionDetailId'],
        giftId: json['giftId'],
        code: json['code'],
        points: json['points'],
        paymentDate: json['paymentDate'],
        deliveryDate: json['deliveryDate'],
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
