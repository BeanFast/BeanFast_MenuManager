class BaseModel {
  String? id;
  int? status;

  BaseModel({this.id, this.status});

  factory BaseModel.fromJson(dynamic json) => BaseModel(
        id: json['id'],
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
