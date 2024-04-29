import 'base_model.dart';
import 'kitchen.dart';
import 'menu_detail.dart';
import 'session.dart';
import 'user.dart';

class Menu extends BaseModel {
  String? kitchenId;
  String? creatorId;
  String? updaterId;
  String? code;
  DateTime? createDate;
  DateTime? updateDate;
  User? creator;
  User? updater;
  Kitchen? kitchen;
  List<Session>? schools;
  List<MenuDetail>? menuDetails;

  Menu({
    id,
    status,
    this.kitchen,
    this.kitchenId,
    this.creatorId,
    this.updaterId,
    this.code,
    this.createDate,
    this.updateDate,
    this.menuDetails,
  }) : super(id: id, status: status);

  factory Menu.fromJson(dynamic json) {
    return Menu(
      id: json['id'],
      status: json['status'],
      kitchenId: json["kitchenId"],
      kitchen:
          json["kitchen"] != null ? Kitchen.fromJson(json["kitchen"]) : null,
      creatorId: json['creatorId'],
      updaterId: json['updaterId'],
      code: json['code'],
      createDate: json['createDate'] == null
          ? null
          : DateTime.parse(json['createDate']),
      updateDate: json['updateDate'] == null
          ? null
          : DateTime.parse(json['updateDate']),
      menuDetails: json['menuDetails']?.map<MenuDetail>((item) {
        return MenuDetail.fromJson(item);
      }).toList(),
    );
  }

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
