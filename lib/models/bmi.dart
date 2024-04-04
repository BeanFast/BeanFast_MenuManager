import 'base_model.dart';
import 'profile.dart';

class Bmi extends BaseModel {
  double? height;
  double? weight;
  int? age;
  DateTime? recordDate;
  Profile? profile;

  Bmi({
    id,
    status,
    this.height,
    this.weight,
    this.age,
    this.recordDate,
  }) : super(id: id, status: status);

  // factory Bmi.fromJson(dynamic json) => Bmi(
  //       id: json['id'],
  //       code: json["code"],
  //       city: json["city"],
  //       district: json['district'],
  //       ward: json['ward'],
  //       status: json['status'],
  //     );

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
