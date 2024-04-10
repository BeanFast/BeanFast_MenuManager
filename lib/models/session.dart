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
  List<SessionDetail>? sessionDetails;

  Session(
      {id,
      status,
      this.menuId,
      this.code,
      this.orderStartTime,
      this.orderEndTime,
      this.deliveryStartTime,
      this.deliveryEndTime,
      this.sessionDetails,
      this.menu})
      : super(id: id, status: status);

  factory Session.fromJson(dynamic json) => Session(
        id: json["id"],
        status: json['status'],
        menuId: json["menuId"],
        code: json['code'],
        orderStartTime: DateTime.parse(json['orderStartTime']),
        orderEndTime: DateTime.parse(json['orderEndTime']),
        deliveryStartTime: DateTime.parse(json['deliveryStartTime']),
        deliveryEndTime: DateTime.parse(json['deliveryEndTime']),
        sessionDetails: json['sessionDetails']?.map<SessionDetail>((item) {
          return SessionDetail.fromJson(item);
        }).toList(),
        menu: json['menu'] == null ? Menu() : Menu.fromJson(json['menu']),
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
