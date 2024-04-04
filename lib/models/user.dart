import 'base_model.dart';

class User extends BaseModel {
  String? roleId;
  String? code;
  String? fullName;
  String? phone;
  String? email;
  String? avatarPath;
  String? deviceToken;
  double? balance;

  User({
    id,
    status,
    this.roleId,
    this.code,
    this.fullName,
    this.phone,
    this.email,
    this.avatarPath,
    this.balance,
  }) : super(id: id, status: status);

  factory User.fromJson(dynamic json) {
    double balance = 0;
    if (json['balance'] != null) {
      balance = double.parse(json['balance'].toString());
    }
    return User(
      id: json["id"],
      status: json['status'],
      roleId: json["roleId"],
      code: json['code'],
      fullName: json['fullName'],
      phone: json['phone'],
      email: json['email'],
      avatarPath: json['avatarPath'],
      balance: balance,
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
