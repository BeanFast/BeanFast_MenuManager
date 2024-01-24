class Food {
  final String id;
  final String categoryId;
  final String code;
  final String name;
  final double price;
  final String description;
  final bool isCombo;
  final String imagePath;
  final int status;

  Food(
      {required this.id,
      required this.categoryId,
      required this.code,
      required this.name,
      required this.price,
      required this.description,
      required this.isCombo,
      required this.imagePath,
      required this.status});

  @override
  String toString() {
    return 'Food(id: $id, categoryId: $categoryId, code: $code, name: $name, price: $price, description: $description, isCombo: $isCombo, isCombo: $isCombo, imagePath: $imagePath, status: $status)';
  }

  // factory Food.fromJson(dynamic json) => Food(
  //     accessToken: json['accessToken'],
  //     id: json["id"],
  //     storeId: json["storeId"],
  //     name: json['name'],
  //     userName: json['username'] as String,
  //     userRole: json['role'],
  //     status: json['status'],
  //     picUrl: json['picUrl'] ?? "");

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
