enum FooodStatus {
  active(1, 'Đang hoạt động'),
  blue(2, 'ngừng hoạt động'),
  delete(-1, 'Đã xóa');

  const FooodStatus(this.code, this.message);

  final int code;
  final String message;
}

enum ExchangeGiftStatus {
  preparing(1, 'Chờ chuẩn bị'),
  delivering(2, 'Chờ giao hàng'),
  completed(3, 'Hoàn thành'),
  cancelled(4, 'Đã hủy');

  const ExchangeGiftStatus(this.code, this.message);

  final int code;
  final String message;
}

enum OrderStatus {
  preparing(3, 'Đang chuẩn bị'),
  delivering(4, 'Đang giao'),
  completed(5, 'Đã hoàn thành'),
  cancelled(6, 'Đã hủy');

  const OrderStatus(this.code, this.message);

  final int code;
  final String message;
}

enum SessionStatus {
  incomming,
  orderable,
  expired;
}
