import 'package:dio/dio.dart';
import 'package:get/get.dart' as getx;

import '/models/kitchen.dart';
import '/services/api_service.dart';

class KitchenService {
  final ApiService _apiService = getx.Get.put(ApiService());
  final String baseUrl = 'kitchens';

  Future<List<Kitchen>> getAll() async {
    final response = await _apiService.request.get(baseUrl);
    List<Kitchen> list = [];
    for (var e in response.data['data']) {
      list.add(Kitchen.fromJson(e));
    }
    return list;
  }

  Future<bool> create(Kitchen model) async {
    FormData formData = FormData.fromMap({
      'name': model.name,
      'address': model.address,
      'areaId': model.areaId,
      'image': MultipartFile.fromBytes(
        model.imageFile!.files.single.bytes!,
        filename: 'uploadFile.jpg',
      ),
    });
    Response response = await _apiService.request.post(baseUrl, data: formData);
    return response.statusCode == 201;
  }
}
