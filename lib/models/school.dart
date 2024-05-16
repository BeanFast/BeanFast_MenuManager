import 'package:file_picker/file_picker.dart';

import 'base_model.dart';
import 'area.dart';
import 'kitchen.dart';
import 'location.dart';
import 'profile.dart';

class School extends BaseModel {
  String? areaId;
  String? kitchenId;
  String? code;
  String? name;
  String? address;
  String? imagePath;
  int? studentCount;
  bool? isOrderable;
  Area? area;
  Kitchen? kitchen;
  List<Profile>? profiles;
  List<Location>? locations;
  //image file
  FilePickerResult? imageFile;

  School({
    id,
    status,
    this.areaId,
    this.kitchenId,
    this.code,
    this.name,
    this.address,
    this.locations,
    this.imagePath,
    this.studentCount,
    this.isOrderable,
    this.area,
    this.imageFile,
  }) : super(id: id, status: status);

  factory School.fromJson(dynamic json) {
    return School(
      id: json['id'],
      status: json['status'],
      areaId: json["areaId"],
      kitchenId: json["kitchenId"],
      code: json['code'],
      name: json['name'],
      address: json['address'],
      locations: json['locations']?.map<Location>((item) {
        return Location.fromJson(item);
      }).toList(),
      imagePath: json['imagePath'] ?? "",
      studentCount: json['studentCount'] ?? 0,
      isOrderable: json['orderable'] ?? false,
      area: json['area'] == null ? Area() : Area.fromJson(json['area']),
    );
  }

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
