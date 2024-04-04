import 'package:beanfast_menumanager/controllers/auth_controller.dart';
import 'package:dio/dio.dart';
// import 'package:get/get.dart' hide Response;

import '/utils/logger.dart';

class AppInterceptor extends Interceptor with CacheManager {
  @override
  onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    logger.i('Custom Interceptor - onRequest');
    var token = getToken();
    if (token != null) {
      options.headers['Authorization'] = 'Bearer ' + token;
    } else {}
    return super.onRequest(options, handler);
  }

  @override
  onResponse(Response response, ResponseInterceptorHandler handler) {
    // Xử lý sau khi nhận được phản hồi
    logger.i('Custom Interceptor - onResponse');
    logger.i(response.toString());
    final status = response.statusCode;
    final isValid = status != null && status >= 200 && status < 300;
    if (!isValid) {
      // throw DioException.badResponse(
      //   statusCode: status!,
      //   requestOptions: response.requestOptions,
      //   response: response,
      // );
    }
    return super.onResponse(response, handler);
  }

  @override
  onError(DioException err, ErrorInterceptorHandler handler) {
    // Xử lý khi có lỗi
    logger.i('Custom Interceptor - onError');
    logger.i(err.message);
    handler.next(err);
    // if (err.response!.statusCode! >= 500) {
    //   logger.e('Server error');
    //   return super.onError(err, handler);
    // }
  }
}
