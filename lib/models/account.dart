import 'base_model.dart';

class Account extends BaseModel {
  String? accessToken;
  String? storeId;
  String? name;
  String? userName;
  String? userRole;
  String? picUrl;

  Account({
    id,
    status,
    required this.accessToken,
    required this.storeId,
    required this.name,
    required this.userName,
    required this.userRole,
    this.picUrl,
  }) : super(id: id, status: status);

  @override
  String toString() {
    return 'AccountDTO(uid: $id, uid: $storeId, name: $name, userName: $userName, userRole: $userRole, status: $status, picUrl: $picUrl)';
  }

  factory Account.fromJson(dynamic json) => Account(
      accessToken: json['accessToken'],
      id: json["id"],
      storeId: json["storeId"],
      name: json['name'],
      userName: json['username'] as String,
      userRole: json['role'],
      status: json['status'],
      picUrl: json['picUrl'] ?? "");

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
