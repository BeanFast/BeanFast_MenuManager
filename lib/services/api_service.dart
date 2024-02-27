import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '/interceptors/app_interceptor.dart';

class ApiService extends GetxService {
  // final String baseUrl;
  late Dio _dio;
  static BaseOptions options = BaseOptions(
      baseUrl: 'https://65dde6e6dccfcd562f55c399.mockapi.io/',
      headers: {
        Headers.contentTypeHeader: "application/json",
        Headers.acceptHeader: "text/plain"
      },
      sendTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 5));

  // ApiService(){
  //   _dio = Dio(options);
  //   _dio.interceptors.add(AppInterceptor());
  // }

  Dio get request {
    return _dio;
  }

  @override
  void onInit() {
    super.onInit();
    _dio = Dio(options);
    _dio.interceptors.add(AppInterceptor());
  }
}