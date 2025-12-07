import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../config/config.dart';

class DioClient {
  static Dio? _instance;

  static Dio get instance {
    _instance ??= _createDio();
    return _instance!;
  }
  static Dio _createDio() {
    final options = BaseOptions(
      baseUrl: AppConfig.instance.apiBaseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      sendTimeout: const Duration(seconds: 30),
      
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );

    final dio = Dio(options);
    if (kDebugMode) {
      dio.interceptors.add(
        LogInterceptor(
          requestBody: true,
          responseBody: true, 
          requestHeader: false,
          responseHeader: false,
          error: true,
          logPrint: (object) => print('📡 LOG: $object'),
        ),
      );
    }

    print('🔧 DioClient - Global instance oluşturuldu');
    return dio;
  }
  static void reset() {
    _instance = null;
    print('🔄 DioClient - Instance reset edildi');
  }
}