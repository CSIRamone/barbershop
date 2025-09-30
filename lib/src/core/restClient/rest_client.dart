import 'package:dio/dio.dart';
import 'package:dio/io.dart';

final class RestClient extends DioForNative {
  RestClient()
      : super(BaseOptions(
          baseUrl: 'http://192.168.100.8:8080',
          connectTimeout: const Duration(seconds: 10),
          receiveTimeout: const Duration(seconds: 60),
        )) {
    // You can add interceptors, logging, or other configurations here
    interceptors.addAll([
      LogInterceptor(
        responseBody: true,
        requestBody: true,
      ),
    ]);
  }

  RestClient get auth {
    options.extra['DIO_AUTH_KEY'] = true;
    return this;
  }

  RestClient get unAuth {
    options.extra['DIO_AUTH_KEY'] = false;
    return this;
  }
}
