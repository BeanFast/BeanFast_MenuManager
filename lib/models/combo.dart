import 'base_model.dart';
import 'food.dart';

class Combo extends BaseModel {
  String? masterFoodId;
  String? foodId;
  String? code;
  int? quantity;
  List<Food>? masterFoods;
  List<Food>? foods;

  Combo({
    id,
    status,
    this.masterFoodId,
    this.foodId,
    this.code,
    this.quantity,
  }) : super(id: id, status: status);

  factory Combo.fromJson(dynamic json) => Combo(
        id: json['id'],
        status: json['status'],
        masterFoodId: json["masterFoodId"],
        foodId: json["foodId"],
        code: json["code"],
        quantity: json["quantity"],
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
