class Order {
  String? id;
  String? sessionDetailId;
  String? profileId;
  String? code;
  double? totalPrice;
  DateTime? paymentDate;
  DateTime? deliveryDate;
  int? rewardPoints;
  String? feedback;
  int? status;
  //SessionDetail
  //profile
  List<String>? orderDetailIds;
  List<String>? orderActivitieIds;

  Order(
      {this.id,
      this.sessionDetailId,
      this.profileId,
      this.code,
      this.totalPrice,
      this.paymentDate,
      this.deliveryDate,
      this.rewardPoints,
      this.feedback,
      this.status});

  factory Order.fromJson(dynamic json) => Order(
        id: json['id'],
        sessionDetailId: json["sessionDetailId"],
        profileId: json['profileId'],
        code: json['code'],
        totalPrice: json['totalPrice'],
        paymentDate: DateTime.parse(json['paymentDate']),
        deliveryDate: DateTime.parse(json['deliveryDate']),
        rewardPoints: json['rewardPoints'],
        feedback: json['feedback'],
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
