import 'base_model.dart';
import 'kitchen.dart';
import 'menu_detail.dart';
import 'session.dart';
import 'user.dart';

class Menu extends BaseModel {
  String? kitchenId;
  String? createrId;
  String? updaterId;
  String? code;
  DateTime? createDate;
  DateTime? updateDate;
  User? creater;
  User? updater;
  Kitchen? kitchen;
  List<Session>? schools;
  List<MenuDetail>? menus;

  Menu({
    id,
    status,
    this.kitchenId,
    this.createrId,
    this.updaterId,
    this.code,
    this.createDate,
    this.updateDate,
  }) : super(id: id, status: status);

  factory Menu.fromJson(dynamic json) => Menu(
        id: json['id'],
        status: json['status'],
        kitchenId: json["kitchenId"],
        createrId: json['createrId'],
        updaterId: json['updaterId'],
        code: json['code'],
        createDate: DateTime.parse(json['createDate']),
        updateDate: DateTime.parse(json['updateDate']),
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
