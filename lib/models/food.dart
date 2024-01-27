class Food {
  String? id;
  String? categoryId;
  String? code;
  String? name;
  double? price;
  String? description;
  bool? isCombo;
  String? imagePath;
  int? status;
  // List<String>? collectionIds;
  // List<String>? extraCategoryIds;

  Food(
      {this.id,
      this.categoryId,
      this.code,
      this.name,
      this.price,
      this.description,
      this.isCombo,
      this.imagePath,
      this.status});

  @override
  String toString() {
    return 'Food(id: $id, categoryId: $categoryId, code: $code, name: $name, price: $price, description: $description, isCombo: $isCombo, isCombo: $isCombo, imagePath: $imagePath, status: $status)';
  }

  factory Food.fromJson(dynamic json) => Food(
        id: json['id'],
        categoryId: json["categoryId"],
        code: json["code"],
        name: json['name'],
        price: json['price'],
        description: json['description'],
        isCombo: json['isCombo'],
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
