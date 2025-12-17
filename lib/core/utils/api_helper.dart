import 'package:dio/dio.dart';
import 'package:weathergeh_app/core/constants/api_constants.dart';

class ApiHelper {
  static Dio? _dio;

  static Dio get dio {
    _dio ??= _createDio();
    return _dio!;
  }

  static Dio _createDio() {
    final dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
        queryParameters: {
          'appid': ApiConstants.apiKey,
          'units': ApiConstants.unitsMetric,
        },
      ),
    );

    dio.interceptors.add(
      LogInterceptor(
        request: true,
        requestBody: true,
        responseBody: true,
        error: true,
        logPrint: (o) => print('[DIO] $o'),
      ),
    );

    return dio;
  }

  static Dio get geoDio {
    return Dio(
      BaseOptions(
        baseUrl: ApiConstants.geoUrl,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        queryParameters: {
          'appid': ApiConstants.apiKey,
        },
      ),
    );
  }
}
