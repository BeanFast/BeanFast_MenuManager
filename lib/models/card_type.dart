import 'base_model.dart';
import 'loyaty_card.dart';

class CardType extends BaseModel {
  String? code;
  String? name;
  double? height;
  double? width;
  String? backgroundImagePath;
  List<LoyaltyCard>? loyaltyCards;

  CardType({
    id,
    status,
    this.code,
    this.name,
    this.height,
    this.width,
    this.backgroundImagePath,
  }) : super(id: id, status: status);

  factory CardType.fromJson(dynamic json) => CardType(
        id: json["id"],
        status: json['status'],
        code: json['code'],
        name: json['name'],
        height: json['height'],
        width: json['width'],
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
