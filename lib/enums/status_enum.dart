enum FooodStatus {
  active(1, 'Đang hoạt động'),
  blue(2, 'ngừng hoạt động'),
  delete(-1, 'Đã xóa');

  const FooodStatus(this.code, this.message);

  final int code;
  final String message;
}

enum OrderStatus {
  preparing(1, 'Đang chuẩn bị'),
  delivering(2, 'Đang giao'),
  completed(3, 'Đã hoàn thành'),
  cancelled(-1, 'Đã hủy');

  const OrderStatus(this.code, this.message);

  final int code;
  final String message;
}
// class OrderStatus {
//   static const preparing = OrderStatus._(1, 'Đang chuẩn bị');
//   static const delivering = OrderStatus._(2, 'Đang giao');
//   static const completed = OrderStatus._(3, 'Đã hoàn thành');
//   static const cancelled = OrderStatus._(-1, 'Đã hủy');

//   const OrderStatus._(this.code, this.message);

//   final int code;
//   final String message;
// }