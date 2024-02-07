import 'base_model.dart';
import 'kitchen.dart';
import 'school.dart';

class Area extends BaseModel {
  String? code;
  String? city;
  String? district;
  String? ward;
  List<School>? schools;
  List<Kitchen>? kitchens;

  Area({
    id,
    status,
    this.code,
    this.city,
    this.district,
    this.ward,
  }) : super(id: id, status: status);

  factory Area.fromJson(dynamic json) => Area(
        id: json['id'],
        code: json["code"],
        city: json["city"],
        district: json['district'],
        ward: json['ward'],
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
