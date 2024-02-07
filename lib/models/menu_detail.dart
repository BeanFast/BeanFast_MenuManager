import 'package:beanfast_menumanager/models/loyaty_card.dart';

import 'base_model.dart';

class MenuDetail extends BaseModel {
  String? foodId;
  String? menuId;
  String? code;
  double? price;
  List<LoyaltyCard>? loyaltyCards;

  MenuDetail({
    id,
    status,
    this.foodId,
    this.menuId,
    this.code,
    this.price,
  }) : super(id: id, status: status);

  factory MenuDetail.fromJson(dynamic json) => MenuDetail(
        id: json["id"],
        status: json['status'],
        foodId: json['foodId'],
        menuId: json['menuId'],
        code: json['code'],
        price: json['price'],
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
