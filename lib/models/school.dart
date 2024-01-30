class School {
  String? id;
  String? areaId;
  String? kitchenId;
  String? code;
  String? name;
  String? address;
  String? imagePath;
  int? status;
  List<String>? locationId;
  // List<String>? extraCategoryIds;

  School(
      {this.id,
      this.areaId,
      this.kitchenId,
      this.code,
      this.name,
      this.address,
      this.imagePath,
      this.status});

  @override
  String toString() {
    return 'Food(id: $id, areaId: $areaId, kitchenId: $kitchenId, code: $code, name: $name, address: $address, imagePath: $imagePath, status: $status)';
  }

  factory School.fromJson(dynamic json) => School(
        id: json['id'],
        areaId: json["areaId"],
        kitchenId: json["kitchenId"],
        code: json['code'],
        name: json['name'],
        address: json['address'],
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
