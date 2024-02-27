import 'package:beanfast_menumanager/views/pages/error_page.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response;

import '/utils/logger.dart';

class AppInterceptor extends Interceptor {
  @override
  onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // Xử lý trước khi gửi yêu cầu
    logger.i('Custom Interceptor - onRequest');
    return super.onRequest(options, handler);
  }

  @override
  onResponse(Response response, ResponseInterceptorHandler handler) {
    // Xử lý sau khi nhận được phản hồi
    logger.i('Custom Interceptor - onResponse');
    return super.onResponse(response, handler);
  }

  @override
  onError(DioException err, ErrorInterceptorHandler handler) {
    // Xử lý khi có lỗi
    logger.i('Custom Interceptor - onError');

    Get.offAll(const ErrorView(errorMessage: 'Đã xảy ra lỗi'));
    // if (err.response?.statusCode == 400 || err.response?.statusCode == 500) {
    //   // Xử lý lỗi 400 hoặc 500 ở đây
    //   print('Error ${err.response?.statusCode}: ${err.message}');

    //   // Điều hướng đến trang cụ thể trong GetX

    //   Get.off('/error_page');

    //   // Để ngăn chặn xử lý lỗi tiếp theo, không gọi handler.next(error);
    //   return;
    // }

    // Nếu không phải là lỗi mong muốn, chuyển tiếp xử lý đến interceptor khác (nếu có)

    return super.onError(err, handler);
  }
}
