class Kitchen {
  String? id;
  String? areaId;
  String? code;
  String? name;
  String? address;
  String? imagePath;
  int? status;
  List<String>? schoolIds;
  List<String>? menuIds;

  Kitchen(
      {this.id,
      this.areaId,
      this.code,
      this.name,
      this.address,
      this.imagePath,
      this.status
      });

  @override
  String toString() {
    return 'Food(id: $id, areaId: $areaId, code: $code, name: $name, address: $address, imagePath: $imagePath, status: $status)';
  }

  factory Kitchen.fromJson(dynamic json) => Kitchen(
        id: json['id'],
        areaId: json["areaId"],
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
