import 'base_model.dart';
import 'category.dart';
import 'combo.dart';
import 'menu_detail.dart';
import 'order_detail.dart';

class Food extends BaseModel {
  String? categoryId;
  String? code;
  String? name;
  double? price;
  String? description;
  bool? isCombo;
  String? imagePath;
  Category? category;
  List<OrderDetail>? orderDetails;
  List<Combo>? masterCombos;
  List<Combo>? combos;
  List<MenuDetail>? menuDetails;

  Food({
    id,
    status,
    this.categoryId,
    this.code,
    this.name,
    this.price,
    this.description,
    this.isCombo,
    this.imagePath,
    this.category,
  }) : super(id: id, status: status);

  @override
  String toString() {
    return 'Food(id: $id, categoryId: $categoryId, code: $code, name: $name, price: $price, description: $description, isCombo: $isCombo, isCombo: $isCombo, imagePath: $imagePath, status: $status)';
  }

  factory Food.fromJson(dynamic json) => Food(
      id: json['id'],
      status: json['status'],
      categoryId: json["categoryId"],
      code: json["code"],
      name: json['name'],
      price: double.parse(json['price'].toString()),
      description: json['description'],
      isCombo: json['isCombo'],
      imagePath: json['imagePath'] ??
          'https://firebasestorage.googleapis.com/v0/b/framemates-9999.appspot.com/o/Food%2Fh%E1%BB%A7%20ti%E1%BA%BFu%20b%C3%B2%20kho.jpeg?alt=media&token=8ec2a2c9-826a-456e-9bdc-3cc49cbb2f8b',
      category: Category.fromJson(json['category']));

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
