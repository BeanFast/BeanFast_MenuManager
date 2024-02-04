enum Status {
  active(1, 'Đang hoạt động'),
  blue(2, 'ngừng hoạt động'),
  delete(-1, 'Đã xóa');

  const Status(this.code, this.message);

  final int code;
  final String message;
}
