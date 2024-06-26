import 'base_model.dart';
import 'food.dart';

class Category extends BaseModel {
  String? code;
  String? name;
  String? imagePath;
  List<Food>? foods;

  Category({
    id,
    status,
    this.code,
    this.name,
    this.imagePath,
  }) : super(id: id, status: status);

  factory Category.fromJson(dynamic json) => Category(
        status: json['status'],
        id: json['id'],
        code: json["code"],
        name: json["name"],
        imagePath: json['imagePath'],
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
