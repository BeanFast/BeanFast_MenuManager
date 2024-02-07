import 'base_model.dart';
import 'menu.dart';
import 'session_detail.dart';

class Session extends BaseModel {
  String? menuId;
  String? code;
  DateTime? orderStartTime;
  DateTime? orderEndTime;
  DateTime? deliveryStartTime;
  DateTime? deliveryEndTime;
  Menu? menu;
  List<SessionDetail>? sessionDetail;

  Session({
    id,
    status,
    this.menuId,
    this.code,
    this.orderStartTime,
    this.orderEndTime,
    this.deliveryStartTime,
    this.deliveryEndTime,
  }) : super(id: id, status: status);

  factory Session.fromJson(dynamic json) => Session(
        id: json["id"],
        status: json['status'],
        menuId: json["menuId"],
        code: json['code'],
        orderStartTime: json['orderStartTime'],
        orderEndTime: json['orderEndTime'],
        deliveryStartTime: json['deliveryStartTime'],
        deliveryEndTime: json['deliveryEndTime'],
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
