import 'base_model.dart';
import 'food.dart';
import 'menu.dart';

class MenuDetail extends BaseModel {
  String? foodId;
  String? menuId;
  String? code;
  double? price;
  Food? food;
  Menu? menu;

  MenuDetail(
      {id, status, this.foodId, this.menuId, this.code, this.price, this.food})
      : super(id: id, status: status);

  factory MenuDetail.fromJson(dynamic json) => MenuDetail(
        id: json["id"],
        status: json['status'],
        foodId: json['foodId'],
        menuId: json['menuId'],
        code: json['code'],
        price: double.parse(json['price'].toString()),
        food: Food.fromJson(json['food']),
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
