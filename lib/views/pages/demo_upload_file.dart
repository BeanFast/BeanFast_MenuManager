import 'dart:html';
import 'package:beanfast_menumanager/utils/logger.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
import 'package:get/get.dart' as getx;
import 'package:dio/dio.dart';

import '../../services/api_service.dart';

class FileSelectionScreen extends StatelessWidget {
  const FileSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final FileSelectionController controller =
        getx.Get.put(FileSelectionController());
    return Scaffold(
      appBar: AppBar(title: Text('File Selection')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            getx.Obx(() {
              if (controller.selectedFile.value != null) {
                return Column(
                  children: [
                    Image.memory(
                      controller.selectedFile.value!.files.single.bytes!,
                      width: 200,
                      height: 200,
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        // Handle file upload here
                        controller.uploadFile();
                      },
                      child: Text('Upload File'),
                    ),
                  ],
                );
              } else {
                return ElevatedButton(
                  onPressed: () {
                    controller.selectFile();
                  },
                  child: Text('Select Image'),
                );
              }
            }),
          ],
        ),
      ),
    );
  }
}

class FileSelectionController extends getx.GetxController {
  final ApiService _apiService = getx.Get.put(ApiService());
  var selectedFile = getx.Rxn<FilePickerResult>();

  Future<void> selectFile() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: FileType.image);
    if (result != null) {
      selectedFile.value = result;
      update();
    } else {
      // User canceled the picker
    }
  }

  Future<void> uploadFile() async {
    if (selectedFile.value == null) {
      logger.e('No file selected');
      return;
    }

    try {
      FormData formData = FormData.fromMap({
        'name': 'model.name',
        'address': 'model.address',
        'areaId': '8A4F9C1D-3E0B-5A2C-7D6F-9E8C1B0A2D3E',
        // 'image': await MultipartFile.fromFile(selectedFile.value!.files.single.path!),
        'image': MultipartFile.fromBytes(
        await selectedFile.value!.files.single.bytes!,
        filename: selectedFile.value!.files.single.name,
      ),
      });
      int as1 = 1;
      Response response = await _apiService.request.post('kitchens', data: formData);
      logger.e('File uploaded successfully');
    } on DioException catch (e) {
      logger.e(e.response!.data['message']);
    }
  }
}
