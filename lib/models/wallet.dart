import 'base_model.dart';
import 'user.dart';
import 'profile.dart';
import 'transaction.dart';

class Wallet extends BaseModel {
  String? userId;
  String? profileId;
  String? code;
  String? name;
  String? type;
  double? balance;
  User? user;
  Profile? profile;
  List<Transaction>? transactions;

  Wallet({
    id,
    status,
    this.userId,
    this.profileId,
    this.code,
    this.name,
    this.type,
    this.balance,
  }) : super(id: id, status: status);

  factory Wallet.fromJson(dynamic json) => Wallet(
        id: json["id"],
        status: json['status'],
        userId: json["userId"],
        profileId: json['profileId'],
        code: json['code'],
        name: json['name'],
        type: json['type'],
        balance: json['balance'],
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
