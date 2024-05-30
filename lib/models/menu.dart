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
      createDate: json['createdDate'] == null
          ? null
          : DateTime.parse(json['createdDate']),
      updateDate: json['updatedDate'] == null
          ? null
          : DateTime.parse(json['updatedDate']),
      menuDetails: json['menuDetails']?.map<MenuDetail>((item) {
        return MenuDetail.fromJson(item);
      }).toList(),
    );
  }
}
