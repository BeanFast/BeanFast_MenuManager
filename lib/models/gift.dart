class Gift {
  String? id;
  String? code;
  String? name;
  int? point;
  int? inStock;
  String? imagePath;
  int? status;
  List<String>? exchangeGiftIds;

  Gift(
      {this.id,
      this.code,
      this.name,
      this.point,
      this.inStock,
      this.imagePath,
      this.status});

  @override
  String toString() {
    return 'Gift(id: $id, code: $code, name: $name, point: $point, inStock: $inStock, imagePath: $imagePath, status: $status)';
  }

  factory Gift.fromJson(dynamic json) => Gift(
        id: json['id'],
        code: json["code"],
        name: json['name'],
        point: json['point'],
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
