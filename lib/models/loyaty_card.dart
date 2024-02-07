import 'base_model.dart';
import 'card_type.dart';
import 'profile.dart';

class LoyaltyCard extends BaseModel {
  String? profileId;
  String? cardTypeId;
  String? code;
  String? title;
  String? qRCode;
  String? backgroundImagePath;
  Profile? profile;
  CardType? cardType;

  LoyaltyCard({
    id,
    status,
    this.profileId,
    this.cardTypeId,
    this.code,
    this.title,
    this.qRCode,
    this.backgroundImagePath,
  }) : super(id: id, status: status);

  factory LoyaltyCard.fromJson(dynamic json) => LoyaltyCard(
        id: json["id"],
        status: json['status'],
        profileId: json['profileId'],
        cardTypeId: json['cardTypeId'],
        code: json['code'],
        title: json['title'],
        qRCode: json['qRCode'],
        backgroundImagePath: json['backgroundImagePath'],
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
