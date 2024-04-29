import 'package:dio/dio.dart';

import '/controllers/auth_controller.dart';
import '/utils/logger.dart';

class AppInterceptor extends Interceptor with CacheManager {
  @override
  onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    logger.i('onRequest');
    String? token = getToken();
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    } else {}
    return super.onRequest(options, handler);
  }

  // @override
  // onResponse(Response response, ResponseInterceptorHandler handler) {
  //   logger.i('nResponse');
  //   // logger.i(response.toString());
  //   final status = response.statusCode;
  //   final isValid = status != null && status >= 200 && status < 300;
  //   if (!isValid) {
  //     // throw DioException.badResponse(
  //     //   statusCode: status!,
  //     //   requestOptions: response.requestOptions,
  //     //   response: response,
  //     // );
  //   }
  //   return super.onResponse(response, handler);
  // }

  @override
  onResponse(Response response, ResponseInterceptorHandler handler) {
    logger.i('onResponse');
    return super.onResponse(response, handler);
  }

  @override
  onError(DioException err, ErrorInterceptorHandler handler) {
    logger.e('onError - $err');

    if (err.response?.statusCode == 401) {
      logger.e('end - 401');
      // AuthController().checkLoginStatus();
    }

    return super.onError(err, handler);
  }
}
