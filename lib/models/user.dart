import 'base_model.dart';

class User extends BaseModel {
  String? roleId;
  String? code;
  String? fullName;
  String? phone;
  String? email;
  String? avatarPath;

  User({
    id,
    status,
    this.roleId,
    this.code,
    this.fullName,
    this.phone,
    this.email,
    this.avatarPath,
  }) : super(id: id, status: status);

  factory User.fromJson(dynamic json) => User(
        id: json["id"],
        status: json['status'],
        roleId: json["roleId"],
        code: json['code'],
        fullName: json['fullName'],
        phone: json['phone'],
        email: json['email'],
        avatarPath: json['avatarPath'],
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
