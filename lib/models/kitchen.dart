import 'package:beanfast_menumanager/models/area.dart';
import 'package:file_picker/file_picker.dart';

import 'base_model.dart';
import 'menu.dart';
import 'school.dart';

class Kitchen extends BaseModel {
  String? areaId;
  String? code;
  String? name;
  String? address;
  String? imagePath;
  List<School>? schools;
  List<Menu>? menus;
  Area? area;
  int? schoolCount;
  //image file
  FilePickerResult? imageFile;

  Kitchen({
    id,
    status,
    this.areaId,
    this.code,
    this.name,
    this.schoolCount,
    this.address,
    this.imagePath,
    this.area,
    this.imageFile,
  }) : super(id: id, status: status);

  factory Kitchen.fromJson(dynamic json) => Kitchen(
        id: json['id'],
        status: json['status'],
        areaId: json["areaId"],
        code: json['code'],
        name: json['name'],
        schoolCount: json['schoolCount'],
        address: json['address'],
        imagePath: json['imagePath'] ?? "",
        area: json['area'] == null ? Area() : Area.fromJson(json['area']),
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
