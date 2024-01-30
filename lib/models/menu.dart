class Menu {
  String? id;
  String? kitchenId;
  String? createrId;
  String? updaterId;
  String? code;
  DateTime? createDate;
  DateTime? updateDate;
  int? status;
  List<String>? schoolIds;
  List<String>? menuIds;

  Menu(
      {this.id,
      this.kitchenId,
      this.createrId,
      this.updaterId,
      this.code,
      this.createDate,
      this.updateDate,
      this.status});

  @override
  String toString() {
    return 'Menu(id: $id, kitchenId: $kitchenId, createrId: $createrId, updaterId: $updaterId, code: $code, createDate: $createDate, updateDate: $updateDate, status: $status)';
  }

  factory Menu.fromJson(dynamic json) => Menu(
        id: json['id'],
        kitchenId: json["kitchenId"],
        createrId: json['createrId'],
        updaterId: json['updaterId'],
        code: json['code'],
        createDate: DateTime.parse(json['createDate']),
        updateDate: DateTime.parse(json['updateDate']),
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
