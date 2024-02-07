import 'base_model.dart';
import 'order_activity.dart';
import 'order_detail.dart';
import 'profile.dart';
import 'session_detail.dart';
import 'transaction.dart';

class Order extends BaseModel {
  String? sessionDetailId;
  String? profileId;
  String? code;
  double? totalPrice;
  DateTime? paymentDate;
  DateTime? deliveryDate;
  int? rewardPoints;
  String? feedback;
  SessionDetail? sessionDetail;
  Profile? profile;
  List<OrderDetail>? orderDetails;
  List<Transaction>? transactions;
  List<OrderActivity>? orderActivities;

  Order({
    id,
    status,
    this.sessionDetailId,
    this.profileId,
    this.code,
    this.totalPrice,
    this.paymentDate,
    this.deliveryDate,
    this.rewardPoints,
    this.feedback,
  }) : super(id: id, status: status);

  factory Order.fromJson(dynamic json) => Order(
        id: json['id'],
        status: json['status'],
        sessionDetailId: json["sessionDetailId"],
        profileId: json['profileId'],
        code: json['code'],
        totalPrice: json['totalPrice'],
        paymentDate: DateTime.parse(json['paymentDate']),
        deliveryDate: DateTime.parse(json['deliveryDate']),
        rewardPoints: json['rewardPoints'],
        feedback: json['feedback'],
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
