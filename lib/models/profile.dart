import 'base_model.dart';
import 'exchange_gift.dart';
import 'order.dart';
import 'school.dart';
import 'user.dart';
import 'wallet.dart';
import 'loyaty_card.dart';

class Profile extends BaseModel {
  String? userId;
  String? schoolId;
  String? code;
  String? fullName;
  bool? gender;
  String? nickName;
  String? avatarPath;
  DateTime? dob;
  String? className;
  double? currentBMI;
  User? user;
  School? school;
  List<Wallet>? wallets;
  List<Order>? orders;
  List<ExchangeGift>? exchangeGifts;
  List<LoyaltyCard>? loyaltyCards;

  Profile({
    id,
    status,
    this.userId,
    this.schoolId,
    this.code,
    this.fullName,
    this.gender,
    this.nickName,
    this.avatarPath,
    this.dob,
    this.className,
    this.currentBMI,
  }) : super(id: id, status: status);

  factory Profile.fromJson(dynamic json) => Profile(
        id: json["id"],
        status: json['status'],
        userId: json["userId"],
        schoolId: json['schoolId'],
        code: json['code'],
        fullName: json['fullName'],
        gender: json['gender'],
        nickName: json['nickName'],
        avatarPath: json['avatarPath'],
        dob: json['dob'],
        className: json['className'],
        currentBMI: json['currentBMI'],
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
