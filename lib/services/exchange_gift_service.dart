import 'package:dio/dio.dart';
import 'package:get/get.dart' as getx;

import '/models/exchange_gift.dart';
import '/enums/status_enum.dart';
import '/services/api_service.dart';

class ExchangeGiftService {
  final String baseUrl = 'ExchangeGifts';
  final ApiService _apiService = getx.Get.put(ApiService());

  Future<List<ExchangeGift>> getByStatus(ExchangeGiftStatus status) async {
    final response = await _apiService.request.get(baseUrl,
        queryParameters: Map.from({"page": 1, "size": 100, 'status': status.code}));
    List<ExchangeGift> list = [];
    for (var e in response.data['data']['items']) {
      list.add(ExchangeGift.fromJson(e));
    }
    return list;
  }

  Future<bool> cancelExchangeGift(String exchangeGiftId, String reason) async {
    FormData formData = FormData.fromMap({
      'reason': reason,
    });
    Response response = await _apiService.request
        .put('$baseUrl/cancel/$exchangeGiftId', data: formData);
    return response.statusCode == 200;
  }

    Future<ExchangeGift> getById(String id) async {
    final response = await _apiService.request.get('$baseUrl/$id');
    ExchangeGift exchangeGift = ExchangeGift.fromJson(response.data['data']);
    return exchangeGift;
  }
}
