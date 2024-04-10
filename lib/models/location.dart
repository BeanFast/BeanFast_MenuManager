import 'base_model.dart';
import 'profile.dart';
import 'school.dart';
import 'session_detail.dart';

class Location extends BaseModel {
  String? schoolId;
  String? code;
  String? name;
  String? description;
  String? imagePath;
  Profile? profile;
  School? school;
  List<SessionDetail>? sessionDetails;

  Location({
    id,
    status,
    this.schoolId,
    this.code,
    this.name,
    this.description,
    this.imagePath,
    this.school,
  }) : super(id: id, status: status);

  factory Location.fromJson(dynamic json) => Location(
        id: json["id"],
        status: json['status'],
        schoolId: json['schoolId'],
        code: json['code'],
        name: json['name'],
        description: json['description'],
        imagePath: json['imagePath'],
        school:
            json['school'] == null ? School() : School.fromJson(json['school']),
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
