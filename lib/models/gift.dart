import 'base_model.dart';
import 'exchange_gift.dart';

class Gift extends BaseModel {
  String? code;
  String? name;
  int? point;
  int? inStock;
  String? imagePath;
  List<ExchangeGift>? exchangeGifts;

  Gift({
    id,
    status,
    this.code,
    this.name,
    this.point,
    this.inStock,
    this.imagePath,
  });

  factory Gift.fromJson(dynamic json) => Gift(
        id: json['id'],
        code: json["code"],
        name: json['name'],
        point:
            json['points'] == null ? 0 : int.parse(json['points'].toString()),
        inStock:
            json['inStock'] == null ? 0 : int.parse(json['inStock'].toString()),
        imagePath: json['imagePath'] ?? "",
        status: json['status'],
      );
}
