import 'package:dio/dio.dart';
import 'package:get/get.dart' as getx;

import '/models/school.dart';
import '/services/api_service.dart';

class SchoolService {
  final String baseUrl = 'schools';
  final ApiService _apiService = getx.Get.put(ApiService());

  Future<List<School>> getAll() async {
    var response = await _apiService.request.get(baseUrl);
    List<School> list = [];
    for (var e in response.data['data']) {
      list.add(School.fromJson(e));
    }
    return list;
  }

  Future<School> getById(String id) async {
    var response = await _apiService.request.get('$baseUrl/$id');
    return School.fromJson(response.data['data']);
  }

  Future<bool> create(School model) async {
    FormData formData = FormData.fromMap({
      'name': model.name,
      'address': model.address,
      'areaId': model.areaId,
      'image': MultipartFile.fromBytes(
        model.imageFile!.files.single.bytes!,
        filename: 'uploadFile.jpg',
      ),
    });
    for (int i = 0; i < model.locations!.length; i++) {
      formData.fields.addAll([
        MapEntry('Locations[$i][Name]', model.locations![i].name.toString()),
        MapEntry('Locations[$i][Description]',
            model.locations![i].description.toString()),
      ]);
      formData.files.add(MapEntry(
        'Locations[$i].image',
        MultipartFile.fromBytes(
          model.locations![i].imageFile!.files.single.bytes!,
          filename: 'uploadFileLocations[$i].jpg',
        ),
      ));
    }
    Response response = await _apiService.request.post(baseUrl, data: formData);
    return response.statusCode == 201;
  }
}
