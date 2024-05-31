enum FooodStatus {
  active(1, 'Đang hoạt động'),
  blue(2, 'ngừng hoạt động'),
  delete(-1, 'Đã xóa');

  const FooodStatus(this.code, this.message);

  final int code;
  final String message;
}

enum ExchangeGiftStatus {
  preparing(1, 'Đang chuẩn bị'),
  delivering(4, 'Chờ giao hàng'),
  completed(5, 'Hoàn thành'),
  cancelled(6, 'Đã hủy');

  const ExchangeGiftStatus(this.code, this.message);

  final int code;
  final String message;

     static ExchangeGiftStatus fromInt(int code) {
    switch (code) {
      case 1:
        return ExchangeGiftStatus.preparing;
      case 4:
        return ExchangeGiftStatus.delivering;
      case 5:
        return ExchangeGiftStatus.completed;
      case 6:
        return ExchangeGiftStatus.cancelled;
      case 7:
        return ExchangeGiftStatus.cancelled;
      default:
        return ExchangeGiftStatus.preparing;
    }
  }
}

enum OrderStatus {
  preparing(2, 'Đang chuẩn bị'),
  cooking(3, 'Đang chế biến'),
  delivering(4, 'Chờ giao hàng'),
  completed(5, 'Hoàn thành'),
  cancelled(6, 'Đã hủy');

  const OrderStatus(this.code, this.message);

  final int code;
  final String message;

  static OrderStatus fromInt(int code) {
    switch (code) {
      case 2:
        return OrderStatus.preparing;
      case 3:
        return OrderStatus.cooking;
      case 4:
        return OrderStatus.delivering;
      case 5:
        return OrderStatus.completed;
      case 6:
        return OrderStatus.cancelled;
      case 7:
        return OrderStatus.cancelled;
      default:
        return OrderStatus.preparing;
    }
  }
}

enum SessionStatus {
  incomming,
  orderable,
  expired;
}
