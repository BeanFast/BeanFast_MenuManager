import 'base_model.dart';
import 'exchange_gift.dart';

class Gift extends BaseModel {
  String? code;
  String? name;
  int? point;
  int? inStock;
  String? imagePath;
  List<ExchangeGift>? exchangeGifts;

  Gift({
    id,
    status,
    this.code,
    this.name,
    this.point,
    this.inStock,
    this.imagePath,
  });

  @override
  String toString() {
    return 'Gift(id: $id, code: $code, name: $name, point: $point, inStock: $inStock, imagePath: $imagePath, status: $status)';
  }

  factory Gift.fromJson(dynamic json) => Gift(
        id: json['id'],
        code: json["code"],
        name: json['name'],
        point: json['points'],
        inStock: json['inStock'],
        imagePath: json['imagePath'] ?? "",
        status: json['status'],
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
